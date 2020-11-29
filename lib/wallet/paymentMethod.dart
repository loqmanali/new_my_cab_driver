import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.only(right: 8, left: 8, top: 10),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: staticGreenColor,
                      radius: 24,
                      child: Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(
                          FontAwesomeIcons.creditCard,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      AppLocalizations.of('Add a new card'),
                      style: describtionStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: staticGreenColor,
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Row(
                children: <Widget>[
                  Text(
                    AppLocalizations.of('CREDIT CARDS'),
                    style:
                        describtionStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(left: 4, right: 6),
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: staticGreenColor,
                                radius: 24,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Icon(
                                    FontAwesomeIcons.ccVisa,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '**** **** ****3785',
                                    style: describtionStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of('VISA'),
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
                        Container(
                          height: 0.5,
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: staticGreenColor,
                                radius: 24,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Icon(
                                    FontAwesomeIcons.paypal,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Preffre_ellen@balister.net',
                                    style: describtionStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of('Paypal'),
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
                        Container(
                          height: 0.5,
                          color: Colors.black12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: staticGreenColor,
                                radius: 24,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    FontAwesomeIcons.ccMastercard,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '**** **** ****3785',
                                    style: describtionStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of('Master Card'),
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
                        Container(
                          height: 0.5,
                          color: Colors.black12,
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
    );
  }

  Widget appBar() {
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
          SizedBox(
            width: 16,
          ),
          AutoSizeText(
            AppLocalizations.of('Payment method'),
            style: headLineStyle.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
      actions: [
        Image.asset("assets/images/setting_effect.PNG"),
      ],
    );
  }
}
