class LoginGoogleDto {
  String? accessToken;
  String? deviceId;

  LoginGoogleDto({
    this.accessToken,
    this.deviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      "token": accessToken,
      "deviceId": deviceId,
    };
  }
}
