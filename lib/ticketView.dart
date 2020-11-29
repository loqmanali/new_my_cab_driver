import 'package:flutter/material.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'home/userDetail.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';

class TicketDesign extends StatefulWidget {
  @override
  _TicketDesignState createState() => _TicketDesignState();
}

class _TicketDesignState extends State<TicketDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: staticGreenColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: staticGreenColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 14, left: 14),
                child: FlutterTicketWidget(
                  isCornerRounded: true,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                ConstanceData.user1,
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
                                  style: headLineStyle.copyWith(fontSize: 18.0),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: ConstanceData
                                                    .secoundryFontColor,
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
                                        child: Text(
                                          AppLocalizations.of('Discount'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: ConstanceData
                                                    .secoundryFontColor,
                                              ),
                                        ),
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
                                  '25.0 LE',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .textTheme
                                            .title
                                            .color,
                                      ),
                                ),
                                Text(
                                  '2.2 km',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context).disabledColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 14, left: 14, bottom: 8, top: 8),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of('PICKUP'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color:
                                              Theme.of(context).disabledColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of('79 Swift Village'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .title
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 14, left: 14),
                          child: Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                      ),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 14, left: 14, bottom: 8, top: 8),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of('DROP OFF'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color:
                                              Theme.of(context).disabledColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    AppLocalizations.of(
                                        '115 William St, Chicago, US'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .title
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Theme.of(context).dividerColor,
                      ),
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 24, left: 30, bottom: 8, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of('NOTED'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context).disabledColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Wrap(
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(
                                        'Lorem ipsum dolor sit amet, consectetur adipisc elit. Nullam ac vestibulum erat. Cras vulputate auctor lectus at consequat.'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .title
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 14, left: 14, bottom: 8, top: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of('TRIP FARE'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context).disabledColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of('ApplePay'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .title
                                              .color,
                                        ),
                                  ),
                                  Text(
                                    '15.00 LE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .title
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of('Discount'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .title
                                              .color,
                                        ),
                                  ),
                                  Text(
                                    '10.00 LE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .title
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of('Paid amount'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .title
                                              .color,
                                        ),
                                  ),
                                  Text(
                                    '25.00 LE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textTheme
                                              .title
                                              .color,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 14, left: 14, top: 8, bottom: 14),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.pop(context);
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
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ConstanceData.secoundryFontColor,
                                    ),
                              ),
                            ),
                          ),
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

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class FlutterTicketWidget extends StatefulWidget {
  final Widget child;
  final Color color;
  final bool isCornerRounded;

  FlutterTicketWidget(
      {@required this.child,
      this.color = Colors.white,
      this.isCornerRounded = false});

  @override
  _FlutterTicketWidgetState createState() => _FlutterTicketWidgetState();
}

class _FlutterTicketWidgetState extends State<FlutterTicketWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        child: widget.child,
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: widget.isCornerRounded
                ? BorderRadius.circular(10)
                : BorderRadius.circular(0.0)),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: 20.0));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: 20.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
