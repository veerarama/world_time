import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WorldTime1{

  String location; //location name for UI
  String time;  //time in that location
  String flag;  //url to asset flag icon
  String url;   //location url api endpoint
  bool isDayTime; //true or false eif day or not
  LatLng latLng;  //lat long of tapped point

  WorldTime1({this.latLng});

  Future<void> getTime1() async{

    double lat = latLng.latitude;
    double lng = latLng.longitude;

    try{
      Response responce = await get('http://api.timezonedb.com/v2.1/get-time-zone?key=MU0L2HWPEYRZ&format=json&by=position&lat=$lat&lng=$lng');
      Map data = jsonDecode(responce.body);
      //print(data);

      //get properties from data

      String datetime = data['formatted'];
      location = data['zoneName'];
      flag = "india.png";

      //print(datetime);
     // print(location);
      //print(offset_min);

      //date time object

      DateTime now = DateTime.parse(datetime);
      //now = now.add(Duration(hours: int.parse(offset_hour), minutes:int.parse(offset_min) ));
      print(now);

      //set time property
      isDayTime = now.hour> 6 && now.hour < 19? true : false;
      time = DateFormat.jm().format(now);
      print(time);
    }
    catch(e){
      print('caught error: $e');
      time ='could not get time data';
    }
  }

}