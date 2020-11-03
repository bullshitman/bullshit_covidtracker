import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Tracker extends StatefulWidget {
  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar:  AppBar(
        backgroundColor: mPrimaryColor,
        elevation: 0,
        title: Text("Covid-19 tracker live data"),
        centerTitle: true,
      )
    );
  }
}
