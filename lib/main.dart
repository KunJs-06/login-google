import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_google/HomePage.dart';
import 'package:login_google/LoginPage.dart';
import 'package:login_google/NotificationScreen.dart';
import 'package:login_google/bloc/Authentication/authentication_bloc.dart';
import 'package:login_google/bloc/pokemon_list/pokemon_bloc.dart';
import 'package:login_google/services/AuthService.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ฟังก์ชันนี้เรียกใช้เมื่อมีการแจ้งเตือนใน background
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers:[
        RepositoryProvider(
          create: (context) => AuthService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthenticationBloc(
                authService: RepositoryProvider.of<AuthService>(context),
              )
          ),
          BlocProvider(create: (context) => PokemonBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return LoginPage();
                }
                return LoginPage();
              }),
        ),
      ),
    );
  }
}
