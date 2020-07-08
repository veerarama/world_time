import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:worldtime/services/world_time1.dart';


class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  Completer<GoogleMapController> _controller = Completer();


  static const LatLng _center = const LatLng(25.57060228866895, 85.09804543107748);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final Set<Marker> _markers = {};
  List<Marker> myMarker =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Location'),
        backgroundColor: Colors.blueAccent,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 1.0,
        ),
        markers: Set.from(myMarker),
        onTap: (LatLng s) {
          print("object  $s" );
          _handleTap(s);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }

  void _handleTap(LatLng tappedPoint){
    setState(() {
      myMarker =[];
      myMarker.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint
        )
      );
    });
    setUpWorldTime(tappedPoint);
  }

  void setUpWorldTime(LatLng tappedPoint) async {
    WorldTime1 instance = WorldTime1(latLng: tappedPoint);
    await instance.getTime1();
    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'location' :instance.location,
      'flag' : instance.flag,
      'time' : instance.time,
      'isDayTime' : instance.isDayTime
    });
  }

}

