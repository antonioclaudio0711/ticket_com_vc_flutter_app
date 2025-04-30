class EventModel {
  EventModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.startDatetime,
    required this.endDateTime,
    required this.address,
    required this.horizontalCover,
    required this.verticalCover,
    required this.space,
    required this.parsedData,
    required this.isClosed,
    this.actuationIsActivated = false,
  });

  final String id;
  final String name;
  final String slug;
  final String startDatetime;
  final String endDateTime;
  final String address;
  final String horizontalCover;
  final String verticalCover;
  final String space;
  final Map<String, dynamic> parsedData;
  final bool isClosed;
  bool actuationIsActivated;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "slug": slug,
      "start_datetime": startDatetime,
      "end_datetime": endDateTime,
      "address": address,
      "id": id,
      "cover_horizontal": horizontalCover,
      "cover_vertical": verticalCover,
      "space": space,
      "parsed_data": parsedData,
      "is_closed": isClosed,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
      startDatetime: json["start_datetime"] ?? "",
      endDateTime: json["end_datetime"] ?? "",
      address: json["address"] ?? "",
      horizontalCover: json["cover_horizontal"] ?? "",
      verticalCover: json["cover_vertical"] ?? "",
      space: json["space"] ?? "",
      parsedData: json["parsed_data"] ?? {},
      isClosed: json["is_closed"] ?? false,
    );
  }
}
