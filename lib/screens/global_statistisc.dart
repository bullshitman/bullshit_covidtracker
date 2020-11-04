import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/global_summary.dart';
import 'package:timeago/timeago.dart' as timeago;

class GlobalStatistics extends StatelessWidget {
  final GlobalSummaryModel summary;
  //constructor
  GlobalStatistics({@required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildCard(
          "Confirmed",
          summary.totalConfirmed,
          summary.newConfirmed,
          mConfirmedColor,
        ),
        buildCard(
          "Active",
          summary.totalConfirmed - summary.totalRecovered - summary.totalDeaths,
          summary.newConfirmed - summary.newRecovered - summary.newDeaths,
          mActiveColor,
        ),
        buildCard(
          "Recovered",
          summary.totalRecovered,
          summary.newRecovered,
          mRecoveredColor,
        ),
        buildCard(
          "Dead",
          summary.totalDeaths,
          summary.newDeaths,
          mDeathColor,
        ),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            "Statistics updated " + timeago.format(summary.date),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCard(String title, int totalCount, int todayCount, Color color) {
    return Card(
      elevation: 1,
      child: Container(
        //some devices can't render update info, so we will shrink this height
        height: 92,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      totalCount.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Today",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      todayCount.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
