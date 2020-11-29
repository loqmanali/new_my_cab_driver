import 'package:flutter/material.dart';
import 'package:my_cab_driver/controllers/navigators.dart';
import 'package:my_cab_driver/controllers/user_data_provider.dart';
import 'package:provider/provider.dart';

import 'image_view.dart';

class MyDocmanagementScreen extends StatefulWidget {
  @override
  _MyDocmanagementScreenState createState() => _MyDocmanagementScreenState();
}

class _MyDocmanagementScreenState extends State<MyDocmanagementScreen> {
  UserDataProvider _userDataProvider;

  @override
  void didChangeDependencies() {
    this._userDataProvider = Provider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إدارة الوثائق", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: Container(
        color: Colors.white.withOpacity(0.85),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0 ,vertical: 30.0),
          children: [
            this._image(
                imageUrl: "${this._userDataProvider.imgUrlId}",
                context: context,
                title: "صورة البطاقه"),
            SizedBox(
              height: 20.0,
            ),
            this._image(
                imageUrl: "${this._userDataProvider.imgUrlCar}",
                context: context,
                title: "صورة السيارة"),
          ],
        ),
      ),
    );
  }

  Widget _image(
      {@required String imageUrl,
      @required BuildContext context,
      @required String title}) {
    return Container(
      height: 200.0,
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
