import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/controllers/navigators.dart';
import 'package:my_cab_driver/controllers/user_data_provider.dart';
import 'package:my_cab_driver/models/driver_info.dart';
import 'package:my_cab_driver/providers/driver_info_provider.dart';
import 'package:my_cab_driver/views/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class AppDrawer extends StatefulWidget {
  final String selectItemName;

  const AppDrawer({Key key, this.selectItemName}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  UserDataProvider _userDataProvider;

  @override
  void didChangeDependencies() {
    this._userDataProvider = Provider.of<UserDataProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<DriverInfoProvider>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: staticGreenColor,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 14, left: 14),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 62.0,
                          width: 62.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: (this._userDataProvider.imageUrl == null)
                                  ? AssetImage("assets/profile_icon.png")
                                  : NetworkImage(
                                      "${this._userDataProvider.imageUrl}"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${this._userDataProvider.name}",
                              style: headLineStyle.copyWith(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "+02 ${this._userDataProvider.phone}",
                              style: describtionStyle.copyWith(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: <Widget>[
                  //     Column(
                  //       children: <Widget>[
                  //         Icon(
                  //           FontAwesomeIcons.clock,
                  //           color: ConstanceData.secoundryFontColor,
                  //           size: 18,
                  //         ),
                  //         SizedBox(
                  //           height: 4,
                  //         ),
                  //         Text(
                  //           '00.00',
                  //           style: describtionStyle.copyWith(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //         Row(
                  //           children: <Widget>[
                  //             Text(
                  //               AppLocalizations.of('Hourse online'),
                  //               style: describtionStyle.copyWith(
                  //                   fontSize: 13.0,
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.bold),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: <Widget>[
                  //         Icon(
                  //           FontAwesomeIcons.tachometerAlt,
                  //           color: Colors.white,
                  //           size: 18,
                  //         ),
                  //         SizedBox(
                  //           height: 4,
                  //         ),
                  //         Text(
                  //           '00.00 KM',
                  //           style: describtionStyle.copyWith(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //         Row(
                  //           children: <Widget>[
                  //             Text(
                  //               AppLocalizations.of('Total Distance'),
                  //               style: describtionStyle.copyWith(
                  //                   fontSize: 13.0,
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.bold),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: <Widget>[
                  //         Icon(
                  //           FontAwesomeIcons.rocket,
                  //           color: ConstanceData.secoundryFontColor,
                  //           size: 20,
                  //         ),
                  //         SizedBox(
                  //           height: 4,
                  //         ),
                  //         Text(
                  //           '00.00',
                  //           style: describtionStyle.copyWith(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //         Row(
                  //           children: <Widget>[
                  //             Text(
                  //               AppLocalizations.of('Total Job'),
                  //               style: Theme.of(context)
                  //                   .textTheme
                  //                   .caption
                  //                   .copyWith(
                  //                     fontWeight: FontWeight.bold,
                  //                     color: ConstanceData.secoundryFontColor,
                  //                   ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: columDetail(),
          )
        ],
      ),
    );
  }

  Widget columDetail() {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 26,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  if (widget.selectItemName != 'Home') {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.HOME, (Route<dynamic> route) => false);
                  }
                },
                child: Row(
                  children: <Widget>[
                    widget.selectItemName == 'Home'
                        ? selectedData()
                        : SizedBox(),
                    Icon(
                      Icons.home,
                      size: 28,
                      color: staticGreenColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      AppLocalizations.of('Home'),
                      style: headLineStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: () {
                  pushNavigator(context, MyChatScreen());
                },
                child: Row(
                  children: <Widget>[
                    widget.selectItemName == 'Chat'
                        ? selectedData()
                        : SizedBox(),
                    Icon(
                      Icons.chat_bubble,
                      size: 28,
                      color: staticGreenColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      AppLocalizations.of('Chat'),
                      style: headLineStyle.copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              // InkWell(
              //   onTap: () {
              //     Navigator.pop(context);
              //     if (widget.selectItemName != 'Wallet') {
              //       Navigator.pushNamedAndRemoveUntil(context, Routes.WALLET,
              //           (Route<dynamic> route) => false);
              //     }
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 4),
              //     child: Row(
              //       children: <Widget>[
              //         widget.selectItemName == 'Wallet'
              //             ? selectedData()
              //             : SizedBox(),
              //         Icon(
              //           FontAwesomeIcons.wallet,
              //           size: 20,
              //           color: staticGreenColor.withOpacity(0.6),
              //         ),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //           AppLocalizations.of('Wallet'),
              //           style: headLineStyle.copyWith(
              //             fontSize: 16.0,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 32,
              // ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  if (widget.selectItemName != 'History') {
                    Navigator.pushNamedAndRemoveUntil(context, Routes.HISTORY,
                        (Route<dynamic> route) => false);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: <Widget>[
                      widget.selectItemName == 'History'
                          ? selectedData()
                          : SizedBox(),
                      Icon(
                        FontAwesomeIcons.history,
                        size: 20,
                        color: staticGreenColor.withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppLocalizations.of('History'),
                        style: headLineStyle.copyWith(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 32,
              // ),
              // InkWell(
              //   highlightColor: Colors.transparent,
              //   splashColor: Colors.transparent,
              //   onTap: () {
              //     Navigator.pop(context);
              //     if (widget.selectItemName != 'Notification') {
              //       Navigator.pushNamedAndRemoveUntil(context,
              //           Routes.NOTIFICATION, (Route<dynamic> route) => false);
              //     }
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 4),
              //     child: Row(
              //       children: <Widget>[
              //         widget.selectItemName == 'Notification'
              //             ? selectedData()
              //             : SizedBox(),
              //         Icon(
              //           FontAwesomeIcons.solidBell,
              //           size: 20,
              //           color: staticGreenColor.withOpacity(0.6),
              //         ),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //           AppLocalizations.of('Notifications'),
              //           style: headLineStyle.copyWith(
              //             fontSize: 16.0,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 32,
              ),
              // InkWell(
              //   highlightColor: Colors.transparent,
              //   splashColor: Colors.transparent,
              //   onTap: () {
              //     Navigator.pop(context);
              //     if (widget.selectItemName != 'Invite') {
              //       Navigator.pushNamedAndRemoveUntil(context, Routes.INVITE,
              //           (Route<dynamic> route) => false);
              //     }
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 4),
              //     child: Row(
              //       children: <Widget>[
              //         widget.selectItemName == 'Invite'
              //             ? selectedData()
              //             : SizedBox(),
              //         Icon(
              //           FontAwesomeIcons.gifts,
              //           size: 20,
              //           color: staticGreenColor.withOpacity(0.6),
              //         ),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //           AppLocalizations.of('Invite Friends'),
              //           style: headLineStyle.copyWith(
              //             fontSize: 16.0,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 32,
              // ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                  if (widget.selectItemName != 'Setting') {
                    Navigator.pushNamedAndRemoveUntil(context, Routes.SETTING,
                        (Route<dynamic> route) => false);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: <Widget>[
                      widget.selectItemName == 'Setting'
                          ? selectedData()
                          : SizedBox(),
                      Icon(
                        FontAwesomeIcons.cog,
                        size: 20,
                        color: staticGreenColor.withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppLocalizations.of('Settings'),
                        style: headLineStyle.copyWith(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove("driverLoginToken");
                  prefs.remove("driverRegisterToken");
                  prefs.remove("carDetails");
                  Navigator.pushNamedAndRemoveUntil(context,
                      Routes.INTRODUCTION, (Route<dynamic> route) => false);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.signOutAlt,
                        size: 20,
                        color: staticGreenColor.withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppLocalizations.of('Logout'),
                        style: headLineStyle.copyWith(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 16,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget selectedData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 28,
          width: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.blue,
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
