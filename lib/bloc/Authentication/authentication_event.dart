part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];

}

class SignInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  SignInRequested({
    required this.email,
    required this.password
  });
}

class SignUpRequested extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;

  SignUpRequested(this.email, this.password,this.name);
}

class GoogleSignInRequested extends AuthenticationEvent {}

class SignOutRequested extends AuthenticationEvent {

}