import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_home/ui/map/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mapData = Provider.of<MapViewModel>(context);

    ///get my location
    mapData.getMyLocation();
    return StreamBuilder<QuerySnapshot?>(
        stream: mapData.homesCollection,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ///set markers for each home
            mapData.setMarkers(snapshot.data!);
            return Scaffold(
              key: mapData.scaffoldKey,
              appBar: AppBar(
                title: const Text(
                  'Homes',
                ),
              ),
              body: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: mapData.myLocation,
                  zoom: 10,
                ),
                zoomControlsEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapToolbarEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  mapData.controller.complete(controller);
                },
                markers: mapData.markers,
              ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }
        });
  }
}
