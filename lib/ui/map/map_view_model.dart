import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapViewModel extends ChangeNotifier {
  final Stream<QuerySnapshot?> homesCollection =
      FirebaseFirestore.instance.collection('homes').snapshots();
  final Completer<GoogleMapController> controller = Completer();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var myLocation = const LatLng(31.973130, 35.909665);
  Location location = Location();
  var pointer;
  List<LatLng> locations = [];
  Set<Marker> markers = {};

  getMyLocation() async {
    var serviceEnabled = await location.serviceEnabled();
    while (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    var permissionGranted = await location.hasPermission();
    while (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    if (permissionGranted == PermissionStatus.granted ||
        permissionGranted == PermissionStatus.grantedLimited) {
      var locationData = await location.getLocation();
      myLocation = LatLng(locationData.latitude!, locationData.longitude!);

      pointer = Marker(
        markerId: const MarkerId('current'),
        onTap: () {},
        position: myLocation,
      );
      markers.add(pointer);
      notifyListeners();
      var maps = await controller.future;
      maps.animateCamera(
        CameraUpdate.newLatLng(myLocation),
      );
    }
  }

  setMarkers(QuerySnapshot<Object?> data) {
    ///convert homes' geopoints to list of homes latlng objects
    for (var element in data.docs) {
      double lat = element['location'].latitude;
      double lng = element['location'].longitude;
      LatLng homePoint = LatLng(lat, lng);
      locations.add(homePoint);

      ///create marker for each home
      Marker marker = Marker(
          markerId: MarkerId(element.id),
          position: homePoint,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
              title: "${element['address']}",
              snippet: "${element['price']} / ${element['type']}"));
      markers.add(marker);
    }
  }
}
