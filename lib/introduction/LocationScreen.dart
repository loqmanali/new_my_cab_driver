import 'package:flutter/material.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/main.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';

class EnableLocation extends StatefulWidget {
  @override
  _EnableLocationState createState() => _EnableLocationState();
}

class _EnableLocationState extends State<EnableLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SizedBox(),
              flex: 4,
            ),
            Image.asset(
              "assets/images/enableLocation.PNG",
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
            Expanded(
              child: SizedBox(),
              flex: 3,
            ),
            Text(
              AppLocalizations.of('Enable Your Location'),
              style: headLineStyle,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Text(
                AppLocalizations.of('EnableLocation'),
                style: describtionStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: SizedBox(),
              flex: 2,
            ),
            Padding(
              padding: EdgeInsets.only(right: 50, left: 50),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.AUTH);
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: staticGreenColor,
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of('USE MY LOCATION'),
                      style: buttonsText,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
              flex: 1,
            ),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.AUTH);
              },
              child: SizedBox(
                height: 40,
                child: Center(
                  child: Text(AppLocalizations.of('Skip for now'),
                      style: skipButtons),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
