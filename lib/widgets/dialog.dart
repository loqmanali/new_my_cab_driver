import 'package:my_cab_driver/models/notification_model.dart';
import 'package:my_cab_driver/views/current_trip_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showNotificationAlert(BuildContext context, NotificationModel model) {
  print("context : $context");
  Alert(
    context: context,
    type: AlertType.warning,
    title: "لديك رحلة مقترحة",
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _nodeText(title: "الإسم", subtitle: "${model.name}"),
        _nodeText(
            title: "فى منطقة الهرم",
            subtitle: "${model.inHaram ? "نعم" : "لا"}"),
        _nodeText(title: "من", subtitle: "${model.startAddress}"),
        _nodeText(title: "إلى", subtitle: "${model.endAddress}"),
        _nodeText(title: "التكلفة", subtitle: "${model.cost}"),
      ],
    ),
    buttons: [
      DialogButton(
        child: Text(
          "رفض",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () async {
          final String url =
              "https://gardentaxi.net/Back_End/public/api/tripe/${model.tripId}/${model.cacheId}";
          print("url : $url");
          http.Response response = await http.get(url);

          print("status : ${response.statusCode}");
          print("body : ${response.body}");
          Navigator.pop(context);
        },
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "قبول",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () async {
          final String url =
              "https://gardentaxi.net/Back_End/public/api/tripe/approve/${model.tripId}/${model.driverId}";
          print("url : $url");
          http.Response response = await http.get(url);
          print("accept status : ${response.statusCode}");
          print("accept  body : ${response.body}");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      CurrentTripView(driverId: model.driverId)));
        },
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();
}

Widget _nodeText({@required String title, @required String subtitle}) {
  return Container(
    alignment: Alignment.centerRight,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("$subtitle : "),
        Text("$title", style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
