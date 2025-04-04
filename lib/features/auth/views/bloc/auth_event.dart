part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserValidated extends AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String lastName;
  final String firstName;
  final String displayName;
  final String email;
  final String password;
  final String userLogin;
  final String userNicename;
  final Completer<void>? completer;

  SignUpRequested({
    required this.lastName,
    required this.firstName,
    required this.displayName,
    required this.email,
    required this.password,
    required this.userLogin,
    required this.userNicename,
    this.completer,
  });

  @override
  List<Object?> get props => [
        lastName,
        firstName,
        displayName,
        email,
        password,
        userLogin,
        userNicename,
        completer,
      ];
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

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  ForgotPasswordRequested({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}

class GoogleSignInRequested extends AuthEvent {}
