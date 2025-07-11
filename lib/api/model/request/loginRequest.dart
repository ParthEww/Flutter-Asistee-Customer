class LoginRequest {
  String userName;
  String password;
  String deviceToken;
  String deviceType;

  LoginRequest(
      {required this.userName,
      required this.password,
      required this.deviceToken,
      required this.deviceType});
}
