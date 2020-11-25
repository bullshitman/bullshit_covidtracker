import 'package:flutter/material.dart';
import 'package:bullshit_covidtracker/screens/Tracker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  runApp(EasyLocalization(
    child: MyApp(),
    path: 'assets/langs',
    saveLocale: true,
    supportedLocales: [Locale('ru', 'RU'), Locale('en', 'EN')],
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'main_title'.tr().toString(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: Tracker(),
    );
  }
}
