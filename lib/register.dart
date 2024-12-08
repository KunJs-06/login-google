import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_google/HomePage.dart';
import 'package:login_google/LoginPage.dart';
import 'package:login_google/bloc/Authentication/authentication_bloc.dart';
import 'package:login_google/services/AuthService.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  AuthService authService = AuthService();

  String? _emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'กรุณากรอก email ';
    } else if (EmailValidator.validate(value) == false) {
      return 'กรุณาใส่ email ให้ถูกต้อง';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'กรุณากรอก password';
    }
    return null;
  }

  String? _nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'กรุณากรอก ชื่อ-นามสลุก';
    }
    return null;
  }


  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context).add(
        SignUpRequested(
          emailController.text,
          passwordController.text,
          nameController.text
        ),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthenticationBloc>(context).add(
      GoogleSignInRequested(),
    );
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                }
                if (state is AuthError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is Loading) {
                  return const Center(child: CircularProgressIndicator());
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
                                  "สมัครสมาชิก",
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
                                          controller: nameController,
                                          decoration: const InputDecoration(
                                            hintText: "Name",
                                            border: OutlineInputBorder(),
                                          ),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          validator: _nameValidator,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
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
                                                ? 'Enter a valid email'
                                                : null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: passwordController,
                                          decoration: const InputDecoration(
                                            hintText: "Password",
                                            border: OutlineInputBorder(),
                                          ),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            return value != null && value.length < 6
                                                ? "Enter min. 6 characters"
                                                : null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 12,
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
                                              _createAccountWithEmailAndPassword(
                                                  context);
                                            },
                                            child: const Text('ตกลง',style: TextStyle(color: Colors.black),),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
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
                                      _authenticateWithGoogle(context);
                                    },
                                    child:Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/google.png',width: 25,),
                                          const SizedBox(width: 5,),
                                          const Text("สมัครสมาชิกด้วย Google",style: TextStyle(color: Colors.black))
                                        ]
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  child: TextButton(

                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const LoginPage()),
                                      );
                                    },
                                    child: const Text("ย้อนกลับ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.underline
                                      ),
                                    ),
                                  ),
                                ),
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
            );
          }
      ),
    );
  }
}

