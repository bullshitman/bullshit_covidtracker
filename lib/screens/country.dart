import 'package:bullshit_covidtracker/screens/country_loading.dart';
import 'package:bullshit_covidtracker/screens/global.dart';
import 'package:flutter/material.dart';
import '../services/covid_services.dart';
import '../models/country.dart';
import '../models/country_summary.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../screens/county_statistics.dart';
import 'package:easy_localization/easy_localization.dart';

CovidServise covidService = CovidServise();

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  Future<List<CountryModel>> countryList;
  Future<List<CountrySummaryModel>> summaryList;
  final TextEditingController _typeAheadController = TextEditingController();

  List<String> _getSuggestions(List<CountryModel> list, String query) {
    List<String> matches = List();
    for (var item in list) {
      matches.add(item.country);
    }
    matches.retainWhere(
        (element) => element.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  void initState() {
    super.initState();
    countryList = covidService.getCountryList();
    summaryList = covidServise.getCountrySummary("russia");
    this._typeAheadController.text = "Russian Federation";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: countryList,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('error'.tr().toString()),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CountryLoading(inputTextLoading: true);
          default:
            return !snapshot.hasData
                ? Center(
                    child: Text('empty'.tr().toString()),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        child: Text(
                          'country_name'.tr().toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: _typeAheadController,
                          //clear text for better user xp
                          onTap: () => _typeAheadController.clear(),          
                          decoration: InputDecoration(
                            hintText: 'country_name_input'.tr().toString(),
                            hintStyle: TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.all(20),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 24, right: 16),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                             
                        suggestionsCallback: (pattern) {
                          return _getSuggestions(snapshot.data, pattern);
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        transitionBuilder:
                            (context, suggestionBox, controller) {
                          return suggestionBox;
                        },
                        onSuggestionSelected: (suggestion) {
                          this._typeAheadController.text = suggestion;
                          setState(() {
                            summaryList = covidService.getCountrySummary(snapshot.data.firstWhere((element) => element.country == suggestion).slug);
                          });
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FutureBuilder(
                        future: summaryList,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('error'.tr().toString()));
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return CountryLoading(inputTextLoading: false);
                            default:
                              return !snapshot.hasData
                                  ? Center(
                                      child: Text('empty'.tr().toString()),
                                    )
                                  : CountryStatistics(
                                    summaryList: snapshot.data,
                                  );
                          }
                        },
                      ),
                    ],
                  );
        }
      },
    );
  }
}
