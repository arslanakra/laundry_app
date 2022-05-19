import 'package:flutter/material.dart';
class Card_Widget extends StatelessWidget {
  Card_Widget({this.child,this.color,this.Radius});
  Color? color;
  Widget?child;
  double?Radius;

  @override
  Widget build(BuildContext context) {
    return Container(
        child:Card(
          shape: RoundedRectangleBorder(
            //  side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(Radius!),
          ),
          elevation: 5.0,
          child: child,
          color: color,
        )
    );
  }
}
