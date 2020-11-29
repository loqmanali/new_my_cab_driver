import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:animator/animator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locationPackage;
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/controllers/current_trip_provider.dart';
import 'package:my_cab_driver/controllers/firebase_helper.dart';
import 'package:my_cab_driver/controllers/user_data_provider.dart';
import 'package:my_cab_driver/drawer/drawer.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/models/cancel_trip.dart';
import 'package:my_cab_driver/models/driver_info.dart';
import 'package:my_cab_driver/models/trip_request.dart';
import 'package:my_cab_driver/providers/driverLocation.dart';
import 'package:my_cab_driver/providers/driver_info_provider.dart';
import 'package:my_cab_driver/providers/drvier_to_client_trip.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_cab_driver/pickup/driver_to_client_trip.dart';
import 'package:my_cab_driver/providers/driver_trip.dart';
import 'package:my_cab_driver/models/current_trip_model.dart';
import 'package:my_cab_driver/views/current_trip_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CurrentTripProvider _tripProvider;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  GoogleMapController _mapController;
  StreamSubscription _locationSubscription;
  locationPackage.Location _locationTracker = new locationPackage.Location();

  Marker _marker;
  Circle _circle;
  double lat = 37.43296265331129;
  double long = -122.08832357078792;

  void getMyLocation() async {
    Position position = await getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
    Provider.of<DriverToClient>(context, listen: false).getStartLat(lat);
    Provider.of<DriverToClient>(context, listen: false).getStartLong(long);

    Provider.of<DriverLocation>(context, listen: false).getMyLat(lat);
    Provider.of<DriverLocation>(context, listen: false).getMyLong(long);

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, long),
          zoom: 18.0,
        ),
      ),
    );
  }

  void getInsideAndOutSide() async {
    String driverId =
        Provider.of<DriverLocation>(context, listen: false).id.toString();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //asd
    String savedId = prefs.getInt("DriverId").toString();
    var inside = Provider.of<DriverInfoProvider>(context, listen: false).inside;

    var outSide =
        Provider.of<DriverInfoProvider>(context, listen: false).outSide;

    String url = "https://gardentaxi.net/Back_End/public/api/driver/Inbound";

    await http.post(url, body: {
      "In_bound": inside ?? outSide,
      "id": driverId ?? savedId,
    });
  }

  FirebaseHelper _firebaseHelper = new FirebaseHelper();
  Position _lastPosition;

  Future<Position> _getCurrentPosition() async =>
      await Geolocator.getCurrentPosition();

  void _updateCurrentLocation(
      {locationPackage.LocationData location, Position position}) async {
    print("Timer Called");
    if (this._userDataProvider.activeNow) {
      print("He Is Online");
      Position p = await this._getCurrentPosition();

      if (this._lastPosition == null) {
        print("Same location");
        this._lastPosition = p;
        this._firebaseHelper.updateLocation(
            inSide: this._userDataProvider.inSide,
            id: this._driver.id,
            location: location,
            position: position,
            gender: this._userDataProvider.gender);
      } else if (p.latitude != this._lastPosition.latitude &&
          p.longitude != this._lastPosition.longitude) {
        print("Update Location");
        this._lastPosition = p;
        this._firebaseHelper.updateLocation(
            id: this._driver.id,
            location: location,
            position: position,
            inSide: this._userDataProvider.inSide,
            gender: this._userDataProvider.gender);
      }
    }
    print("Called : user not active in update current location ");
  }

  @override
  void initState() {
    getInsideAndOutSide();
    Firebase.initializeApp();
    super.initState();
  }

  DriverLocation _driver;
  UserDataProvider _userDataProvider;

  bool _listenTripTurned = false;

  Future<void> _updateCurrentLocationTimer() async {
    Timer.periodic(Duration(minutes: 10), (timer) {
      print("Timer Called///////////////////");
      if (this._userDataProvider.activeNow) this._timeEditable = true;
    });
  }

  @override
  void didChangeDependencies() {
    this._driver = Provider.of<DriverLocation>(context, listen: false);
    this._userDataProvider = Provider.of<UserDataProvider>(context);
    this._tripProvider = Provider.of<CurrentTripProvider>(context);

    if (!this._listenTripTurned) {
      this._listenTripTurned = true;
      this._hasTrip(context);
      this._updateCurrentLocationTimer();
    }
    super.didChangeDependencies();
  }

  Future<TripRequest> getTripRequest() async {
    TripRequest tripRequest;
    try {
      String url = "https://gardentaxi.net/Back_End/public/api/tripe/get/47";

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        tripRequest = TripRequest(
          driverId: data['data']['0']['driver_id'],
          clientId: data['data']['0']['user']['id'],
          clientName: data['data']['0']['user']['name'],
          endPointLat: data['data']["0"]['End_point_latitude'],
          endPointLong: data['data']["0"]['End_point_longitude'],
          startPointLat: data['data']["0"]['start_point_latitude'],
          startPointLong: data['data']["0"]['start_point_longitude'],
          insideOrOutSide: data['data']["0"]['in_haram'],
          cost: data['data']["0"]['cost'],
        );
        Provider.of<DriverToClient>(context, listen: false)
            .getEndLat(double.parse(tripRequest.startPointLat));

        Provider.of<DriverToClient>(context, listen: false)
            .getEndLong(double.parse(tripRequest.startPointLong));

        Provider.of<DriverTrip>(context, listen: false)
            .getStartLat(double.parse(tripRequest.startPointLat));

        Provider.of<DriverTrip>(context, listen: false)
            .getStartLong(double.parse(tripRequest.startPointLong));

        Provider.of<DriverTrip>(context, listen: false)
            .getEndLat(double.parse(tripRequest.endPointLat));

        Provider.of<DriverTrip>(context, listen: false)
            .getEndLong(double.parse(tripRequest.endPointLong));
      }
    } catch (e) {
      print(e);
    }
    // put (Id) Of The Trip in The End Of The Link

    return tripRequest;
  }

  Future<CancelTrip> canceledTrip() async {
    CancelTrip canceled;
    // put (id)  Of the Trip in The End Of The Link
    String url = "https://gardentaxi.net/Back_End/public/api/tripe/end/47";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      canceled = CancelTrip(
        tripId: data['data']['id'],
        driverId: data['data']['driver_id'],
        clientId: data['data']['user_id'],
        startPointLong: data['data']['start_point_longitude'],
        startPointLat: data['data']['start_point_latitude'],
        endPointLong: data['data']['End_point_longitude'],
        endPointLat: data['data']['End_point_latitude'],
        cost: data['data']['cost'],
        insideOrOutSide: data['data']['in_haram'],
      );
    }
    print(canceled.tripId);
    return canceled;
  }

  CurrentTripModel _currentTripModel;

  Future<void> _hasTrip(BuildContext context) async {
    final String url =
        "https://gardentaxi.net/Back_End/public/api/tripe/get/${this._userDataProvider.id}";
    http.Response response = await http.get(url);
    print(url);
    if (response.statusCode == 200) {
      this._currentTripModel = new CurrentTripModel.fromMap(
          Map<String, dynamic>.from(json.decode(response.body)));

      if (this._currentTripModel.hasTrip) {
        this._tripProvider.initData(json.decode(response.body));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => CurrentTripView(
                      currentTripModel: this._currentTripModel,
                    )));
      }
    }
  }

  Future<Uint8List> _getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/car.png");

    return byteData.buffer.asUint8List();
  }

  void _updateMarkerAndCircle(
      locationPackage.LocationData newLocation, Uint8List imageData) {
    LatLng latLng = LatLng(newLocation.latitude, newLocation.longitude);

    setState(() {
      this._marker = new Marker(
        markerId: MarkerId("home"),
        position: latLng,
        rotation: newLocation.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imageData),
      );
      this._circle = new Circle(
        circleId: CircleId("car"),
        radius: newLocation.accuracy,
        zIndex: 1,
        strokeColor: Colors.green,
        center: latLng,
        fillColor: Colors.green.withAlpha(70),
      );
    });
  }

  bool _timeEditable = true;

  Future _startLiveTracking() async {
    print("Live Tracking Start");
    try {
      try {
        Uint8List imageData = await this._getMarker();
        locationPackage.LocationData locationData =
            await this._locationTracker.getLocation();

        print(
            "lat : ${locationData.latitude} , lng : ${locationData.longitude}");

        this._updateMarkerAndCircle(locationData, imageData);

        if (this._locationSubscription != null)
          this._locationSubscription.cancel();

        this._locationSubscription =
            this._locationTracker.onLocationChanged().listen(
          (newLocation) {
            print("Called : /////////////////////////////////");
            print(
                "lat : ${locationData.latitude} , lng : ${locationData.longitude}");
            if (this._timeEditable) {
              this._timeEditable = false;
              if (this._mapController != null) {
                this._updateCurrentLocation(location: newLocation);
                this._mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          bearing: 192.8334901395799,
                          target: LatLng(
                              newLocation.latitude, newLocation.longitude),
                          tilt: 0,
                          zoom: 18.00,
                        ),
                      ),
                    );
                this._updateMarkerAndCircle(newLocation, imageData);
              }
            } else {
              print("No Update");
            }
          },
        );
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') print("permission denied");
      }
    } catch (e) {
      print("Exception in getCurrentLocation method : $e");
    }
  }

  void _stopLiveTracking() {
    print("Live Tracking Stopped");
    this._timeEditable = false;
    if (this._locationSubscription != null) this._locationSubscription.cancel();
  }

  @override
  void dispose() {
    if (this._locationSubscription != null) this._locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              SizedBox(
                height: AppBar().preferredSize.height,
                width: AppBar().preferredSize.height + 40,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.dehaze),
                      color: Colors.blue,
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: !this._userDataProvider.activeNow
                    ? Text(
                        AppLocalizations.of('OffLine'),
                        style: headLineStyle.copyWith(
                            color: Colors.black, fontSize: 20.0),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        AppLocalizations.of('Online'),
                        style: headLineStyle.copyWith(
                            color: Colors.black, fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
              ),
              SizedBox(
                height: AppBar().preferredSize.height,
                width: AppBar().preferredSize.height + 40,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Switch(
                    activeColor: staticGreenColor,
                    value: this._userDataProvider.activeNow,
                    onChanged: (bool value) async {
                      setState(() {
                        this._userDataProvider.activeNow =
                            !this._userDataProvider.activeNow;
                      });
                      if (value == true) {
                        this._startLiveTracking();
                        this._firebaseHelper.updateLocation(
                            inSide: this._userDataProvider.inSide,
                            id: this._driver.id,
                            position: await this._getCurrentPosition(),
                            gender: this._userDataProvider.gender);
                      } else if (value == false) {
                        this._stopLiveTracking();
                        this
                            ._firebaseHelper
                            .deleteFromOnlineDrivers(this._driver.id);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        key: _scaffoldKey,
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75 < 400
              ? MediaQuery.of(context).size.width * 0.75
              : 350,
          child: Drawer(
            child: AppDrawer(
              selectItemName: 'Home',
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
                padding: EdgeInsets.only(bottom: 170.0, top: 60),
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, long),
                  zoom: 18.0,
                ),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                markers: Set.of((this._marker != null) ? [this._marker] : []),
                circles: Set.of((this._circle != null) ? [this._circle] : []),
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                onMapCreated: (controller) async {
                  this._mapController = controller;
                  getMyLocation();
                }),
            !this._userDataProvider.activeNow
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      offLineMode(),
                      Expanded(child: SizedBox()),
                      //myLocation(),
                      SizedBox(height: 10),
                      offLineModeDetail(),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(),
                      ),
                      // myLocation(),
                      SizedBox(
                        height: 10,
                      ),
                      onLineModeDetail(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void getNameStartPoint(String lat, String long) async {
    Coordinates coordinates = Coordinates(
      double.parse(lat),
      double.parse(long),
    );
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    String addressName = address.first.addressLine;
    setState(() {
      startPointName = addressName;
    });
  }

  void getNameEndPoint(String lat, String long) async {
    Coordinates coordinates =
        Coordinates(double.parse(lat), double.parse(long));
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    String addressName = address.first.addressLine;
    setState(() {
      endPointName = addressName;
    });
  }

  String startPointName = "";
  String endPointName = "";

  Widget onLineModeDetail() {
    // var data = Provider.of<DriverToClient>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10, bottom: 0.0),
      child: FutureBuilder(
        future: getTripRequest(),
        builder: (context, AsyncSnapshot<TripRequest> snapshot) {
          if (snapshot.data == null) {
            return Center(
                child: Column(
              children: [
                CircularProgressIndicator(),
                Text(
                  "Waiting For Request",
                  style: headLineStyle.copyWith(color: staticGreenColor),
                ),
              ],
            ));
          }
          getNameStartPoint(
              snapshot.data.startPointLat, snapshot.data.startPointLong);
          getNameEndPoint(
              snapshot.data.endPointLat, snapshot.data.endPointLong);
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 16,
                child: Padding(
                  padding: EdgeInsets.only(right: 24, left: 24),
                  child: Animator(
                    tween: Tween<Offset>(
                      begin: Offset(0, 0.5),
                      end: Offset(0, 0),
                    ),
                    duration: Duration(milliseconds: 700),
                    cycles: 1,
                    builder: (anim) {
                      return SlideTransition(
                        position: anim,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5.0),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 0,
                left: 0,
                bottom: 16.0,
                child: Padding(
                  padding: EdgeInsets.only(right: 12, left: 12),
                  child: Animator(
                      tween: Tween<Offset>(
                        begin: Offset(0, 0.5),
                        end: Offset(0, 0),
                      ),
                      duration: Duration(milliseconds: 700),
                      cycles: 1,
                      builder: (anim) {
                        return SlideTransition(
                          position: anim,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12, blurRadius: 6.0),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Animator(
                tween: Tween<Offset>(
                  begin: Offset(0, 0.4),
                  end: Offset(0, 0),
                ),
                duration: Duration(milliseconds: 700),
                cycles: 1,
                builder: (anim) => SlideTransition(
                  position: anim,
                  child: Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(14),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      "assets/profile_icon.png",
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.clientName,
                                        style: headLineStyle.copyWith(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.cost,
                                        style: describtionStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.5,
                              color: Theme.of(context).disabledColor,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 14, left: 14, top: 10, bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of('PICKUP'),
                                        style: describtionStyle.copyWith(
                                          fontSize: 12.0,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        startPointName,
                                        style: describtionStyle.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.5,
                              color: Colors.black26,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 14, left: 14, top: 10, bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of('DROP OFF'),
                                        style: describtionStyle.copyWith(
                                          fontSize: 12.0,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width: 250.0,
                                        child: Text(
                                          endPointName,
                                          style: describtionStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 0.5,
                              color: Theme.of(context).disabledColor,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 14, left: 14, top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      canceledTrip();
                                    },
                                    child: Container(
                                      height: 32,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of('Ignore'),
                                          style: buttonsText.copyWith(
                                            color: Colors.black26,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DriverToClientTrip(
                                                  // clientLat: data.endLat,
                                                  // clientLong: data.endLong,
                                                  ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 32,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: staticGreenColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of('ACCEPT'),
                                          style: buttonsText.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget offLineModeDetail() {
    var data = Provider.of<DriverInfoProvider>(context);
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: backGroundColors,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 14, left: 14),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16,
                  backgroundImage: AssetImage("assets/profile_icon.png"),
                ),
                SizedBox(
                  width: 8,
                ),
                FutureBuilder(
                  future: data.getDriverDetails(context),
                  builder: (context, AsyncSnapshot<DriverInfo> snapshot) {
                    if (snapshot.data == null) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          snapshot.data.name,
                          style: headLineStyle.copyWith(fontSize: 18.0),
                        ),
                        Text(
                          AppLocalizations.of('Basic level'),
                          style: describtionStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '00.00 LE',
                      style: headLineStyle.copyWith(fontSize: 18.0),
                    ),
                    Text(
                      AppLocalizations.of('Earned'),
                      style: describtionStyle.copyWith(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            // SizedBox(
            //   height: 8,
            // ),
            Container(
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: staticGreenColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.clock,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          size: 20,
                        ),
                        // Expanded(
                        //   child: SizedBox(),
                        // ),
                        // SizedBox(
                        //   height: 4,
                        // ),
                        Text(
                          '00.00',
                          style: describtionStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('HOURS ONLINE'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.tachometerAlt,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          size: 20,
                        ),
                        // Expanded(
                        //   child: SizedBox(),
                        // ),
                        // SizedBox(
                        //   height: 4,
                        // ),
                        Text(
                          '00 KM',
                          style: describtionStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('TOTAL DISTANCE'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.rocket,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          size: 20,
                        ),
                        // Expanded(
                        //   child: SizedBox(),
                        // ),
                        // SizedBox(
                        //   height: 4,
                        // ),
                        Text(
                          '00.00',
                          style: describtionStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('TOTAL JOBS'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget myLocation() {
    return Padding(
      padding: EdgeInsets.only(right: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.green,
                  blurRadius: 12,
                  spreadRadius: -5,
                )
              ],
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.my_location,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget offLineMode() {
    return Animator(
        tween: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ),
        duration: Duration(milliseconds: 400),
        cycles: 1,
        builder: (anim) {
          return SizeTransition(
            sizeFactor: anim,
            axis: Axis.horizontal,
            child: Container(
              height: AppBar().preferredSize.height + 10.0,
              color: staticGreenColor,
              child: Padding(
                padding: EdgeInsets.only(right: 14, left: 14),
                child: Row(
                  children: <Widget>[
                    DottedBorder(
                      color: ConstanceData.secoundryFontColor,
                      borderType: BorderType.Circle,
                      strokeWidth: 2,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          FontAwesomeIcons.cloudMoon,
                          color: ConstanceData.secoundryFontColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of('You are offline !'),
                          style: Theme.of(context).textTheme.title.copyWith(
                              fontWeight: FontWeight.bold,
                              color: ConstanceData.secoundryFontColor),
                        ),
                        Text(
                          AppLocalizations.of(
                              'Go online to strat accepting jobs.'),
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                                color: ConstanceData.secoundryFontColor,
                              ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
