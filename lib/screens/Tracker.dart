import 'package:bullshit_covidtracker/screens/country.dart';
import 'package:bullshit_covidtracker/screens/global.dart';
import 'package:flutter/material.dart';
import 'global.dart';
import 'country.dart';
import '../utils/constants.dart';
import 'navigation_options.dart';
import 'package:easy_localization/easy_localization.dart';

enum NavigationStatus {
  GLOBAL,
  COUNTRY,
}

class Tracker extends StatefulWidget {
  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  NavigationStatus navigationStatus = NavigationStatus.GLOBAL;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: mPrimaryColor,
        elevation: 0,
        title: Text('title'.tr().toString()),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: mPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
              ),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: navigationStatus == NavigationStatus.GLOBAL ? Global() : Country(), 
              ),
            ),
          ),
          Container(
            height: size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                NavigationOption(
                  title: "global".tr().toString(), 
                  selected: navigationStatus == NavigationStatus.GLOBAL, 
                  onSelected: () {
                    setState(() {
                      navigationStatus = NavigationStatus.GLOBAL;
                    });
                  }
                ),
                NavigationOption(
                  title: "country".tr().toString(), 
                  selected: navigationStatus == NavigationStatus.COUNTRY, 
                  onSelected: () {
                    setState(() {
                      navigationStatus = NavigationStatus.COUNTRY;
                    });
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
