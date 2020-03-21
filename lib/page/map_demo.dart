import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapDemo extends StatefulWidget {
  @override
  _MapDemoState createState() => _MapDemoState();
}

class _MapDemoState extends State<MapDemo> {
  Position _currentPosition;
  String _currentAddress;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _currentPosition != null ?  Text(_currentAddress) :
                Text("Your Address"),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                // Get location here
                _getCurrentLocation();
              },
            ),
          ],
        ),
      );

  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.subAdministrativeArea}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
}
