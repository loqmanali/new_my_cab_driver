import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/controllers/navigators.dart';
import 'package:my_cab_driver/controllers/shared_preference.dart';
import 'package:my_cab_driver/controllers/user_data_provider.dart';
import 'package:my_cab_driver/models/driver_info.dart';
import 'package:my_cab_driver/providers/driver_info_provider.dart';
import 'package:my_cab_driver/setting/edit_password.dart';
import 'package:my_cab_driver/upload_image.dart';
import 'package:my_cab_driver/views/image_view.dart';
import 'package:my_cab_driver/widgets/change_image_bottom_sheet.dart';
import 'package:my_cab_driver/widgets/exception_dialog.dart';
import 'package:my_cab_driver/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:my_cab_driver/constance/constance.dart' as constance;
import 'package:http/http.dart' as http;

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool selectFirstColor = false;
  bool selectSecondColor = false;
  bool selectThirdColor = false;
  bool selectFourthColor = false;
  bool selectFifthColor = false;
  bool selectSixthColor = false;

  UserDataProvider _userDataProvider;

  @override
  void didChangeDependencies() {
    this._userDataProvider = Provider.of<UserDataProvider>(context);
    super.didChangeDependencies();
  }

  Future<void> _uploadImage(BuildContext context) async {
    Map<String, dynamic> imageData = await selectAndGetImageData(context);
    if (imageData != null) {
      final String url =
          "https://gardentaxi.net/Back_End/public/api/user/upload_img";
      try {
        loadingDialog(context);
        http.Response res = await http.post(url, body: {
          "api_token": "${this._userDataProvider.token}",
          "acconut_img": "${imageData['original']}"
        });
        if (res.statusCode == 200) {
          Navigator.pop(context);
          Map<String, dynamic> resResult = json.decode(res.body);
          this._userDataProvider.imageUrl = resResult['data']['img_url'];
          SharedPreferenceService prefs = new SharedPreferenceService();
          prefs.setUserData(this._userDataProvider.toMap());
        } else {
          Navigator.pop(context);
          exceptionDialog(context);
        }
      } catch (e) {
        Navigator.pop(context);
        exceptionDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DriverInfoProvider>(context);
    return Scaffold(
      backgroundColor: backGroundColors,
      appBar: appBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder(
                    future: data.getDriverDetails(context),
                    builder: (context, AsyncSnapshot<DriverInfo> snapshot) {
                      if (snapshot.data == null) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          this._userImage(context),
                          SizedBox(height: 10.0),
                          Text(
                            snapshot.data.name,
                            style: headLineStyle.copyWith(fontSize: 15.0),
                          ),
                          Text(
                            'Gold Member',
                            style: describtionStyle.copyWith(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 14, left: 14, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Text(
                  AppLocalizations.of('THEME'),
                  style: describtionStyle.copyWith(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              openShowPopup();
            },
            child: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    EdgeInsets.only(right: 10, left: 14, top: 8, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of('Theme Mode'),
                      style: headLineStyle.copyWith(fontSize: 16.0),
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: staticGreenColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 14, left: 14, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Text(
                  AppLocalizations.of('LANGUAGE'),
                  style: describtionStyle.copyWith(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              openShowPopupLanguage();
            },
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 10, left: 14, top: 8, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of('Select your Language'),
                      style: headLineStyle.copyWith(fontSize: 16.0),
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: staticGreenColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 14, left: 14, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Text(
                  AppLocalizations.of('INFORMATION'),
                  style: describtionStyle.copyWith(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView(
              children: <Widget>[
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('Username'),
                              style: headLineStyle.copyWith(fontSize: 16.0),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '${this._userDataProvider.name}',
                              style: describtionStyle.copyWith(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: staticGreenColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('Phone number'),
                              style: headLineStyle.copyWith(fontSize: 16.0),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '${this._userDataProvider.phone}',
                              style: describtionStyle.copyWith(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: staticGreenColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       right: 10, left: 14, top: 8, bottom: 8),
                      //   child: Row(
                      //     children: <Widget>[
                      //       Text(
                      //         AppLocalizations.of('Email'),
                      //         style: headLineStyle.copyWith(fontSize: 16.0),
                      //       ),
                      //       Expanded(child: SizedBox()),
                      //       // Text(
                      //       //   'Account@gmail.com',
                      //       //   style: describtionStyle.copyWith(
                      //       //     color: Colors.black38,
                      //       //     fontWeight: FontWeight.bold,
                      //       //   ),
                      //       // ),
                      //       // SizedBox(
                      //       //   width: 4,
                      //       // ),
                      //       // Icon(
                      //       //   Icons.arrow_forward_ios,
                      //       //   size: 16,
                      //       //   color: staticGreenColor,
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 10, left: 14, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('Gender'),
                              style: headLineStyle.copyWith(fontSize: 16.0),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              AppLocalizations.of(
                                  '${this._userDataProvider.nativeGender}'),
                              style: describtionStyle.copyWith(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: staticGreenColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black12,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       right: 10, left: 14, top: 8, bottom: 8),
                      //   child: Row(
                      //     children: <Widget>[
                      //       Text(
                      //         AppLocalizations.of('Birthday'),
                      //         style: headLineStyle.copyWith(fontSize: 16.0),
                      //       ),
                      //       Expanded(child: SizedBox()),
                      //       Text(
                      //         'April 16,1988',
                      //         style: describtionStyle.copyWith(
                      //           color: Colors.black38,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 4,
                      //       ),
                      //       Icon(
                      //         Icons.arrow_forward_ios,
                      //         size: 16,
                      //         color: staticGreenColor,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _userImage(BuildContext context) {
    ImageProvider image = (this._userDataProvider.imageUrl == null)
        ? AssetImage("assets/profile_icon.png")
        : NetworkImage("${this._userDataProvider.imageUrl}");
    return GestureDetector(
      onTap: () {
        if (this._userDataProvider.imageUrl == null) {
          this._uploadImage(context);
        } else {
          changeImageBottomSheet(
            context,
            (bool changeImageSelected) {
              if (changeImageSelected) {
                this._uploadImage(context);
              } else
                pushNavigator(context, ImageView(image));
            },
          );
        }
      },
      child: Hero(
        tag: "image",
        child: Container(
          height: 90.0,
          width: 90.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: image,
            ),
          ),
        ),
      ),
    );
  }

  openShowPopupLanguage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                AppLocalizations.of('Select Language'),
                style: headLineStyle.copyWith(fontSize: 20.0),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('en');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'English',
                        style: Theme.of(context).textTheme.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('fr');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of('French'),
                        style: Theme.of(context).textTheme.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('ar');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of('Arabic'),
                        style: Theme.of(context).textTheme.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('ja');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of('Japanese'),
                        style: Theme.of(context).textTheme.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  selectLanguage(String languageCode) {
    constance.locale = languageCode;
    MyApp.setCustomeLanguage(context, languageCode);
  }

  openShowPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                AppLocalizations.of('Select theme mode'),
                style: headLineStyle.copyWith(fontSize: 18.0),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        changeColor(light);
                      },
                      child: CircleAvatar(
                        radius: 34,
                        backgroundColor:
                            Theme.of(context).textTheme.title.color,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 32,
                          child: Text(
                            AppLocalizations.of('Light'),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        changeColor(dark);
                      },
                      child: CircleAvatar(
                        radius: 34,
                        backgroundColor:
                            Theme.of(context).textTheme.title.color,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 32,
                          child: Text(
                            AppLocalizations.of('Dark'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectfirstColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFFEB1165),
                        child: !selectFirstColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectsecondColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFF32a852),
                        child: selectSecondColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectthirdColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFFe6230e),
                        child: selectThirdColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectfourthColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFF760ee6),
                        child: selectFourthColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectfifthColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFFdb0ee6),
                        child: selectFifthColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectsixthColor();
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFFdb164e),
                        child: selectSixthColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.white,
                              )
                            : SizedBox(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  selectfirstColor() {
    if (selectFirstColor) {
      setState(() {
        selectFirstColor = false;
        selectSecondColor = false;
        selectThirdColor = false;
        selectFourthColor = false;
        selectFifthColor = false;
        selectSixthColor = false;
      });
      MyApp.setCustomeTheme(context, 0);
    }
  }

  selectsecondColor() {
    if (!selectSecondColor) {
      setState(() {
        selectFirstColor = true;
        selectSecondColor = true;
        selectThirdColor = false;
        selectFourthColor = false;
        selectFifthColor = false;
        selectSixthColor = false;
      });
      MyApp.setCustomeTheme(context, 1);
    }
  }

  selectthirdColor() {
    if (!selectThirdColor) {
      setState(() {
        selectFirstColor = true;
        selectSecondColor = false;
        selectThirdColor = true;
        selectFourthColor = false;
        selectFifthColor = false;
        selectSixthColor = false;
      });
    }
    MyApp.setCustomeTheme(context, 2);
  }

  selectfourthColor() {
    if (!selectFourthColor) {
      setState(() {
        selectFirstColor = true;
        selectSecondColor = false;
        selectThirdColor = false;
        selectFourthColor = true;
        selectFifthColor = false;
        selectSixthColor = false;
      });
    }
    MyApp.setCustomeTheme(context, 3);
  }

  selectfifthColor() {
    if (!selectFifthColor) {
      setState(() {
        selectFirstColor = true;
        selectSecondColor = false;
        selectThirdColor = false;
        selectFourthColor = false;
        selectFifthColor = true;
        selectSixthColor = false;
      });
    }
    MyApp.setCustomeTheme(context, 4);
  }

  selectsixthColor() {
    if (!selectSixthColor) {
      setState(() {
        selectFirstColor = true;
        selectSecondColor = false;
        selectThirdColor = false;
        selectFourthColor = false;
        selectFifthColor = false;
        selectSixthColor = true;
      });
    }
    MyApp.setCustomeTheme(context, 5);
  }

  int light = 1;
  int dark = 2;

  changeColor(int color) {
    if (color == light) {
      MyApp.setCustomeTheme(context, 6);
    } else {
      MyApp.setCustomeTheme(context, 7);
    }
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.title.color,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => pushNavigator(context, EditPassword()),
            child: Text(
              AppLocalizations.of('Edit'),
              style: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
