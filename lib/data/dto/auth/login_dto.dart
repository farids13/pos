class LoginDTO {
  String? email;
  String? password;
  String? deviceId;

  LoginDTO({
    this.email,
    this.password,
    this.deviceId,
  });
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "deviceId": deviceId,
    };
  }
}
