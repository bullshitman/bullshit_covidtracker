import 'package:bullshit_covidtracker/models/time_series.dart';
import 'package:bullshit_covidtracker/screens/chart.dart';
import 'package:flutter/material.dart';
import '../models/country_summary.dart';
import '../utils/constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CountryStatistics extends StatelessWidget {
  final List<CountrySummaryModel> summaryList;
  //constructor
  CountryStatistics({@required this.summaryList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildCard(
          "Confirmed", 
          summaryList[summaryList.length - 1].confirmed, 
          mConfirmedColor, 
          "Active", 
          summaryList[summaryList.length - 1].active, 
          mActiveColor),
        buildCard(
          "Recovered", 
          summaryList[summaryList.length - 1].recovered, 
          mRecoveredColor, 
          "Dead", 
          summaryList[summaryList.length - 1].deaths, 
          mDeathColor),
          buildCardChart(summaryList),  
      ],
      
    );
  }
  //widget for statistics
  Widget buildCard(String leftTitle, int leftValue, Color leftColor, String rightTitle, int rightValue, Color rightColor) {
        return Card(
          elevation: 1,
          child: Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      leftTitle,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      "Total",
                      style: TextStyle(
                        color: leftColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      leftValue.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        color: leftColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      rightTitle,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      "Total",
                      style: TextStyle(
                        color: rightColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      rightValue.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        color: rightColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }

  //widget for chart
  Widget buildCardChart(List<CountrySummaryModel> summaryList) {
    return Card(
      elevation: 1,
      child: Container(
        height: 140,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Chart(
          _createData(summaryList),
          animate: false,
        ),
      ),
    );
  }

  //create data for statistics and period from summary info
  static List<charts.Series<TimeSeriesCases, DateTime>> _createData(List<CountrySummaryModel> summaryList) {
    List<TimeSeriesCases> confirmedData = [];
    List<TimeSeriesCases> activeData = [];
    List<TimeSeriesCases> recoveredData = [];
    List<TimeSeriesCases> deadData = [];
    for (var item in summaryList) {
      confirmedData.add(TimeSeriesCases(item.date, item.confirmed));
      activeData.add(TimeSeriesCases(item.date, item.active));
      recoveredData.add(TimeSeriesCases(item.date, item.recovered));
      deadData.add(TimeSeriesCases(item.date, item.deaths));
    }
    return [
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Confirmed',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(mConfirmedColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: confirmedData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Active',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(mActiveColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: activeData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Recovered',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(mRecoveredColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: recoveredData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Dead',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(mDeathColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: deadData,
      ),
    ];
  }

}
