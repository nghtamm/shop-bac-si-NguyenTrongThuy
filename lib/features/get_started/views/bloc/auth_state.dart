abstract class AuthenticationState {}

class AuthenticationInitialize extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String displayName;

  Authenticated(this.displayName);

  Map<String, dynamic> toJson() => {'displayName': displayName};

  static Authenticated fromJson(Map<String, dynamic> json) {
    return Authenticated(json['displayName']);
  }
}

class NotAuthenticated extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String message;

  AuthenticationError(this.message);
}
