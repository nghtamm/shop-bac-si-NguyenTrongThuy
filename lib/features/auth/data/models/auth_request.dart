class AuthenticationRequest {
  final String? displayName;
  final String email;
  final String password;

  AuthenticationRequest({
    this.displayName,
    required this.email,
    required this.password,
  });
}