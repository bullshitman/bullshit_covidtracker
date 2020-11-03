class GlobalSummaryModel {
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeath;
  final int totalDeath;
  final int newRecovered;
  final int totalRecovered;
  final DateTime date;

  GlobalSummaryModel(this.newConfirmed, this.totalConfirmed, this.newDeath,
      this.totalDeath, this.newRecovered, this.totalRecovered, this.date);

  factory GlobalSummaryModel.fromJson(Map<String, dynamic> json) {
    return GlobalSummaryModel(
        json["Global"]["NewConfirmed"],
        json["Global"]["TotalConfirmed"],
        json["Global"]["NewDeaths"],
        json["Global"]["totalDeath"],
        json["Global"]["newRecovered"],
        json["Global"]["totalRecovered"],
        DateTime.parse(json["Date"])
        );
  }
}
