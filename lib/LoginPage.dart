import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_google/HomePage.dart';
import 'package:login_google/bloc/Authentication/authentication_bloc.dart';
import 'package:login_google/models/user.dart';
import 'package:login_google/register.dart';
import 'package:login_google/services/AuthService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  UserName user = UserName();

  AuthService authService = AuthService();

  final formKey = GlobalKey<FormState>();

  String? _passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'กรุณากรอก password';
    }
    return null;
  }

  void _authenticateWithEmailAndPassword(context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context).add(
        SignInRequested(email: emailController.text, password: passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthenticationBloc>(context).add(
      GoogleSignInRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/pokemon-icon.png',width: 50,),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "เข้าสู่ระบบ",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Center(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        hintText: "Email",
                                        border: OutlineInputBorder(),
                                      ),
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        return value != null &&
                                            !EmailValidator.validate(value)
                                            ? 'กรุณากรอก email'
                                            : null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: passwordController,
                                        decoration: const InputDecoration(
                                          hintText: "Password",
                                          border: OutlineInputBorder(),
                                        ),
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        validator: _passwordValidator
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const Register()),
                                          );
                                        },
                                        child: const Text("สมัครสมชิก",
                                          style: TextStyle(
                                              color: Colors.black,
                                              decoration: TextDecoration.underline
                                          ),),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.55,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                            side: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          _authenticateWithEmailAndPassword(context);
                                        },
                                        child: const Text('เข้าสู่ระบบ',style: TextStyle(color: Colors.black),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  _authenticateWithGoogle(context);
                                },
                                child:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/google.png',width: 25,),
                                      const SizedBox(width: 5,),
                                      const Text("เข้าสู่ระบบด้วย Google",style: TextStyle(color: Colors.black))
                                    ]
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
