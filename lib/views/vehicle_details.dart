import 'package:flutter/material.dart';
import 'package:my_cab_driver/controllers/navigators.dart';
import 'package:my_cab_driver/controllers/user_data_provider.dart';
import 'package:my_cab_driver/views/image_view.dart';
import 'package:provider/provider.dart';

class VehicleDetails extends StatefulWidget {
  @override
  _VehicleDetailsState createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  UserDataProvider _userDataProvider;

  @override
  void didChangeDependencies() {
    this._userDataProvider = Provider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("بيانات السيارة", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white.withOpacity(0.92),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          children: [
            SizedBox(height: 20.0),
            this._text("ماركة السيارة"),
            this._fieldNode("${this._userDataProvider.brand}"),
            this._text("نموذج"),
            this._fieldNode("${this._userDataProvider.type}"),
            this._text("لوحة الترخيص"),
            this._fieldNode("${this._userDataProvider.number}"),
            this._text("اللون"),
            this._fieldNode("${this._userDataProvider.color}"),
            Container(
              height: 150.0,
              child: Row(
                children: [
                  this._image(
                    context: context,
                    title: "صورة البطاقة",
                    imageUrl: "${this._userDataProvider.imgUrlId}",
                  ),
                  SizedBox(width: 10.0),
                  this._image(
                    context: context,
                    title: "صورة السيارة",
                    imageUrl: "${this._userDataProvider.imgUrlCar}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(String title) {
    return Text(
      "$title",
      style: TextStyle(color: Colors.black54),
    );
  }

  Widget _fieldNode(String content) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text("$content"),
    );
  }

  Widget _image(
      {@required String imageUrl,
      @required BuildContext context,
      @required String title}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => pushNavigator(
            context, ImageView(NetworkImage(imageUrl), tag: "image_$title")),
        child: Stack(
          children: [
            Hero(
              tag: "image_$title",
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("$imageUrl"),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Text("$title"),
            ),
          ],
        ),
      ),
    );
  }
}
