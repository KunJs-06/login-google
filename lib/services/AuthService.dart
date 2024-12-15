import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  static final auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signIn({required String email,required String password,}) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw Exception('Invalid Email & Password');
      } else {
        throw Exception( e.message.toString());
      }
    }
  }

  Future<User?> signUp({required String email,required String password,required String name}) async {
    try {
        await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
        await FirebaseAuth.instance.currentUser?.updateProfile(displayName: name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception( 'The account already exists for that email.');
      } else {
        throw Exception( e.message.toString());
      }
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception('Sign-in cancelled by user.');
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('logon google error :${e}');
      throw Exception(e.toString());
    }
  }

  Future<User?> signOut() async{
    try{
      await auth.signOut();
      await _googleSignIn.signOut();
    } catch (e){
      throw Exception(e);
    }
  }
}
