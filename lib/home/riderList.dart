import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/home/userDetail.dart';
import 'package:my_cab_driver/home/chatScreen.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';

class RiderList extends StatefulWidget {
  @override
  _RiderListState createState() => _RiderListState();
}

class _RiderListState extends State<RiderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColors,
      appBar: AppBar(
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
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              'Online',
              style: headLineStyle.copyWith(
                color: Colors.black,
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => ChatScreen(),
            //       ),
            //     );
            //   },
            //   child: SizedBox(
            //     child: Icon(
            //       FontAwesomeIcons.facebookMessenger,
            //       color: Theme.of(context).textTheme.title.color,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Container(
            //   height: AppBar().preferredSize.height,
            //   color: Theme.of(context).disabledColor,
            //   child: Padding(
            //     padding: const EdgeInsets.only(right: 14, left: 14),
            //     child: Row(
            //       children: <Widget>[
            //         Text(
            //           AppLocalizations.of('You have 10 new requess !!!'),
            //           style: Theme.of(context).textTheme.subhead.copyWith(
            //                 fontWeight: FontWeight.bold,
            //                 color: ConstanceData.secoundryFontColor,
            //               ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 6, left: 6),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailScreen(
                            userId: 1,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(16),
                        color: staticGreenColor,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(16),
                                topStart: Radius.circular(16),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(14),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of('Esther Berry'),
                                        style: describtionStyle.copyWith(
                                          color: Colors.white,
                                        ),
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
                                                style:
                                                    describtionStyle.copyWith(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            height: 24,
                                            width: 74,
                                            child: Center(
                                              child: Text(
                                                AppLocalizations.of('Discount'),
                                                style:
                                                    describtionStyle.copyWith(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                              color: Colors.white,
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
                                        style: describtionStyle.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '00.00 km',
                                        style: describtionStyle.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   height: 1,
                          //   width: MediaQuery.of(context).size.width,
                          //   color: Colors.black12,
                          // ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 14, left: 14, bottom: 8, top: 8),
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
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 14, left: 14),
                            child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black12,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 14, left: 14, bottom: 8, top: 8),
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
                          // Container(
                          //   height: 1,
                          //   width: MediaQuery.of(context).size.width,
                          //   color: Theme.of(context).dividerColor,
                          // ),
                          Padding(
                            padding:
                                EdgeInsets.only(right: 70, left: 70, top: 16),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueAccent,
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of('ACCEPT'),
                                  style: headLineStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                //=============================================
                // Padding(
                //   padding: EdgeInsets.only(right: 6, left: 6),
                //   child: InkWell(
                //     highlightColor: Colors.transparent,
                //     splashColor: Colors.transparent,
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => UserDetailScreen(
                //             userId: 2,
                //           ),
                //         ),
                //       );
                //     },
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadiusDirectional.circular(16),
                //         color: Theme.of(context).scaffoldBackgroundColor,
                //       ),
                //       child: Column(
                //         children: <Widget>[
                //           Container(
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadiusDirectional.only(
                //                   topEnd: Radius.circular(16),
                //                   topStart: Radius.circular(16)),
                //               //color: Theme.of(context).dividerColor,
                //             ),
                //             child: Padding(
                //               padding: const EdgeInsets.all(14),
                //               child: Row(
                //                 children: <Widget>[
                //                   ClipRRect(
                //                     borderRadius: BorderRadius.circular(10),
                //                     child: Image.asset(
                //                       ConstanceData.user1,
                //                       height: 50,
                //                       width: 50,
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     width: 8,
                //                   ),
                //                   Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: <Widget>[
                //                       Text(
                //                         AppLocalizations.of('Callie Greer'),
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .title
                //                             .copyWith(
                //                               fontWeight: FontWeight.bold,
                //                               color: Theme.of(context)
                //                                   .textTheme
                //                                   .title
                //                                   .color,
                //                             ),
                //                       ),
                //                       SizedBox(
                //                         height: 4,
                //                       ),
                //                       Row(
                //                         children: <Widget>[
                //                           Container(
                //                             height: 24,
                //                             width: 74,
                //                             child: Center(
                //                               child: Text(
                //                                 AppLocalizations.of('ApplePay'),
                //                                 style: Theme.of(context)
                //                                     .textTheme
                //                                     .button
                //                                     .copyWith(
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                       color: ConstanceData
                //                                           .secoundryFontColor,
                //                                     ),
                //                               ),
                //                             ),
                //                             decoration: BoxDecoration(
                //                               borderRadius: BorderRadius.all(
                //                                 Radius.circular(15),
                //                               ),
                //                               color: Theme.of(context)
                //                                   .primaryColor,
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 4,
                //                           ),
                //                           Container(
                //                             height: 24,
                //                             width: 74,
                //                             child: Center(
                //                               child: Text(
                //                                 AppLocalizations.of('Discount'),
                //                                 style: Theme.of(context)
                //                                     .textTheme
                //                                     .button
                //                                     .copyWith(
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                       color: ConstanceData
                //                                           .secoundryFontColor,
                //                                     ),
                //                               ),
                //                             ),
                //                             decoration: BoxDecoration(
                //                               borderRadius: BorderRadius.all(
                //                                 Radius.circular(15),
                //                               ),
                //                               color: Theme.of(context)
                //                                   .primaryColor,
                //                             ),
                //                           )
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                   Expanded(
                //                     child: SizedBox(),
                //                   ),
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.end,
                //                     children: <Widget>[
                //                       Text(
                //                         '\$20.00',
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .title
                //                             .copyWith(
                //                               fontWeight: FontWeight.bold,
                //                               color: Theme.of(context)
                //                                   .textTheme
                //                                   .title
                //                                   .color,
                //                             ),
                //                       ),
                //                       Text(
                //                         '1.5 km',
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .caption
                //                             .copyWith(
                //                               color: Theme.of(context)
                //                                   .disabledColor,
                //                               fontWeight: FontWeight.bold,
                //                             ),
                //                       ),
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           Container(
                //             height: 1,
                //             width: MediaQuery.of(context).size.width,
                //             color: Theme.of(context).dividerColor,
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(
                //                 right: 14, left: 14, bottom: 8, top: 8),
                //             child: Row(
                //               children: <Widget>[
                //                 Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: <Widget>[
                //                     Text(
                //                       AppLocalizations.of('PICKUP'),
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .caption
                //                           .copyWith(
                //                             color:
                //                                 Theme.of(context).disabledColor,
                //                             fontWeight: FontWeight.bold,
                //                           ),
                //                     ),
                //                     SizedBox(
                //                       height: 4,
                //                     ),
                //                     Text(
                //                       AppLocalizations.of('62 Kobe Trafficway'),
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .subtitle
                //                           .copyWith(
                //                             fontWeight: FontWeight.bold,
                //                             color: Theme.of(context)
                //                                 .textTheme
                //                                 .title
                //                                 .color,
                //                           ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(right: 14, left: 14),
                //             child: Container(
                //               height: 1,
                //               width: MediaQuery.of(context).size.width,
                //               color: Theme.of(context).dividerColor,
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(
                //                 right: 14, left: 14, bottom: 8, top: 8),
                //             child: Row(
                //               children: <Widget>[
                //                 Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: <Widget>[
                //                     Text(
                //                       AppLocalizations.of('DROP OFF'),
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .caption
                //                           .copyWith(
                //                             color:
                //                                 Theme.of(context).disabledColor,
                //                             fontWeight: FontWeight.bold,
                //                           ),
                //                     ),
                //                     SizedBox(
                //                       height: 4,
                //                     ),
                //                     Text(
                //                       AppLocalizations.of(
                //                           '280, AB Sunny willa'),
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .subtitle
                //                           .copyWith(
                //                             fontWeight: FontWeight.bold,
                //                             color: Theme.of(context)
                //                                 .textTheme
                //                                 .title
                //                                 .color,
                //                           ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Container(
                //             height: 1,
                //             width: MediaQuery.of(context).size.width,
                //             color: Theme.of(context).dividerColor,
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(
                //                 right: 14, left: 14, top: 16),
                //             child: Container(
                //               height: 40,
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10),
                //                 color: Theme.of(context).primaryColor,
                //               ),
                //               child: Center(
                //                 child: Text(
                //                   AppLocalizations.of('ACCEPT'),
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .button
                //                       .copyWith(
                //                         fontWeight: FontWeight.bold,
                //                         color: ConstanceData.secoundryFontColor,
                //                       ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             height: 16,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 16,
                // ),
                // Padding(
                //   padding: EdgeInsets.only(right: 6, left: 6),
                //   child: InkWell(
                //     highlightColor: Colors.transparent,
                //     splashColor: Colors.transparent,
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => UserDetailScreen(
                //             userId: 3,
                //           ),
                //         ),
                //       );
                //     },
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadiusDirectional.circular(16),
                //         color: Theme.of(context).scaffoldBackgroundColor,
                //       ),
                //       child: Column(
                //         children: <Widget>[
                //           Container(
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadiusDirectional.only(
                //                   topEnd: Radius.circular(16),
                //                   topStart: Radius.circular(16)),
                //               //color: Theme.of(context).dividerColor,
                //             ),
                //             child: Padding(
                //               padding: const EdgeInsets.all(14),
                //               child: Row(
                //                 children: <Widget>[
                //                   ClipRRect(
                //                     borderRadius: BorderRadius.circular(10),
                //                     child: Image.asset(
                //                       ConstanceData.user2,
                //                       height: 50,
                //                       width: 50,
                //                     ),
                //                   ),
                //                   SizedBox(
                //                     width: 8,
                //                   ),
                //                   Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: <Widget>[
                //                       Text(
                //                         AppLocalizations.of('Esther Berry'),
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .title
                //                             .copyWith(
                //                               fontWeight: FontWeight.bold,
                //                               color: Theme.of(context)
                //                                   .textTheme
                //                                   .title
                //                                   .color,
                //                             ),
                //                       ),
                //                       SizedBox(
                //                         height: 4,
                //                       ),
                //                       Row(
                //                         children: <Widget>[
                //                           Container(
                //                             height: 24,
                //                             width: 74,
                //                             child: Center(
                //                               child: Text(
                //                                 AppLocalizations.of('ApplePay'),
                //                                 style: Theme.of(context)
                //                                     .textTheme
                //                                     .button
                //                                     .copyWith(
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                       color: ConstanceData
                //                                           .secoundryFontColor,
                //                                     ),
                //                               ),
                //                             ),
                //                             decoration: BoxDecoration(
                //                               borderRadius: BorderRadius.all(
                //                                 Radius.circular(15),
                //                               ),
                //                               color: Theme.of(context)
                //                                   .primaryColor,
                //                             ),
                //                           ),
                //                           SizedBox(
                //                             width: 4,
                //                           ),
                //                           Container(
                //                             height: 24,
                //                             width: 74,
                //                             child: Center(
                //                               child: Text(
                //                                 AppLocalizations.of('Discount'),
                //                                 style: Theme.of(context)
                //                                     .textTheme
                //                                     .button
                //                                     .copyWith(
                //                                       fontWeight:
                //                                           FontWeight.bold,
                //                                       color: ConstanceData
                //                                           .secoundryFontColor,
                //                                     ),
                //                               ),
                //                             ),
                //                             decoration: BoxDecoration(
                //                               borderRadius: BorderRadius.all(
                //                                 Radius.circular(15),
                //                               ),
                //                               color: Theme.of(context)
                //                                   .primaryColor,
                //                             ),
                //                           )
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                   Expanded(
                //                     child: SizedBox(),
                //                   ),
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.end,
                //                     children: <Widget>[
                //                       Text(
                //                         '\$10.00',
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .title
                //                             .copyWith(
                //                               fontWeight: FontWeight.bold,
                //                               color: Theme.of(context)
                //                                   .textTheme
                //                                   .title
                //                                   .color,
                //                             ),
                //                       ),
                //                       Text(
                //                         '0.5 km',
                //                         style: Theme.of(context)
                //                             .textTheme
                //                             .caption
                //                             .copyWith(
                //                               color: Theme.of(context)
                //                                   .disabledColor,
                //                               fontWeight: FontWeight.bold,
                //                             ),
                //                       ),
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           Container(
                //             height: 1,
                //             width: MediaQuery.of(context).size.width,
                //             color: Theme.of(context).dividerColor,
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(
                //                 right: 14, left: 14, bottom: 8, top: 8),
                //             child: Row(
                //               children: <Widget>[
                //                 Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: <Widget>[
                //                     Text(
                //                       AppLocalizations.of('PICKUP'),
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .caption
                //                           .copyWith(
                //                             color:
                //                                 Theme.of(context).disabledColor,
                //                             fontWeight: FontWeight.bold,
                //                           ),
                //                     ),
                //                     SizedBox(
                //                       height: 4,
                //                     ),
                //                     Text(
                //                       AppLocalizations.of('25 Lcie Park Suite'),
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .subtitle
                //                           .copyWith(
                //                             fontWeight: FontWeight.bold,
                //                             color: Theme.of(context)
                //                                 .textTheme
                //                                 .title
                //                                 .color,
                //                           ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(right: 14, left: 14),
                //             child: Container(
                //               height: 1,
                //               width: MediaQuery.of(context).size.width,
                //               color: Theme.of(context).dividerColor,
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(
                //                 right: 14, left: 14, bottom: 8, top: 8),
                //             child: Row(
                //               children: <Widget>[
                //                 Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: <Widget>[
                //                     Text(
                //                       AppLocalizations.of('DROP OFF'),
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .caption
                //                           .copyWith(
                //                             color:
                //                                 Theme.of(context).disabledColor,
                //                             fontWeight: FontWeight.bold,
                //                           ),
                //                     ),
                //                     SizedBox(
                //                       height: 4,
                //                     ),
                //                     Text(
                //                       AppLocalizations.of(
                //                           '187/ William St, London, UK'),
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .subtitle
                //                           .copyWith(
                //                             fontWeight: FontWeight.bold,
                //                             color: Theme.of(context)
                //                                 .textTheme
                //                                 .title
                //                                 .color,
                //                           ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ),
                //           Container(
                //             height: 1,
                //             width: MediaQuery.of(context).size.width,
                //             color: Theme.of(context).dividerColor,
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(
                //                 right: 14, left: 14, top: 16),
                //             child: Container(
                //               height: 40,
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10),
                //                 color: Theme.of(context).primaryColor,
                //               ),
                //               child: Center(
                //                 child: Text(
                //                   'Accept',
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .button
                //                       .copyWith(
                //                         fontWeight: FontWeight.bold,
                //                         color: ConstanceData.secoundryFontColor,
                //                       ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             height: 16,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).padding.bottom + 16,
            // )
          ],
        ),
      ),
    );
  }
}
