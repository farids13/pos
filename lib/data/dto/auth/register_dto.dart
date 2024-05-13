class RegisterDTO {
  String? email;
  String? password;
  String? phoneNumber;
  String? userName;
  String? firstName;
  String? lastName;

  RegisterDTO({
    this.email,
    this.password,
    this.phoneNumber,
    this.userName,
    this.firstName,
    this.lastName,
  });

  factory RegisterDTO.fromJson(Map<String, dynamic> json) {
    return RegisterDTO(
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['phoneNumber'] = phoneNumber;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}
