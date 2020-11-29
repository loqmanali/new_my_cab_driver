import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/drawer/drawer.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:http/http.dart' as http;
import 'package:my_cab_driver/models/history_model.dart';
import 'package:my_cab_driver/models/trip_model.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:my_cab_driver/controllers/user_data_provider.dart';
import 'package:my_cab_driver/widgets/trip_widget.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  HistoryModel _model;
  UserDataProvider _userDataProvider;
  bool _providerInit = false;

  final String _url = "https://gardentaxi.net/Back_End/public/api/driver/tripe";

  Future<void> _getTrips() async {
    http.Response res = await http.post("${this._url}",
        body: {"api_token": "${this._userDataProvider.token}"});
    Map<String, dynamic> data =
        Map<String, dynamic>.from(json.decode(res.body));

    setState(() => this._model = new HistoryModel.fromMap(data));
  }

  @override
  void didChangeDependencies() {
    this._userDataProvider = Provider.of<UserDataProvider>(context);
    if (!this._providerInit) {
      this._providerInit = true;
      this._getTrips();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _scaffoldKey,
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75 < 400
            ? MediaQuery.of(context).size.width * 0.75
            : 350,
        child: Drawer(
          child: AppDrawer(selectItemName: 'History'),
        ),
      ),
      appBar: appBar(),
      body: Column(
        children: <Widget>[
          Container(
            height: 1.5,
            color: Colors.black12,
          ),
          if (this._model != null) jobsAndEarns(),
          SizedBox(height: 8),
          Expanded(
            child: (this._model == null)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: this._model.trips.length,
                    itemBuilder: (BuildContext context, int index) =>
                        TripWidget(this._model.trips[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget jobsAndEarns() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: staticGreenColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.carAlt,
                      size: 40,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of('Total Job'),
                          style: buttonsText.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${this._model.totalTrips}',
                          style: describtionStyle.copyWith(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: staticGreenColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.dollarSign,
                      size: 38,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of('Earned'),
                          style: describtionStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${this._model.driverEarning} LE',
                            style: describtionStyle.copyWith(
                              color: Colors.white,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: AppBar().preferredSize.height,
            //width: AppBar().preferredSize.height + 40,
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 5.0),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.dehaze),
                      color: Colors.blue,
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            AppLocalizations.of('History'),
            style: headLineStyle.copyWith(color: Colors.black, fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: AppBar().preferredSize.height,
            //width: AppBar().preferredSize.height + 40,
          ),
        ],
      ),
      actions: [
        Image.asset("assets/images/setting_effect.PNG"),
      ],
    );
  }

// Widget celanderList() {
//   return Container(
//     padding: EdgeInsets.only(top: 8, bottom: 8),
//     color: Theme.of(context).scaffoldBackgroundColor,
//     height: 80,
//     // child: ListView(
//     //   scrollDirection: Axis.horizontal,
//     //   children: <Widget>[
//     //     Container(
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(16),
//     //         color: Theme.of(context).backgroundColor,
//     //       ),
//     //       child: Padding(
//     //         padding: EdgeInsets.all(8.0),
//     //         child: Column(
//     //           children: <Widget>[
//     //             Text(
//     //               AppLocalizations.of('Sun'),
//     //               style: Theme.of(context).textTheme.button.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //             Expanded(
//     //               child: SizedBox(),
//     //             ),
//     //             Text(
//     //               '1',
//     //               style: Theme.of(context).textTheme.title.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //       width: 50,
//     //     ),
//     //     SizedBox(
//     //       width: 8,
//     //     ),
//     //     Container(
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(16),
//     //         color: Theme.of(context).scaffoldBackgroundColor,
//     //         border:
//     //             Border.all(color: Theme.of(context).primaryColor, width: 1),
//     //       ),
//     //       child: Padding(
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Column(
//     //           children: <Widget>[
//     //             Text(
//     //               AppLocalizations.of('Mon'),
//     //               style: Theme.of(context).textTheme.button.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).primaryColor,
//     //                   ),
//     //             ),
//     //             Expanded(
//     //               child: SizedBox(),
//     //             ),
//     //             Text(
//     //               '2',
//     //               style: Theme.of(context).textTheme.title.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).primaryColor,
//     //                   ),
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //       width: 50,
//     //     ),
//     //     SizedBox(
//     //       width: 8,
//     //     ),
//     //     Container(
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(16),
//     //         color: Theme.of(context).backgroundColor,
//     //       ),
//     //       child: Padding(
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Column(
//     //           children: <Widget>[
//     //             Text(
//     //               AppLocalizations.of('Tue'),
//     //               style: Theme.of(context).textTheme.button.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //             Expanded(
//     //               child: SizedBox(),
//     //             ),
//     //             Text(
//     //               '3',
//     //               style: Theme.of(context).textTheme.title.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //       width: 50,
//     //     ),
//     //     SizedBox(
//     //       width: 8,
//     //     ),
//     //     Container(
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(16),
//     //         color: Theme.of(context).backgroundColor,
//     //       ),
//     //       child: Padding(
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Column(
//     //           children: <Widget>[
//     //             Text(
//     //               AppLocalizations.of('Wed'),
//     //               style: Theme.of(context).textTheme.button.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //             Expanded(
//     //               child: SizedBox(),
//     //             ),
//     //             Text(
//     //               '4',
//     //               style: Theme.of(context).textTheme.title.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //       width: 50,
//     //     ),
//     //     SizedBox(
//     //       width: 8,
//     //     ),
//     //     Container(
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(16),
//     //         color: Theme.of(context).backgroundColor,
//     //       ),
//     //       child: Padding(
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Column(
//     //           children: <Widget>[
//     //             Text(
//     //               AppLocalizations.of('Thu'),
//     //               style: Theme.of(context).textTheme.button.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //             Expanded(
//     //               child: SizedBox(),
//     //             ),
//     //             Text(
//     //               '5',
//     //               style: Theme.of(context).textTheme.title.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //       width: 50,
//     //     ),
//     //     SizedBox(
//     //       width: 8,
//     //     ),
//     //     Container(
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(16),
//     //         color: Theme.of(context).backgroundColor,
//     //       ),
//     //       child: Padding(
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Column(
//     //           children: <Widget>[
//     //             Text(
//     //               AppLocalizations.of('Fri'),
//     //               style: Theme.of(context).textTheme.button.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //             Expanded(
//     //               child: SizedBox(),
//     //             ),
//     //             Text(
//     //               '6',
//     //               style: Theme.of(context).textTheme.title.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //       width: 50,
//     //     ),
//     //     SizedBox(
//     //       width: 8,
//     //     ),
//     //     Container(
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(16),
//     //         color: Theme.of(context).backgroundColor,
//     //       ),
//     //       child: Padding(
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Column(
//     //           children: <Widget>[
//     //             Text(
//     //               AppLocalizations.of('Sat'),
//     //               style: Theme.of(context).textTheme.button.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //             Expanded(
//     //               child: SizedBox(),
//     //             ),
//     //             Text(
//     //               '7',
//     //               style: Theme.of(context).textTheme.title.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //       width: 50,
//     //     ),
//     //     SizedBox(
//     //       width: 8,
//     //     ),
//     //     Container(
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(16),
//     //         color: Theme.of(context).backgroundColor,
//     //       ),
//     //       child: Padding(
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: Column(
//     //           children: <Widget>[
//     //             Text(
//     //               AppLocalizations.of('Sun'),
//     //               style: Theme.of(context).textTheme.button.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //             Expanded(
//     //               child: SizedBox(),
//     //             ),
//     //             Text(
//     //               '8',
//     //               style: Theme.of(context).textTheme.title.copyWith(
//     //                     fontWeight: FontWeight.bold,
//     //                     color: Theme.of(context).disabledColor,
//     //                   ),
//     //             ),
//     //           ],
//     //         ),
//     //       ),
//     //       width: 50,
//     //     ),
//     //   ],
//     // ),
//   );
// }
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:my_cab_driver/constance/constance.dart';
// import 'package:my_cab_driver/drawer/drawer.dart';
// import 'package:my_cab_driver/Language/appLocalizations.dart';
// import 'package:http/http.dart' as http;
// import 'package:my_cab_driver/models/trip_model.dart';
// import 'dart:convert';
// import 'package:provider/provider.dart';
// import 'package:my_cab_driver/controllers/user_data_provider.dart';
// import 'package:my_cab_driver/widgets/trip_widget.dart';
//
// class HistoryScreen extends StatefulWidget {
//   @override
//   _HistoryScreenState createState() => _HistoryScreenState();
// }
//
// class _HistoryScreenState extends State<HistoryScreen> {
//   var _scaffoldKey = new GlobalKey<ScaffoldState>();
//   List<TripModel> _trips;
//   UserDataProvider _userDataProvider;
//   bool _providerInit = false;
//
//   final String _url = "https://gardentaxi.net/Back_End/public/api/driver/tripe";
//
//   Future<void> _getTrips() async {
//     http.Response res = await http.post("${this._url}",
//         body: {"api_token": "${this._userDataProvider.token}"});
//     Map<String, dynamic> data =
//         Map<String, dynamic>.from(json.decode(res.body));
//     print("Data : $data");
