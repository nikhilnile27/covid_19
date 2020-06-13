import 'package:covid19/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'SourceSansPro',
      primaryColor: Colors.black,
    ),
    home: HomePage(),
  ));
}
