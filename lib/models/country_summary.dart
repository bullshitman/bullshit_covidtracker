class CountrySummaryModel {
  final String country;
  final int confirmed;
  final int deaths;
  final int recovered;
  final int active;
  final DateTime date;

  CountrySummaryModel(this.country, this.confirmed, this.deaths, this.recovered,
      this.active, this.date);

  factory CountrySummaryModel.fromJson(Map<String, dynamic> json) {
    return CountrySummaryModel(
      json["Country"], 
      json["Confirmed"], 
      json["Deaths"],
      json["Recovered"], 
      json["Active"], 
      DateTime.parse(json["Date"])
      );
  }
}
