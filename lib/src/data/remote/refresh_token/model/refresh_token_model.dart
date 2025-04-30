class RefreshTokenModel {
  RefreshTokenModel({
    required this.refreshToken,
    required this.accessToken,
  });

  final String refreshToken;
  final String accessToken;

  Map<String, dynamic> toJson() {
    return {
      "refresh": refreshToken,
      "access": accessToken,
    };
  }

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenModel(
      refreshToken: json["refresh"] ?? "",
      accessToken: json["access"] ?? "",
    );
  }
}
