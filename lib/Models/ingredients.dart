class Trip {
  String title;
  DateTime startDate;
  DateTime endDate;
  DateTime eatDate;
  double budget;
  String travelType;

  Trip(this.title, this.startDate, this.endDate, this.eatDate, this.budget,
      this.travelType);

  Map<String, dynamic> toJson() => {
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'eatDate': eatDate,
        'budget': budget,
        'travelType': travelType,
      };
}
