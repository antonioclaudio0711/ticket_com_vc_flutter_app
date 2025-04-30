class UserModel {
  UserModel({
    required this.fullName,
    required this.email,
    required this.document,
  });

  final String fullName;
  final String email;
  final String document;

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "email": email,
      "document": document,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json["full_name"] ?? "",
      email: json["email"] ?? "",
      document: json["document"] ?? "",
    );
  }

  factory UserModel.empty() {
    return UserModel(
      fullName: "",
      email: "",
      document: "",
    );
  }
}
