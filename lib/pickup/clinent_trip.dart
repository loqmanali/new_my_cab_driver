import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/appTheme.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/providers/directionDetails.dart';
import 'package:my_cab_driver/providers/driver_trip.dart';
import 'package:my_cab_driver/ticketView.dart';
import 'package:provider/provider.dart';

class ClinetTrip extends StatefulWidget {
  @override
  _ClinetTripState createState() => _ClinetTripState();
}

class _ClinetTripState extends State<ClinetTrip> {
  GoogleMapController _mapController;
  List<LatLng> polyLineCoordinates = [];
  Set<Polyline> _polyLines = {};
  Set<Marker> _markers = {};

  Future getPolyLineDetails() async {
    double startLat = Provider.of<DriverTrip>(context, listen: false).startLat;
    double startLong =
        Provider.of<DriverTrip>(context, listen: false).startLong;
    double endLat = Provider.of<DriverTrip>(context, listen: false).endLat;
    double endLong = Provider.of<DriverTrip>(context, listen: false).endLong;
    print(startLat);
    print(startLong);
    print(endLat);
    print(endLat);
    _polyLines.clear();
    polyLineCoordinates.clear();
    await DirectionDetailsInfo.getDirectionDriverTrip(
      startPosition: LatLng(startLat, startLong),
      endPosition: LatLng(endLat, endLong),
      context: context,
    );
    PolylinePoints polylinePoints = PolylinePoints();
    String points = Provider.of<DriverTrip>(context, listen: false).points;
    polyLineCoordinates.clear();
    List<PointLatLng> results = polylinePoints.decodePolyline(points);
    if (results.isNotEmpty) {
      results.forEach((element) {
        polyLineCoordinates.add(
          LatLng(element.latitude, element.longitude),
        );
      });
    }
    _polyLines.clear();
    setState(() {
      Polyline polyline = Polyline(
        polylineId: PolylineId("polyId"),
        color: Colors.blue,
        width: 4,
        points: polyLineCoordinates,
      );
      _polyLines.add(polyline);
    });
    LatLngBounds bounds;
    if (startLat > endLat && startLong > endLong) {
      bounds = LatLngBounds(
        southwest: LatLng(endLat, endLong),
        northeast: LatLng(startLat, startLong),
      );
    } else if (startLong > endLong) {
      bounds = LatLngBounds(
        southwest: LatLng(startLat, endLong),
        northeast: LatLng(endLat, startLong),
      );
    } else if (startLat > endLat) {
      bounds = LatLngBounds(
        southwest: LatLng(endLat, startLong),
        northeast: LatLng(startLat, endLong),
      );
    } else {
      bounds = LatLngBounds(
        southwest: LatLng(startLat, startLong),
        northeast: LatLng(endLat, endLong),
      );
    }
    Marker startMarker = Marker(
      markerId: MarkerId("startTrip"),
      position: LatLng(startLat, startLong),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      draggable: false,
    );
    Marker endMarker = Marker(
      markerId: MarkerId("EndTrip"),
      position: LatLng(endLat, endLong),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      draggable: false,
    );

    setState(() {
      _markers.add(startMarker);
      _markers.add(endMarker);
    });
    _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 70.0),
    );
  }

  BitmapDescriptor carIcon;

  void createImageIcon() {
    if (carIcon == null) {
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(
        context,
        size: Size(2.0, 2.2),
      );
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, "assets/car_android.png")
          .then((value) {
        carIcon = value;
      });
    }
  }

  void getUpdateLocation() async {
    StreamSubscription<Position> movingDriver =
        getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation)
            .listen((Position position) {
      LatLng updatePosition = LatLng(position.latitude, position.longitude);

      Marker movingMarker = Marker(
        markerId: MarkerId("Moving"),
        position: updatePosition,
        icon: carIcon,
        rotation: 80.0,
      );
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
          ),
        ),
      );
      setState(() {
        _markers.removeWhere((element) => element.markerId.value == "Moving");
        _markers.add(movingMarker);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var clientLocation = Provider.of<DriverTrip>(context, listen: false);
    createImageIcon();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(clientLocation.startLat, clientLocation.startLong),
                  zoom: 18.0,
                ),
                markers: _markers,
                polylines: _polyLines,
                onMapCreated: (GoogleMapController controller) async {
                  _mapController = controller;
                  await getPolyLineDetails();
                  getUpdateLocation();
                }),
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
                              builder: (context) => TicketDesign(),
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
                              "Arrived",
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
