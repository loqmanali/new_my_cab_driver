import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Animator(
            tween: Tween(
              begin: Offset(0, 0.3),
              end: Offset(0, 0),
            ),
            cycles: 1,
            duration: Duration(seconds: 1),
            builder: (anim) {
              return SlideTransition(
                position: anim,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text("data"),
                ),
              );
            }),
      ),
    );
  }
}
