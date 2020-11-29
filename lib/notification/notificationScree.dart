// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:my_cab_driver/drawer/drawer.dart';
// import '../appTheme.dart';
// import 'package:my_cab_driver/Language/appLocalizations.dart';

// class NotificationScreen extends StatefulWidget {
//   @override
//   _NotificationScreenState createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   var _scaffoldKey = new GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       key: _scaffoldKey,
//       drawer: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.75 < 400 ? MediaQuery.of(context).size.width * 0.75 : 350,
//         child: Drawer(
//           child: AppDrawer(
//             selectItemName: 'Notification',
//           ),
//         ),
//       ),
//       appBar: appBar(),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView(
//               children: <Widget>[
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Container(
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: <Widget>[
//                         CircleAvatar(
//                           backgroundColor: HexColor("#4252FF"),
//                           radius: 24,
//                           child: Icon(
//                             Icons.check_circle,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 16,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               AppLocalizations.of('System'),
//                               style: Theme.of(context).textTheme.body1.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                             ),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             Text(
//                               AppLocalizations.of('Booking #1234 has been succsess.'),
//                               style: Theme.of(context).textTheme.subtitle.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 1,
//                   color: Theme.of(context).dividerColor,
//                 ),
//                 Container(
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: <Widget>[
//                         CircleAvatar(
//                           backgroundColor: HexColor("#FED428"),
//                           radius: 24,
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 2),
//                               child: Icon(
//                                 FontAwesomeIcons.ticketAlt,
//                                 size: 22,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 16,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               AppLocalizations.of('Promotion'),
//                               style: Theme.of(context).textTheme.body1.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                             ),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             Text(
//                               AppLocalizations.of('Invite friends-GEt 3 coupens each!'),
//                               style: Theme.of(context).textTheme.subtitle.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 1,
//                   color: Theme.of(context).dividerColor,
//                 ),
//                 Container(
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: <Widget>[
//                         CircleAvatar(
//                           backgroundColor: HexColor("#FED428"),
//                           radius: 24,
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 2),
//                               child: Icon(
//                                 FontAwesomeIcons.ticketAlt,
//                                 size: 22,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 16,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               AppLocalizations.of('Promotion'),
//                               style: Theme.of(context).textTheme.body1.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                             ),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             Text(
//                               AppLocalizations.of('Invite friends-GEt 3 coupens each!'),
//                               style: Theme.of(context).textTheme.subtitle.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 1,
//                   color: Theme.of(context).dividerColor,
//                 ),
//                 Container(
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: <Widget>[
//                         CircleAvatar(
//                           backgroundColor: HexColor("#F52C56"),
//                           radius: 24,
//                           child: Center(
//                             child: CircleAvatar(
//                               backgroundColor: Colors.white,
//                               radius: 12,
//                               child: Icon(
//                                 Icons.close,
//                                 size: 20,
//                                 color: HexColor("#F52C56"),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 16,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               AppLocalizations.of('System'),
//                               style: Theme.of(context).textTheme.body1.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                             ),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             Text(
//                               AppLocalizations.of('Booking #156 has been cancelled.'),
//                               style: Theme.of(context).textTheme.subtitle.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 1,
//                   color: Theme.of(context).dividerColor,
//                 ),
//                 Container(
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: <Widget>[
//                         CircleAvatar(
//                           backgroundColor: HexColor("#4BE4B0"),
//                           radius: 24,
//                           child: Center(
//                             child: Icon(
//                               FontAwesomeIcons.wallet,
//                               size: 22,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 16,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               AppLocalizations.of('System'),
//                               style: Theme.of(context).textTheme.body1.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                             ),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             Text(
//                               AppLocalizations.of('Thank you Your transaction is done'),
//                               style: Theme.of(context).textTheme.subtitle.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                               overflow: TextOverflow.clip,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 1,
//                   color: Theme.of(context).dividerColor,
//                 ),
//                 Container(
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: <Widget>[
//                         CircleAvatar(
//                           backgroundColor: HexColor("#FED428"),
//                           radius: 24,
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 2),
//                               child: Icon(
//                                 FontAwesomeIcons.ticketAlt,
//                                 size: 22,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 16,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               AppLocalizations.of('Promotion'),
//                               style: Theme.of(context).textTheme.body1.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                             ),
//                             SizedBox(
//                               height: 2,
//                             ),
//                             Text(
//                               AppLocalizations.of('Invite friends-GEt 3 coupens each!'),
//                               style: Theme.of(context).textTheme.subtitle.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).textTheme.title.color,
//                                   ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 1,
//                   color: Theme.of(context).dividerColor,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).padding.bottom + 16,
//           )
//         ],
//       ),
//     );
//   }

//   Widget appBar() {
//     return AppBar(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       automaticallyImplyLeading: false,
//       title: Row(
//         children: <Widget>[
//           SizedBox(
//             height: AppBar().preferredSize.height,
//             width: AppBar().preferredSize.height + 40,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 alignment: Alignment.centerLeft,
//                 child: GestureDetector(
//                   onTap: () {
//                     _scaffoldKey.currentState.openDrawer();
//                   },
//                   child: Icon(
//                     Icons.dehaze,
//                     color: Theme.of(context).textTheme.title.color,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               AppLocalizations.of('Notifications'),
//               style: Theme.of(context).textTheme.title.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).textTheme.title.color,
//                   ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(
//             height: AppBar().preferredSize.height,
//             width: AppBar().preferredSize.height + 40,
//           ),
//         ],
//       ),
//     );
//   }
// }
