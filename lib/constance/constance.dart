import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_cab_driver/Language/LanguageData.dart';

class ConstanceData {
  static final splashBackground = "assets/images/building_image.png";
  static final acceptjob = "assets/images/acceptjob.png";
  static final location = "assets/images/location.jpg";
  static final wallet = "assets/images/wallet.jpg";
  static final enableLocation = "assets/images/enableLocation.jpg";
  static final appicon = "assets/images/app_icon.png";
  static final userImage = "assets/images/user.jpg";
  static final mylocation = "assets/images/mylocation.jpg";
  static final mylocation1 = "assets/images/mylocation1.png";
  static final mylocation2 = "assets/images/mylocation2.png";
  static final mylocation3 = "assets/images/mylocation3.png";
  static final user1 = "assets/images/1.jpg";
  static final user2 = "assets/images/2.jpg";
  static final user3 = "assets/images/3.jpg";
  static final user4 = "assets/images/4.jpg";
  static final user5 = "assets/images/5.jpg";
  static final user6 = "assets/images/6.jpg";
  static final user7 = "assets/images/7.jpg";
  static final user8 = "assets/images/8.jpg";
  static final user9 = "assets/images/9.jpg";

  static final Color secoundryFontColor = Colors.white;

  List<String> colors = [
    '#EB1165',
    '#32a852',
    '#e6230e',
    '#760ee6',
    '#db0ee6',
    '#db164e'
  ];
}

// Locale locale;
String locale = "en";

int colorsIndex = 0;

AllTextData allTextData;

var primaryColorString = '#EB1165';
var secondaryColorString = '#EB1165';

//============================================================================

TextStyle headLineStyle =
    TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold);
TextStyle describtionStyle = TextStyle(fontSize: 15.0);
TextStyle skipButtons = TextStyle(
    fontSize: 15.0, color: Colors.black45, fontWeight: FontWeight.bold);
TextStyle buttonsText =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0);

Color staticGreenColor = Color.fromARGB(255, 148, 206, 0);
Color backGroundColors = Color(0xFFEEECEB);
