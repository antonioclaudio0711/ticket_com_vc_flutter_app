import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/model/counter_model.dart';
import 'package:ticket_com_vc_app/src/data/remote/list_of_participants/model/participant_model.dart';

class ListOfParticipantsModel {
  ListOfParticipantsModel({
    this.next,
    this.previous,
    required this.counters,
    required this.results,
  });

  final String? next;
  final String? previous;
  final CounterModel counters;
  final List<ParticipantModel> results;

  Map<String, dynamic> toJson() {
    return {
      "next": next,
      "previous": previous,
      "counters": counters.toJson(),
      "results": results
          .map(
            (participantModel) => participantModel.toJson(),
          )
          .toList(),
    };
  }

  factory ListOfParticipantsModel.fromJson(Map<String, dynamic> json) {
    return ListOfParticipantsModel(
      next: json["next"],
      previous: json["previous"],
      counters: CounterModel.fromJson(json["counters"]),
      results: (json["results"] as List)
          .map(
            (participant) => ParticipantModel.fromJson(participant),
          )
          .toList(),
    );
  }
}
