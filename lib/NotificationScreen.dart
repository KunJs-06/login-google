import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String? _messageTitle = "ไม่มีการแจ้งเตือน";
  String? _messageBody = "รอรับข้อความ...";

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // ขออนุญาตแสดง Notifications
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Permission granted!");

      // ฟังการแจ้งเตือนขณะเปิดแอป
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        setState(() {
          _messageTitle = message.notification?.title ?? "ไม่มีหัวข้อ";
          _messageBody = message.notification?.body ?? "ไม่มีเนื้อหา";
        });
        print('Message received: ${message.notification?.title}, ${message.notification?.body}');
      });
    } else {
      print("Permission denied!");
    }

    // รับ Token ของอุปกรณ์
    String? token = await messaging.getToken();
    print("FCM Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Notifications')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'หัวข้อข้อความ:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(_messageTitle ?? ""),
            SizedBox(height: 10),
            Text(
              'เนื้อหาข้อความ:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(_messageBody ?? ""),
          ],
        ),
      ),
    );
  }
}