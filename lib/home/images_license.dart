// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:my_cab_driver/constance/constance.dart';
// import 'package:my_cab_driver/main.dart';

// class LicenceImage extends StatefulWidget {
//   @override
//   _LicenceImageState createState() => _LicenceImageState();
// }

// class _LicenceImageState extends State<LicenceImage> {
//   final scaffoldkey = GlobalKey<ScaffoldState>();
//   File image;
//   final picker = ImagePicker();

//   bool selectLicense = false;
//   bool selectId = false;

//   void _imageGalleryLicense() async {
//     var picture = await picker.getImage(source: ImageSource.gallery);
//     if (picture != null) {
//       print("Done");
//       setState(() {
//         image = File(picture.path);
//         selectLicense = true;
//       });
//     } else {
//       print("no Image Selected");
//     }
//   }

//   void _imageCameraLicense() async {
//     var picture = await picker.getImage(source: ImageSource.camera);
//     if (picture != null) {
//       print("Done");
//       setState(() {
//         image = File(picture.path);
//         selectLicense = true;
//       });
//       print("ias ssss : $image");
//     } else {
//       print("No camera Image Selcted");
//     }
//   }

//   void _imageGalleryId() async {
//     var picture = await picker.getImage(source: ImageSource.gallery);
//     if (picture != null) {
//       print("Done");
//       setState(() {
//         image = File(picture.path);
//         selectId = true;
//       });
//     } else {
//       print("no Image Selected");
//     }
//   }

//   void _imageCameraId() async {
//     var picture = await picker.getImage(source: ImageSource.camera);
//     if (picture != null) {
//       print("Done");
//       setState(() {
//         image = File(picture.path);
//         selectId = true;
//       });
//     } else {
//       print("No camera Image Selcted");
//     }
//   }

//   // void _getPrefrences() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   var loginToken = prefs.getStringList("driverLoginToken");
//   //   var registerToken = prefs.getStringList("driverRegisterToken");
//   //   if (loginToken != null || registerToken != null) {
//   //     Navigator.pushNamedAndRemoveUntil(
//   //         context, Routes.SelectDstrict, (route) => false);
//   //   }
//   // }

//   // @override
//   // void initState() {
//   //   _getPrefrences();
//   //   super.initState();
//   // }

//   void licenseDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(
//           "اختيار مكان الصورة",
//           textAlign: TextAlign.center,
//           style: headLineStyle.copyWith(fontSize: 20.0),
//         ),
//         content: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 _imageCameraLicense();
//                 Navigator.pop(context);
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.photo_camera,
//                     size: 50.0,
//                     color: Colors.green,
//                   ),
//                   SizedBox(height: 10.0),
//                   Text(
//                     "الكاميرا",
//                     style: describtionStyle.copyWith(fontSize: 20.0),
//                     textAlign: TextAlign.center,
//                   )
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 _imageGalleryLicense();
//                 Navigator.pop(context);
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.photo_library,
//                     size: 50.0,
//                     color: Colors.green,
//                   ),
//                   SizedBox(height: 10.0),
//                   Text(
//                     "الأستوديو",
//                     style: describtionStyle.copyWith(fontSize: 20.0),
//                     textAlign: TextAlign.center,
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void idDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(
//           "اختيار مكان الصورة",
//           textAlign: TextAlign.center,
//           style: headLineStyle.copyWith(fontSize: 20.0),
//         ),
//         content: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 _imageCameraId();
//                 Navigator.pop(context);
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.photo_camera,
//                     size: 50.0,
//                     color: Colors.green,
//                   ),
//                   SizedBox(height: 10.0),
//                   Text(
//                     "الكاميرا",
//                     style: describtionStyle.copyWith(fontSize: 20.0),
//                     textAlign: TextAlign.center,
//                   )
//                 ],
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 _imageGalleryId();
//                 Navigator.pop(context);
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.photo_library,
//                     size: 50.0,
//                     color: Colors.green,
//                   ),
//                   SizedBox(height: 10.0),
//                   Text(
//                     "الأستوديو",
//                     style: describtionStyle.copyWith(fontSize: 20.0),
//                     textAlign: TextAlign.center,
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldkey,
//       backgroundColor: Theme.of(context).backgroundColor,
//       body: Padding(
//         padding: EdgeInsets.only(right: 14, left: 14, top: 14),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Text(
//                   "صور البطاقة الشخصية ورخصة القيادة",
//                   style: headLineStyle,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             GestureDetector(
//               onTap: () {
//                 licenseDialog();
//               },
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.0),
//                         color: Colors.grey,
//                       ),
//                       child: Text(
//                         "رخصة القيادة",
//                         style: headLineStyle.copyWith(color: Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             GestureDetector(
//               onTap: () {
//                 idDialog();
//               },
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.0),
//                         color: Colors.grey,
//                       ),
//                       child: Text(
//                         "البطاقة الشخصية",
//                         style: headLineStyle.copyWith(color: Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             Container(
//               height: 40,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Theme.of(context).primaryColor,
//               ),
//               child: FlatButton(
//                 child: Text(
//                   "Complete",
//                   style: describtionStyle.copyWith(
//                     color: Colors.white,
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onPressed: () {
//                   if (selectLicense && selectId) {
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, Routes.SelectDstrict, (route) => false);
//                   } else {
//                     final snackBar = SnackBar(
//                       content: Text(
//                         "يرجي اختيار البطاقتين",
//                         style: headLineStyle.copyWith(fontSize: 20.0),
//                       ),
//                     );
//                     scaffoldkey.currentState.showSnackBar(snackBar);
//                   }
//                 },
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).padding.bottom + 16,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
