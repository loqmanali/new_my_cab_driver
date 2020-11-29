import 'package:flutter/material.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';

import '../main.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  var appBarheight = 0.0;
  var otpController = TextEditingController();
  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appBarheight = AppBar().preferredSize.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 0.0, left: 14),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: appBarheight,
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: appBarheight,
                ),
                Text(
                  AppLocalizations.of('Phone Verification'),
                  style: headLineStyle.copyWith(fontSize: 35.0),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  AppLocalizations.of('Enter your OTP code here'),
                  style: describtionStyle,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Stack(
                    children: <Widget>[
                      getOtpTextUI(otptxt: otpController.text),
                      Opacity(
                        opacity: 0.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextField(
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          controller: otpController,
                                          maxLength: 4,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 32, left: 32),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          Routes.AddVehicle, (Route<dynamic> route) => false);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: staticGreenColor,
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of('VERIFY NOW'),
                          style: buttonsText,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/images/effect.PNG",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget getOtpTextUI({String otptxt = ""}) {
    List<Widget> otplist = List<Widget>();
    Widget getUI({String otxt = ""}) {
      return Expanded(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            Text(
              otxt,
              style: headLineStyle,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 2.5,
                width: 50.0,
                color: Colors.black,
              ),
            )
          ],
        ),
      );
    }

    for (var i = 0; i < 4; i++) {
      otplist.add(getUI(otxt: otptxt.length > i ? otptxt[i] : ""));
    }
    return Row(
      children: otplist,
    );
  }
}
