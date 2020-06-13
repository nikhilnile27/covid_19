import 'dart:convert';

import 'package:covid19/datasource.dart';
import 'package:covid19/mosteffectedcountries.dart';
import 'package:covid19/panels/worldwidepanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchCountryData() async {
    http.Response response = await http.get('https://disease.sh/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  List sortcountrydata;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://disease.sh/v2/countries');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchWorldWideData();
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('COVID-19 TRACKER'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              height: 100,
              color: Colors.orange.shade100,
              child: Text(
                DataSource.quote,
                style: TextStyle(
                  color: Colors.orange.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Worldwide',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15)),
                      child: Text(
                        'Regional',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      ))
                ],
              ),
            ),
            worldData == null
                ? CircularProgressIndicator
                : WorldwidePanel(
                    worldData: worldData,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Most Affected Countries',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            countryData == null
                ? Container()
                : MostAffectedPanel(countryData: countryData),
          ],
        ),
      ),
    );
  }
}
