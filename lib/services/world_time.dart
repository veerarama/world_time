import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; //location name for UI
  String time;  //time in that location
  String flag;  //url to asset flag icon
  String url;   //location url api endpoint
  bool isDayTime; //true or fals eif day or not

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{

    try{
      Response responce = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(responce.body);
      //print(data);

      //get properties from data

      String datetime = data['datetime'];
      String offset_hour = data['utc_offset'].substring(1,3);
      String offset_min = data['utc_offset'].substring(4,6);
      //print(datetime);
      //print(offset_min);

      //date time object

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset_hour), minutes:int.parse(offset_min) ));
      //print(now);

      //set time property
      isDayTime = now.hour> 6 && now.hour < 19? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error: $e');
      time ='could not get time data';
    }
  }

}