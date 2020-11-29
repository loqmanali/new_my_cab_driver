import 'package:flutter/material.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/pickup/driver_to_client_trip.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';

class UserDetailScreen extends StatefulWidget {
  final int userId;

  const UserDetailScreen({Key key, this.userId}) : super(key: key);
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColors,
      appBar: appbar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                userDetailbar(),
                // Container(
                //   height: 1,
                //   width: MediaQuery.of(context).size.width,
                //   color: Theme.of(context).dividerColor,
                // ),
                pickupAddress(),
                Container(
                  color: backGroundColors,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14, left: 14),
                    child: Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
                dropOffAddress(),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).dividerColor,
                ),
                noted(),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14, left: 14),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        MySeparator(
                          color: Theme.of(context).primaryColor,
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                tripFare(),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14, left: 14),
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        MySeparator(
                          color: Theme.of(context).primaryColor,
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                contact(),
                pickup(),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  Widget pickup() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(right: 60, left: 60, top: 16, bottom: 16),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DriverToClientTrip(),
              ),
            );
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: staticGreenColor,
            ),
            child: Center(
              child: Text(
                AppLocalizations.of('GO TO PICK UP'),
                style: buttonsText,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget contact() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: 70,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.lightBlueAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    AppLocalizations.of('Call'),
                    style: describtionStyle.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 70,
            //   width: 80,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16),
            //     color: HexColor("#4252FF"),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Icon(
            //         FontAwesomeIcons.facebookMessenger,
            //         color: Colors.white,
            //       ),
            //       SizedBox(
            //         height: 8,
            //       ),
            //       Text(
            //         AppLocalizations.of('Message'),
            //         style: Theme.of(context).textTheme.button.copyWith(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white,
            //             ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              height: 70,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.lightBlueAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                  Text(
                    AppLocalizations.of('Cancel'),
                    style: describtionStyle.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tripFare() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 14, left: 14, bottom: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of('TRIP FARE'),
              style: describtionStyle.copyWith(
                color: Colors.black26,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of('ApplePay'),
                  style: describtionStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '00.00 LE',
                  style: describtionStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of('Discount'),
                  style: describtionStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '00.00 LE',
                  style: describtionStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of('Paid amount'),
                  style: describtionStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '00.00 LE',
                  style: describtionStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget noted() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(right: 14, left: 14, bottom: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of('NOTED'),
              style: describtionStyle.copyWith(
                color: Colors.black26,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Wrap(
              children: <Widget>[
                Text(
                  "ميدان الرماية شارع الهرم",
                  style: describtionStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dropOffAddress() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 14, left: 14, bottom: 8, top: 8),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.of('DROP OFF'),
                  style: describtionStyle.copyWith(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "ميدان الرماية شارع الهرم",
                  style: describtionStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget pickupAddress() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 14, left: 14, bottom: 8, top: 8),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.of('PICKUP'),
                  style: describtionStyle.copyWith(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "حدايق الأهرام بوبة خوفو الهضبة",
                  style: describtionStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget userDetailbar() {
    return Container(
      color: Theme.of(context).dividerColor,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/profile_icon.png",
                height: 50,
                width: 50,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.of('Esther Berry'),
                  style: headLineStyle.copyWith(fontSize: 20.0),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 24,
                      width: 74,
                      child: Center(
                        child: Text(
                          AppLocalizations.of('ApplePay'),
                          style: describtionStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: staticGreenColor,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      height: 24,
                      width: 74,
                      child: Center(
                        child: Text(AppLocalizations.of('Discount'),
                            style: describtionStyle.copyWith(
                              color: Colors.white,
                            )),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: staticGreenColor,
                      ),
                    )
                  ],
                )
              ],
            ),
            Expanded(
              child: SizedBox(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '00.00 LE',
                  style: headLineStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  '00.00 km',
                  style: describtionStyle.copyWith(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget appbar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            '#123456',
            style: headLineStyle.copyWith(color: Colors.black, fontSize: 20.0),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      actions: [
        Image.asset("assets/images/setting_effect.PNG"),
      ],
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 4.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
