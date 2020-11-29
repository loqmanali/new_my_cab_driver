import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/pickup/clinent_trip.dart';

import 'package:my_cab_driver/providers/directionDetails.dart';
import 'package:my_cab_driver/providers/drvier_to_client_trip.dart';

import 'package:provider/provider.dart';
import '../appTheme.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:geolocator/geolocator.dart';

class DriverToClientTrip extends StatefulWidget {
  final double clientLat, clientLong;
  DriverToClientTrip(
      {this.clientLat = 30.4761909, this.clientLong = 31.0361089});
  @override
  _DriverToClientTripState createState() => _DriverToClientTripState();
}

class _DriverToClientTripState extends State<DriverToClientTrip> {
  GoogleMapController mapController;

  List<LatLng> polyLineCoordinates = [];
  Set<Polyline> _polyLines = {};
  Set<Marker> _markers = {};

  StreamSubscription<Position> driverMoving;
  double myLat = 0.0;
  double myLong = 0.0;
  Future getPolyLineDetails() async {
    setState(() {
      myLat = Provider.of<DriverToClient>(context, listen: false).startLat;
      myLong = Provider.of<DriverToClient>(context, listen: false).startLong;
    });

    await DirectionDetailsInfo.getDirectionDriverTrip(
      startPosition: LatLng(30.4761909, 31.0361089),
      endPosition: LatLng(widget.clientLat, widget.clientLong),
      context: context,
    );
    PolylinePoints polyLinePoints = PolylinePoints();
    String points = Provider.of<DriverToClient>(context, listen: false).points;
    polyLineCoordinates.clear();
    List<PointLatLng> results = polyLinePoints.decodePolyline(points);
    if (results.isNotEmpty) {
      results.forEach((element) {
        polyLineCoordinates.add(
          LatLng(element.latitude, element.longitude),
        );
      });
    }
    _polyLines.clear();
    setState(() {
      Polyline polyLine = Polyline(
        polylineId: PolylineId("polyId"),
        color: Colors.blue,
        points: polyLineCoordinates,
        width: 4,
      );
      _polyLines.add(polyLine);
    });
    LatLngBounds bounds;
    if (myLat > widget.clientLat && myLong > widget.clientLong) {
      bounds = LatLngBounds(
        southwest: LatLng(widget.clientLat, widget.clientLong),
        northeast: LatLng(myLat, myLong),
      );
    } else if (myLong > widget.clientLong) {
      bounds = LatLngBounds(
        southwest: LatLng(myLat, widget.clientLong),
        northeast: LatLng(widget.clientLat, myLong),
      );
    } else if (myLat > widget.clientLat) {
      bounds = LatLngBounds(
        southwest: LatLng(widget.clientLat, myLong),
        northeast: LatLng(myLat, widget.clientLong),
      );
    } else {
      bounds = LatLngBounds(
        southwest: LatLng(myLat, myLong),
        northeast: LatLng(widget.clientLat, widget.clientLong),
      );
    }

    Marker myMarker = Marker(
      markerId: MarkerId("My Location"),
      draggable: false,
      position: LatLng(myLat, myLong),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    Marker clientMarker = Marker(
      markerId: MarkerId("Client Marker"),
      draggable: false,
      position: LatLng(widget.clientLat, widget.clientLong),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    setState(() {
      _markers.add(myMarker);
      _markers.add(clientMarker);
    });
    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 70.0),
    );
  }

  BitmapDescriptor carIcon;
  void getImageIcon() {
    if (carIcon == null) {
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(
        context,
        size: Size(2.2, 2.2),
      );
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, "assets/car_android.png")
          .then((value) {
        carIcon = value;
      });
    }
  }

  void getLocationUpdates() {
    driverMoving =
        getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation)
            .listen((Position pos) {
      LatLng updatePosition = LatLng(pos.latitude, pos.longitude);
      Marker movingMarker = Marker(
        markerId: MarkerId("Moving"),
        position: updatePosition,
        icon: carIcon,
        rotation: 80.0,
      );
      CameraPosition cp = CameraPosition(target: updatePosition, zoom: 18.0);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(cp),
      );
      setState(() {
        _markers.removeWhere((element) => element.markerId.value == "Moving");
        _markers.add(movingMarker);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getImageIcon();
    var locations = Provider.of<DriverToClient>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(30.4761909, 31.0361089),
                zoom: 18,
              ),
              markers: _markers,
              polylines: _polyLines,
              onMapCreated: (GoogleMapController controller) async {
                mapController = controller;
                //await getPolyLineDetails();
                getLocationUpdates();
              },
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.isLightTheme
                          ? Colors.black.withOpacity(0.2)
                          : Colors.white.withOpacity(0.2),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 14, left: 14, top: 10),
                    ),
                    Padding(
                      padding: EdgeInsets.all(14),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClinetTrip(),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: staticGreenColor,
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of('Start To Trip'),
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: ConstanceData.secoundryFontColor,
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
