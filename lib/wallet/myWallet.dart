import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/drawer/drawer.dart';
import 'package:my_cab_driver/wallet/paymentMethod.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';

class MyWallet extends StatefulWidget {
  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backGroundColors,
      appBar: appBar(),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75 < 400
            ? MediaQuery.of(context).size.width * 0.75
            : 350,
        child: Drawer(
          child: AppDrawer(
            selectItemName: 'Wallet',
          ),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: staticGreenColor,
                  child: Padding(
                    padding: EdgeInsets.only(right: 14, left: 14, top: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(6),
                                      child: Text(
                                        AppLocalizations.of('Cash'),
                                        style: buttonsText.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(6),
                                      child: Text(
                                        AppLocalizations.of('Discount'),
                                        style: buttonsText.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Expanded(
                        //   child: SizedBox(),
                        // ),
                        Text(
                          '00.00 LE',
                          style: headLineStyle.copyWith(
                            fontSize: 35.0,
                            color: Colors.white,
                          ),
                        ),
                        // SizedBox(
                        //   height: 8,
                        // ),
                        Text(
                          AppLocalizations.of('TOTAL EARN'),
                          style: headLineStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        // SizedBox(
                        //   height: 32,
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(right: 14, left: 14, top: 40, bottom: 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of('PAYMENT HISTORY'),
                          style: describtionStyle.copyWith(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(right: 14, left: 14, bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        "assets/profile_icon.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of('Elve Bamett'),
                                        style: buttonsText.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '#6467488',
                                        style: buttonsText.copyWith(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox()),
                                  Text(
                                    '00.00 LE',
                                    style: buttonsText.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 0.5,
                              color: Theme.of(context).disabledColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        "assets/profile_icon.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of('Isaiah Francis'),
                                        style: buttonsText.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '#568677',
                                        style: buttonsText.copyWith(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox()),
                                  Text(
                                    '00.00 LE',
                                    style: buttonsText.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 0.5, color: Colors.black26),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        "assets/profile_icon.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of('Luala Briggs'),
                                        style: buttonsText.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '#464654',
                                        style: buttonsText.copyWith(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox()),
                                  Text(
                                    '00.00 LE',
                                    style: buttonsText.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 0.5, color: Colors.black26),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        "assets/profile_icon.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of('Ray Young'),
                                        style: buttonsText.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '#8089056',
                                        style: buttonsText.copyWith(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox()),
                                  Text(
                                    '00.00 LE',
                                    style: buttonsText.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(height: 0.5, color: Colors.black26),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 24,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        "assets/profile_icon.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of('Betty Palmer'),
                                        style: buttonsText.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '#89548789',
                                        style: buttonsText.copyWith(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox()),
                                  Text(
                                    '00.00 LE',
                                    style: buttonsText.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 0.0, left: 0.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentMethod(),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.blueAccent,
                      elevation: 8,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: Text("LE"),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(AppLocalizations.of('Payment method'),
                                style: describtionStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                            Expanded(
                              child: SizedBox(),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
                flex: 6,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: <Widget>[
          SizedBox(
            height: AppBar().preferredSize.height,
            //width: AppBar().preferredSize.height + 40,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5.0,
                    )
                  ],
                  color: Colors.white,
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
          Text(
            AppLocalizations.of('My Wallet'),
            style: headLineStyle.copyWith(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          // SizedBox(
          //   height: AppBar().preferredSize.height,
          //   width: AppBar().preferredSize.height + 0.0,
          // ),
        ],
      ),
      actions: [
        Image.asset(
          "assets/images/setting_effect.PNG",
        )
      ],
    );
  }
}
