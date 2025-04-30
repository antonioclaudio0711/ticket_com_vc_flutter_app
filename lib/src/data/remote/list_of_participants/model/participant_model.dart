import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/model/user_model.dart';

class ParticipantModel {
  ParticipantModel({
    this.code,
    required this.user,
    required this.status,
    required this.checked,
  });

  final String? code;
  final UserModel user;
  final String status;
  final bool checked;

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "user": user.toJson(),
      "status": status,
      "checked": checked,
    };
  }

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      code: json["code"] ?? "Código do ingresso não disponível",
      user: UserModel.fromJson(json["user"]),
      status: json["status"],
      checked: json["checked"],
    );
  }
}
