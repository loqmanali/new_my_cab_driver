import 'dart:convert';

class NotificationModel {
  String _title,
      _body,
      _name,
      _startAddress,
      _endAddress,
      _cost,
      _startPointLatitude,
      _startPointLongitude,
      _endPointLatitude,
      _endPointLongitude,
      _tripId,
      _cacheId,
      _driverId;
  bool _inHaram;

  Map<String, dynamic> _nativeData;

  NotificationModel.fromMap(Map<String, dynamic> data) {
    print("Notification Model : $data");
    try {
      this._nativeData = data;
      this._title = data['notification']['title'];
      this._body = data['notification']['body'];
      Map<String, dynamic> temp;

      print("////////////////////////");
      temp = Map<String, dynamic>.from(data['data']);

      this._cacheId = "${temp['cache_id']}";

      this._driverId = "${temp['driver']}";
      print("driverID : ${this._driverId}");
      this._cost = "${temp['cost']}";

      this._inHaram = int.parse("${temp['in_haram']}") == 1;

      this._name = temp['name'];
      this._tripId = "${temp['id']}";

      Map<String, dynamic> startAddressMap = json.decode(temp['start_point']);

      this._startAddress = "${startAddressMap['address_start']}";

      this._startPointLatitude = "${startAddressMap['start_point_latitude']}";

      this._startPointLongitude = "${startAddressMap['start_point_longitude']}";
      Map<String, dynamic> endAddressMap = json.decode(temp['end_point']);

      this._endAddress = "${endAddressMap['address_end']}";

      this._endPointLatitude = "${endAddressMap['End_point_latitude']}";

      this._endPointLongitude = "${endAddressMap['End_point_longitude']}";
    } catch (e) {
      print("Exception in notification model : $e");
    }
  }

  String get title => this._title;

  String get body => this._body;

  String get startAddress => this._startAddress;

  String get endAddress => this._endAddress;

  Map<String, dynamic> get nativeData => this._nativeData;

  String get endPointLongitude => this._endPointLongitude;

  String get endPointLatitude => this._endPointLatitude;

  String get startPointLongitude => this._startPointLongitude;

  String get startPointLatitude => this._startPointLatitude;

  String get cost => this._cost;

  String get tripId => this._tripId;

  bool get inHaram => this._inHaram;

  String get name => this._name;

  String get cacheId => this._cacheId;

  String get driverId => this._driverId;
}

Map<String, dynamic> data = {
  "notification": {
    "title": "Garden Taxi New Tripe Request",
    "body": "The client khaled has requsetd new tripe with cost of 1 EGP"
  },
  "data": {
    "start_point": {
      "start_point_latitude": "12345",
      "address_start": "kha",
      "start_point_longitude": "12345"
    },
    "cache_id": "wsPn9chXg8qkdA56VdFiZtP6um2IlKgL7fQ171Ob",
    "in_haram": "0",
    "id": "382",
    "cost": "1",
    "name": "khaled",
    "end_point": {
      "End_point_latitude": "12345",
      "End_point_longitude": "12345",
      "address_end": "abc"
    }
  }
};

// class NotificationModel {
//   String _title, _body, _name, _startAddress, _endAddress;
//   bool _inHaram;
//   int _tripId;
//   double _cost,
//       _startPointLatitude,
//       _startPointLongitude,
//       _endPointLatitude,
//       _endPointLongitude;
//
//   Map<String, dynamic> _nativeData;
//
//   NotificationModel.fromMap(Map<String, dynamic> data) {
//     try {
//       this._nativeData = data;
//
//       this._title = data['notification']['title'];
//       this._body = data['notification']['body'];
//
//       data = Map<String, dynamic>.from(data['data'][0][0]);
//
//       this._cost = double.parse("${data['cost']}");
//
//       this._inHaram = int.parse("${data['in_haram']}") == 1;
//
//       this._name = data['name'];
//       this._tripId = int.parse("${data['id']}");
//
//       this._startAddress = data['start_point'][0]['address_start'];
//       this._startPointLatitude =
//           double.parse("${data['start_point'][0]['start_point_latitude']}");
//
//       this._startPointLongitude =
//           double.parse("${data['start_point'][0]['start_point_longitude']}");
//
//       this._endAddress = data['end_point'][0]['address_end'];
//       this._endPointLatitude =
//           double.parse("${data['end_point'][0]['End_point_latitude']}");
//       this._endPointLongitude =
//           double.parse("${data['end_point'][0]['End_point_longitude']}");
//     } catch (e) {
//       print("Exception in notification model : $e");
//     }
//   }
//
//   String get title => this._title;
//
//   String get body => this._body;
//
//   String get startAddress => this._startAddress;
//
//   String get endAddress => this._endAddress;
//
//   Map<String, dynamic> get nativeData => this._nativeData;
//
//   double get endPointLongitude => this._endPointLongitude;
//
//   double get endPointLatitude => this._endPointLatitude;
//
//   double get startPointLongitude => this._startPointLongitude;
//
//   double get startPointLatitude => this._startPointLatitude;
//
//   double get cost => this._cost;
//
//   int get tripId => this._tripId;
//
//   bool get inHaram => this._inHaram;
//
//   String get name => this._name;
// }
//
// Map<String, dynamic> data = {
//   "notification": {
//     "title": " Garden Taxi New Tripe Request",
//     "body": " The client khaled has requsetd new tripe with cost of 1 EGP"
//   },
//   "data": {
//     0: [
//       {
//         "cache_id": "sV21NlU999bYV8lNjootkWeafb1ogDEHRXwfLuza",
//         "cost": "1",
//         "start_point": [
//           {
//             "start_point_latitude": "12345",
//             "address_start": "kha",
//             "start_point_longitude": "12345"
//           }
//         ],
//         "end_point": [
//           {
//             "End_point_latitude": "12345",
//             "End_point_longitude": "12345",
//             "address_end": "abc"
//           }
//         ],
//         "in_haram": "0",
//         "name": "khaled",
//         "id": "335"
//       }
//     ],
//     "click_action": "FLUTTER_NOTIFICATION_CLICK"
//   }
// };
