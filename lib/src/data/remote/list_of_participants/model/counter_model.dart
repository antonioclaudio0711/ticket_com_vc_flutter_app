class CounterModel {
  CounterModel({
    required this.totalTickets,
    required this.remainingTickets,
    required this.checkedTickets,
  });

  int totalTickets;
  int remainingTickets;
  int checkedTickets;

  Map<String, dynamic> toJson() {
    return {
      "total_tickets": totalTickets,
      "remaining_tickets": remainingTickets,
      "checked_tickets": checkedTickets,
    };
  }

  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(
      totalTickets: json["total_tickets"] ?? 0,
      remainingTickets: json["remaining_tickets"] ?? 0,
      checkedTickets: json["checked_tickets"] ?? 0,
    );
  }
}
