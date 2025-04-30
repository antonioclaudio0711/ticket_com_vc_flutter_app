class LoginModel {
  LoginModel({
    required this.refreshToken,
    required this.accessToken,
    required this.isStaff,
  });

  final String refreshToken;
  final String accessToken;
  final bool isStaff;

  Map<String, dynamic> toJson() {
    return {
      "refresh": refreshToken,
      "access": accessToken,
      "is_staff": isStaff,
    };
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      refreshToken: json["refresh"] ?? "",
      accessToken: json["access"] ?? "",
      isStaff: json["is_staff"] ?? false,
    );
  }
}
