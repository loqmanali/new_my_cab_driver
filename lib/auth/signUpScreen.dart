import 'dart:convert';
import 'package:animator/animator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/auth/phoneAuthScreen.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/controllers/shared_preference.dart';
import 'package:my_cab_driver/controllers/user_data_provider.dart';
import 'package:my_cab_driver/loading.dart';
import 'package:my_cab_driver/main.dart';
import 'package:my_cab_driver/providers/driverLocation.dart';
import 'package:my_cab_driver/providers/driver_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginScreen.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _genderIsMale = true;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _loading() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Loading(status: "Loading"),
    );
  }

  void alreadyRegistered() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text(
          "You Already Registered",
          style: headLineStyle.copyWith(fontSize: 20.0),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Ok",
              style: describtionStyle.copyWith(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String deviceToken = "";

  void firebaseMessagingListeners() async {
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        deviceToken = token;
      });
    });
  }

  void saveDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("DeviceToken", deviceToken);
  }

  UserDataProvider _userDataProvider;

  @override
  void didChangeDependencies() {
    this._userDataProvider = Provider.of<UserDataProvider>(context);
    super.didChangeDependencies();
  }

  void registerDriver() async {
    _loading();
    saveDeviceToken();
    try {
      String url = "https://gardentaxi.net/Back_End/public/api/driver/register";
      var dataBody = {
        "name": nameController.text,
        "phone": phoneController.text,
        "password": passController.text,
        "device_token": deviceToken,
        "gender": (this._genderIsMale) ? "m" : "f",
      };
      print("DataBody : $dataBody");
      var response = await http.post(url, body: dataBody);
      if (response.statusCode == 200) {
        var dataDecoded = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString(
            "driverRegisterToken", dataDecoded["data"]['api_token']);
        var tokens = dataDecoded["data"]['api_token'];
        Provider.of<DriverInfoProvider>(context, listen: false)
            .getToken(tokens);

        int driverId = dataDecoded["data"]['id'];

        Provider.of<DriverLocation>(context, listen: false).getMyId(driverId);
        prefs.setInt("DriverId", driverId);

        ////save data ////
        Map<String, dynamic> d = {
          "id": driverId,
          "name": nameController.text,
          "phone": phoneController.text,
          "token": tokens,
          "gender": (this._genderIsMale) ? "m" : "f",
        };
        SharedPreferenceService prefsService = new SharedPreferenceService();
        prefsService.setUserData(d);
        this._userDataProvider.initialData(d);

        Navigator.pop(context);
        nameController.clear();
        phoneController.clear();
        passController.clear();
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.AddVehicle, (route) => false);
      } else {
        Navigator.pop(context);
        alreadyRegistered();
        nameController.clear();
        phoneController.clear();
        passController.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  var appBarheight = 0.0;
  String codeNum = "+20";

  void _getPrefrences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var drivertoken = prefs.getString("driverRegisterToken");
    var loginToken = prefs.getString("driverLoginToken");
    if (drivertoken != null || loginToken != null) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.HOME, (route) => false);
    }
  }

  @override
  void initState() {
    firebaseMessagingListeners();
    _getPrefrences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    appBarheight =
        AppBar().preferredSize.height + MediaQuery.of(context).padding.top - 20;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        height: height * 1.0,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(height: appBarheight),
                  Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: height * 0.3,
                            decoration: BoxDecoration(
                              color: staticGreenColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: <Widget>[
                                Animator(
                                  tween: Tween<Offset>(
                                    begin: Offset(0, 0.9),
                                    end: Offset(0, 0),
                                  ),
                                  duration: Duration(seconds: 3),
                                  cycles: 1,
                                  builder: (anim) {
                                    return SlideTransition(
                                      position: anim,
                                      child: Image.asset(
                                        ConstanceData.splashBackground,
                                        fit: BoxFit.cover,
                                        color: Colors.white.withOpacity(0.4),
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 18, right: 18),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of('Sign Up'),
                                            style: headLineStyle.copyWith(
                                                color: Colors.white),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              AppLocalizations.of(' With'),
                                              style: headLineStyle.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(
                                                'email and phone'),
                                            style: headLineStyle.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of('number'),
                                            style: headLineStyle.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 14,
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    validator: (value) => value.isEmpty
                                        ? "You Should Enter Full Name"
                                        : null,
                                    autofocus: false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      hintText: 'Full Name',
                                      hintStyle: describtionStyle.copyWith(
                                          color: Colors.black26),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  TextFormField(
                                    controller: phoneController,
                                    validator: (value) => value.isEmpty
                                        ? "You Should Enter Phone Number"
                                        : null,
                                    autofocus: false,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      hintText: 'Phone Number',
                                      hintStyle: describtionStyle.copyWith(
                                          color: Colors.black26),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  TextFormField(
                                    controller: passController,
                                    obscureText: true,
                                    validator: (value) => value.isEmpty
                                        ? "You Should Enter Password"
                                        : null,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      isDense: true,
                                      hintText: 'Password',
                                      hintStyle: describtionStyle.copyWith(
                                          color: Colors.black26),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 36),
                                  // SwitchListTile(
                                  //   title: Text("Male"),
                                  //   value: this._genderIsMale,
                                  //   onChanged: (bool isMale) => setState(
                                  //       () => this._genderIsMale = isMale),
                                  // ),
                                  RadioListTile<bool>(
                                    activeColor: Colors.white,
                                    title: Text(
                                      "Male",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onChanged: (bool value) => setState(
                                        () => this._genderIsMale = value),
                                    groupValue: this._genderIsMale,
                                    value: true,
                                  ),
                                  RadioListTile<bool>(
                                    activeColor: Colors.white,
                                    title: Text(
                                      "Female",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onChanged: (bool value) => setState(
                                        () => this._genderIsMale = value),
                                    groupValue: this._genderIsMale,
                                    value: false,
                                  ),
                                  SizedBox(height: 36),
                                  InkWell(
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        registerDriver();
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: staticGreenColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of('SIGN UP'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of('Already have an account?'),
                        style: describtionStyle,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.LOGIN);
                        },
                        child: Text(
                          AppLocalizations.of(' Sign In'),
                          style: skipButtons.copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      "assets/images/effect.PNG",
                      height: 100.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
