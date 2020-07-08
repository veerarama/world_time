import 'package:flutter/material.dart';
import 'package:worldtime/Pages/home.dart';
import 'package:worldtime/Pages/loading.dart';
import 'package:worldtime/Pages/choose_location.dart';
import 'package:worldtime/Pages/maps.dart';

void main() {
  runApp(MaterialApp(
    //home: Home(),
    initialRoute: '/',
    routes: {
      '/':(context) =>Loading(),
      '/home':(context) =>Home(),
      '/location' : (context) => ChooseLocation(),
      '/maps' : (context) => Maps()
    },
  ));
}

