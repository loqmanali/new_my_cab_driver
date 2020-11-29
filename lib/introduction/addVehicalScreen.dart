import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/controllers/shared_preference.dart';
import 'package:my_cab_driver/controllers/user_data_provider.dart';
import 'package:my_cab_driver/main.dart';
import 'package:http/http.dart' as http;
import 'package:my_cab_driver/upload_image.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewVehical extends StatefulWidget {
  @override
  _AddNewVehicalState createState() => _AddNewVehicalState();
}

class _AddNewVehicalState extends State<AddNewVehical> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController plateController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    plateController.dispose();
    colorController.dispose();
    super.dispose();
  }

  Future<void> insertCarData() async {
    try {
      String url = "https://gardentaxi.net/Back_End/public/api/car/add";
      Map<String, dynamic> resBody = {
        "brand": brandController.text,
        "type": modelController.text,
        "color": colorController.text,
        "number": plateController.text,
      };
      var data = await http.post(url, body: resBody);

      if (data.statusCode == 200) {
        print(data.body);
        this._userDataProvider.insertCartData(resBody);
      }
    } catch (e) {
      print(e);
    }
    return;
  }

  Future<void> _sendImages() async {
    final String url =
        "https://gardentaxi.net/Back_End/public/api/driver/verify_paper_check";
    try {
      Map<String, dynamic> resBody = {
        "img_url_id": "${this._imgUrlIdMap['original']}",
        "img_url_car": "${this._imgUrlCarMap['original']}",
        "api_token": "${this._userDataProvider.token}",
      };
      var data = await http.post(url, body: resBody);
      print("Data In Send Images: ${resBody}");
      if (data.statusCode == 200) this._userDataProvider.setCarImages(resBody);
    } catch (e) {
      print(e);
    }
  }

  void savedPrefrences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("carDetails", [
      brandController.text,
      modelController.text,
      colorController.text,
      plateController.text,
    ]);
  }

  void _getPrefrences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cardetails = prefs.getStringList("carDetails");
    if (cardetails != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.SelectDstrict, (route) => false);
    }
  }

  @override
  void initState() {
    _getPrefrences();
    super.initState();
  }

  Map<String, dynamic> _imgUrlIdMap, _imgUrlCarMap;

  UserDataProvider _userDataProvider;

  @override
  void didChangeDependencies() {
    this._userDataProvider = Provider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.only(right: 14, left: 14, top: 14),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('VEHICLE BRAND'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).disabledColor,
                                      ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: brandController,
                          validator: (value) => value.isEmpty
                              ? "Please Enter Vehicle Brand"
                              : null,
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10.0, bottom: 10.0),
                            hintText: "Enter vehicle brand",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('MODEL'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).disabledColor,
                                      ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: modelController,
                          validator: (value) =>
                              value.isEmpty ? "Please Enter Model" : null,
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10.0, bottom: 10.0),
                            hintText: "Enter Your Model",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('LICENSE PLATE'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).disabledColor,
                                      ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: plateController,
                          validator: (value) => value.isEmpty
                              ? "Please Enter Your Plate Number"
                              : null,
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10.0, bottom: 10.0),
                            hintText: "Enter Your Plate Number",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of('COLOR'),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).disabledColor,
                                      ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: colorController,
                          validator: (value) => value.isEmpty
                              ? "Please Enter Your Car Color"
                              : null,
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10.0, bottom: 10.0),
                            hintText: "Enter Your Car Color",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200.0,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              this._imgUrlIdMap =
                                  await selectAndGetImageData(context);
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10.0, right: 10.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.5),
                                image: (this._imgUrlIdMap != null)
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "${this._imgUrlIdMap['original']}"),
                                      )
                                    : null,
                              ),
                              child: (this._imgUrlIdMap == null)
                                  ? Text("صورة البطاقة")
                                  : null,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              this._imgUrlCarMap =
                                  await selectAndGetImageData(context);
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10.0, left: 10.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey.withOpacity(0.5),
                                image: (this._imgUrlCarMap != null)
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "${this._imgUrlCarMap['original']}"),
                                      )
                                    : null,
                              ),
                              child: (this._imgUrlCarMap == null)
                                  ? Text("صورة السيارة")
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
              child: FlatButton(
                child: Text(
                  "Complete",
                  style: describtionStyle.copyWith(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate() &&
                      this._imgUrlIdMap != null &&
                      this._imgUrlCarMap != null) {
                    await insertCarData();
                    await this._sendImages();
                    SharedPreferenceService prefs =
                        new SharedPreferenceService();
                    prefs.setUserData(this._userDataProvider.toMap());
                    this.savedPrefrences();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.SelectDstrict, (route) => false);
                  }
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + 16,
            ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppLocalizations.of('Add a new vehicle'),
            style: headLineStyle.copyWith(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          SizedBox(),
        ],
      ),
    );
  }
}
