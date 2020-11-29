import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class FirebaseHelper {
  static final String _onlineDrivers = "online_drivers", _diver = "driver_";

  Future<bool> deleteFromOnlineDrivers(int id) async {
    try {
      await FirebaseFirestore.instance
          .collection("$_onlineDrivers")
          .doc("$_diver$id")
          .delete();
      return true;
    } catch (e) {
      print("Exception in deleteFromOnlineDrivers : $e");
      return false;
    }
  }

  Future<void> updateLocation(
      {@required int id,
      LocationData location,
      Position position,
      @required String gender,
      @required bool inSide}) async {
    double lat, long;
    if (location != null) {
      lat = location.latitude;
      long = location.longitude;
    } else {
      lat = position.latitude;
      long = position.longitude;
    }
    FirebaseFirestore.instance
        .collection("$_onlineDrivers")
        .doc("$_diver$id")
        .set({
      "id": id,
      "lat": lat,
      "lng": long,
      "inSide": inSide,
      "gender": gender,
    });
  }
}
