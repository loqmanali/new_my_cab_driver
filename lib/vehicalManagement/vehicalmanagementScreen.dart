import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/introduction/addVehicalScreen.dart';

class VehicalManagement extends StatefulWidget {
  @override
  _VehicalManagementState createState() => _VehicalManagementState();
}

class _VehicalManagementState extends State<VehicalManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 14),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 4,
              margin: EdgeInsets.all(0),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 30,
                          child: Icon(
                            FontAwesomeIcons.filePdf,
                            color: ConstanceData.secoundryFontColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of('Madza'),
                          style: Theme.of(context).textTheme.title.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.title.color,
                              ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          '42A 243.78',
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).disabledColor,
                              ),
                        ),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.check_circle,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.all(0),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 30,
                          child: Icon(
                            FontAwesomeIcons.filePdf,
                            color: ConstanceData.secoundryFontColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of('Mitsubishi'),
                          style: Theme.of(context).textTheme.title.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.title.color,
                              ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          '42A 243.78',
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).disabledColor,
                              ),
                        ),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.radio_button_unchecked,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewVehical(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    radius: 30,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 26,
                      child: Icon(
                        Icons.add,
                        color: ConstanceData.secoundryFontColor,
                        size: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + 16,
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
            AppLocalizations.of('Vehicle Management'),
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
