part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String displayName;
  final String email;
  final String password;

  SignUpRequested({
    required this.displayName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [displayName, email, password];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {}

class GoogleSignInRequested extends AuthEvent {}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  ForgotPasswordRequested({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}
