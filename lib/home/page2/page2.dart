import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class page2Home extends StatefulWidget {
  const page2Home({Key? key}) : super(key: key);
  static String address = "";
  @override
  State<page2Home> createState() => _page2HomeState();
}

class _page2HomeState extends State<page2Home> {
  @override
  double? lat;

  double? long;



  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) {
      print("value $value");
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });

      getAddress(value.latitude, value.longitude);
      _openMap(value.latitude, value.longitude);
    }).catchError((error) {
      print("Error $error");
    });
  }
  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    setState(() {
      page2Home.address = placemarks[0].street! + " " + placemarks[0].country!;
    });

    for (int i = 0; i < placemarks.length; i++) {
      print("INDEX $i ${placemarks[i]}");
    }
  }
  Future<void> _openMap(lat, long)async{
    String googleURL=
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
      await canLaunchUrlString(googleURL)
      ?await launchUrlString(googleURL)
          :throw'Could not launch$googleURL';
  }


  Widget build(BuildContext context) {
    return Container(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(padding:EdgeInsets.symmetric(horizontal: 10),child: Text("Location Address",style: TextStyle(color:Colors.red,fontSize: 16,fontWeight: FontWeight.bold),)),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 100,vertical: 30),
              decoration: BoxDecoration(
                color: Colors.yellow,
                border:Border.all(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
                child: Text("Address : ${page2Home.address} ")),
              SizedBox(height: 20,),
            Center(
            child: ElevatedButton(
            onPressed: getLatLong,
            child: const Text("Get Location"),
            style: ElevatedButton.styleFrom(
            primary: const Color(0xFF0D39F2),
            ),
            ),
          ),


      ],
      )
    );
  }
}
