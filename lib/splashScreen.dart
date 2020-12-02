import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_cab_driver/Language/LanguageData.dart';
import 'package:my_cab_driver/controllers/shared_preference.dart';
import 'package:my_cab_driver/controllers/user_data_provider.dart';
import 'package:my_cab_driver/introduction/introductionScreen.dart';
import 'package:my_cab_driver/constance/constance.dart' as constance;
import 'package:my_cab_driver/main.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<bool> oldVersion(BuildContext context) async {
    bool oldV = true;
    try {
      http.Response res = await http
          .get("https://gardentaxi.net/Back_End/public/api/app/version");
      Map<String, dynamic> data =
      Map<String, dynamic>.from(json.decode(res.body));

      if (data['data'][0]['value'] == "1.0.0+1") {
        oldV = false;
      } else {
        print("old version");
        oldV = true;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: AlertDialog(
                  title: Text("عذرا"),
                  content: Text("هذا الإصدار قديم يرجى تحديث الاصدار"),
                ),
              );
            });
      }
    } catch (e) {
      print("Exception in CheckVersionMethod : $e");
    }
    return oldV;
  }

  @override
  void initState() {
    myContext = context;
    Timer(Duration(seconds: 3), () {
      _loadNextScreen();
    });
    super.initState();
  }

  BuildContext myContext;

  _loadNextScreen() async {
    bool oldV = await oldVersion(context);
    if (!oldV) {
      await Firebase.initializeApp();
      SharedPreferenceService prefsService = new SharedPreferenceService();
      Map<String, dynamic> data = await prefsService.getUserData();
      if (data != null) this._userDataProvider.initialData(data);

      if (!mounted) return;
      if (constance.allTextData == null) {
        constance.allTextData = AllTextData.fromJson(json.decode(
            await DefaultAssetBundle.of(myContext)
                .loadString("jsonFile/languagetext.json")));
      }
      await Future.delayed(const Duration(milliseconds: 1200));
      Navigator.pushReplacementNamed(context, Routes.Languages);
    }
  }

  UserDataProvider _userDataProvider;

  @override
  void didChangeDependencies() {
    this._userDataProvider = Provider.of<UserDataProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/splash/splash1.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: height,
            ),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
