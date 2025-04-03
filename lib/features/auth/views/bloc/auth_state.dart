part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class Authenticated extends AuthState {
  final String displayName;

  Authenticated({
    required this.displayName,
  });

  @override
  List<Object?> get props => [displayName];
}

class Unauthenticated extends AuthState {
  final dynamic userData;

  Unauthenticated({
    this.userData,
  });

  @override
  List<Object?> get props => [userData];
}

class PasswordResetSuccess extends AuthState {
  final String message;

  PasswordResetSuccess({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
