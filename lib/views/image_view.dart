import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  final ImageProvider _image;
  final String tag ;

  ImageView(this._image , {this.tag = "image"});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Hero(
        tag: "$tag",
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.white),
          imageProvider: this._image,
        ),
      ),
    );
  }
}
