part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {}

class Loading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthenticationState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}