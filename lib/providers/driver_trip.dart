import 'package:flutter/material.dart';

class DriverTrip extends ChangeNotifier {
  double startLat, startLong, endLat, endLong;
  String points;

  void getStartLat(double lat) {
    startLat = lat;
    notifyListeners();
  }

  void getStartLong(double long) {
    startLong = long;
    notifyListeners();
  }

  void getEndLat(double lat) {
    endLat = lat;
    notifyListeners();
  }

  void getEndLong(double long) {
    endLong = long;
    notifyListeners();
  }

  void getEncodedPoints(String polyLinePoints) {
    points = polyLinePoints;
    notifyListeners();
  }
}
