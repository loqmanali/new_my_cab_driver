import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverLocation extends ChangeNotifier {
  int id;
  double lat;
  double long;
  bool isOffLine = false;

  void getMyLat(double myLat) {
    lat = myLat;
    notifyListeners();
  }

  void getMyLong(double myLong) {
    long = myLong;
    notifyListeners();
  }

  void getMyId(int myId) {
    id = myId;
    notifyListeners();
  }
}
