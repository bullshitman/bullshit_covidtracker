import 'package:flutter/material.dart';
import '../services/covid_services.dart';
import '../models/global_summary.dart';
import 'global_statistisc.dart';
import 'global_loading.dart';
import 'package:easy_localization/easy_localization.dart';

CovidServise covidServise = CovidServise();

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
  Future<GlobalSummaryModel> summary;

  @override
  void initState() {
    super.initState();
    summary = covidServise.getGlobalSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'main_title'.tr().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    summary = covidServise.getGlobalSummary();
                  });
                },
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: summary,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('error'.tr().toString()),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return GlobalLoading();
              default:
                return !snapshot.hasData
                    ? Center(
                        child: Text('empty'.tr().toString()),
                      )
                    : GlobalStatistics(
                      summary: snapshot.data,
                    );
            }
          },
        ),
      ],
    );
  }
}
