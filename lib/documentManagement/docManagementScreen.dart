import 'package:flutter/material.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/documentManagement/drivingLicenseScreen.dart';

class DocmanagementScreen extends StatefulWidget {
  @override
  _DocmanagementScreenState createState() => _DocmanagementScreenState();
}

class _DocmanagementScreenState extends State<DocmanagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 14),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.all(0),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 70, right: 20, bottom: 10, left: 20),
                                      child: Icon(
                                        Icons.person,
                                        size: 50,
                                        color: ConstanceData.secoundryFontColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).backgroundColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).backgroundColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).backgroundColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of('Identification cards'),
                                style: Theme.of(context).textTheme.title.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).textTheme.title.color,
                                    ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DrivingLicenseScreen(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(0),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 70, right: 20, bottom: 10, left: 20),
                                        child: Icon(
                                          Icons.person,
                                          size: 50,
                                          color: ConstanceData.secoundryFontColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).backgroundColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).backgroundColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).backgroundColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of('Driving License'),
                                  style: Theme.of(context).textTheme.title.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).textTheme.title.color,
                                      ),
                                )
                              ],
                            )
                          ],
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
    );
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
          Text(
            AppLocalizations.of('Document Management'),
            style: Theme.of(context).textTheme.title.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.title.color,
                ),
          ),
          SizedBox(),
        ],
      ),
    );
  }
}
