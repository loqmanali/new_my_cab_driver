import 'package:flutter/material.dart';

import 'package:my_cab_driver/constance/constance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../main.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  PageController pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  void _getPrefrences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var drivertoken = prefs.getString("driverRegisterToken");
    var loginToken = prefs.getString("driverLoginToken");
    if (drivertoken != null || loginToken != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.SelectDstrict, (route) => false);
    }
  }

  @override
  void initState() {
    _getPrefrences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Image.asset(
                "assets/splash/intro1.PNG",
                fit: BoxFit.cover,
                height: 250,
                width: 250,
              ),
            ),
            Text(AppLocalizations.of('Accept a Job'), style: headLineStyle),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Text(
                AppLocalizations.of('AcceptJob'),
                textAlign: TextAlign.center,
                style: describtionStyle,
              ),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/splash/intro2.PNG",
              fit: BoxFit.cover,
              height: 250,
              width: 250,
            ),
            SizedBox(height: 20.0),
            Text(
              AppLocalizations.of('Tracking Realtime'),
              style: headLineStyle,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Text(
                AppLocalizations.of('TrackingTime'),
                textAlign: TextAlign.center,
                style: describtionStyle,
              ),
            ),
          ],
        ),
      ),
      //==========================================================================
      Container(
        margin: EdgeInsets.only(bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/splash/intro3.PNG",
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
            SizedBox(height: 10.0),
            Text(
              AppLocalizations.of('Earn Money'),
              style: headLineStyle,
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Text(
                AppLocalizations.of('EarnMoney'),
                style: describtionStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.0, right: 50.0),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.ENABLELOCATION);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: staticGreenColor),
                  child: Center(
                    child: Text(
                      AppLocalizations.of('GET STARTED'),
                      style: buttonsText,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    PageView(
                      controller: pageController,
                      children: children,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 20.0),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: SmoothPageIndicator(
                              effect: ExpandingDotsEffect(
                                activeDotColor: staticGreenColor,
                              ),
                              controller: pageController,
                              count: 3,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
