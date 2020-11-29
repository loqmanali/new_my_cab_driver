import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_cab_driver/models/directionsModel.dart';
import 'package:http/http.dart' as http;
import 'package:my_cab_driver/providers/driver_trip.dart';
import 'package:my_cab_driver/providers/drvier_to_client_trip.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class DirectionDetailsInfo {
  static Future<DirectionDetailsModel> getDirectionDriverToClinet(
      {LatLng startPosition, LatLng endPosition, BuildContext context}) async {
    DirectionDetailsModel details;
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=AIzaSyD1EysE7-3A4TRJOEIaMGurEJaHN-gWvCM";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      details = DirectionDetailsModel(
        points: data['routes'][0]['overview_polyline']['points'],
      );
      Provider.of<DriverToClient>(context, listen: false)
          .getEncodedPoints(details.points);
    }
    return details;
  }

  static Future<DirectionDetailsModel> getDirectionDriverTrip(
      {LatLng startPosition, LatLng endPosition, BuildContext context}) async {
    DirectionDetailsModel details;
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=AIzaSyD1EysE7-3A4TRJOEIaMGurEJaHN-gWvCM";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      details = DirectionDetailsModel(
        points: data['routes'][0]['overview_polyline']['points'],
      );

      Provider.of<DriverTrip>(context, listen: false)
          .getEncodedPoints(details.points);
    }
    return details;
  }
}
