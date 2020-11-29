import 'package:flutter/material.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/controllers/navigators.dart';
import 'package:my_cab_driver/models/trip_model.dart';
import 'package:my_cab_driver/views/image_view.dart';

class TripWidget extends StatelessWidget {
  final TripModel _model;

  TripWidget(this._model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8, left: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(16),
              color: Colors.blue,
            ),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (this._model.hasImage)
                      pushNavigator(context,
                          ImageView(NetworkImage(this._model.clientImage)));
                  },
                  child: Hero(
                    tag: "image",
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(16),
                            topStart: Radius.circular(16)),
                        color: Colors.black12,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(14),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.7),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: this._model.hasImage
                                      ? NetworkImage("${this._model.clientImage}")
                                      : AssetImage("assets/profile_icon.png"),
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
                                  "${this._model.clientName}",
                                  style: headLineStyle.copyWith(
                                    fontSize: 18.0,
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
                                          style: describtionStyle.copyWith(
                                            color: Colors.blue,
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
                                            style: describtionStyle.copyWith(
                                                color: Colors.blue)),
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
                            Expanded(child: SizedBox()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('${_model.price}', style: buttonsText),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black12,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: 14, left: 14, bottom: 8, top: 8),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(AppLocalizations.of('PICKUP'),
                              style: describtionStyle.copyWith(
                                color: Colors.white,
                              )),
                          SizedBox(height: 4),
                          Container(
                            child: Text(
                              "${this._model.from}",
                              style: describtionStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.8,
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
                  padding:
                      EdgeInsets.only(right: 14, left: 14, bottom: 8, top: 8),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of('DROP OFF'),
                            style: describtionStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "${this._model.to}",
                              style: describtionStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom + 16,
        ),
      ],
    );
  }
}
