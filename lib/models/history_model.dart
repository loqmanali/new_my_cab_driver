import 'package:my_cab_driver/models/trip_model.dart';

class HistoryModel {
  List<TripModel> _trips;
  String _totalTrips, _driverEarning;

  HistoryModel.fromMap(Map<String, dynamic> data) {
    print("data : $data");
    try {
      this._totalTrips = "${data['data']['earn']['total_trips']}";
      this._driverEarning = "${data['data']['earn']['driver_earning']}";
      this._trips = List<TripModel>.generate(
          data['data']['tripe'].length,
          (index) => TripModel.fromMap(
              Map<String, dynamic>.from(data['data']['tripe'][index])));
    } catch (e) {
      print("Exception in History Model  : $e");
      this._totalTrips = "0.0";
      this._driverEarning = "0.0";
      this._trips = [];
    }
  }

  List<TripModel> get trips => this._trips;

  String get driverEarning => this._driverEarning;

  String get totalTrips => this._totalTrips;
}
