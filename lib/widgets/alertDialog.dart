import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class MyAlertDialog extends StatelessWidget {
  Widget widget;
  double width;
  double height;

  MyAlertDialog(this.widget,{this.width,this.height});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding:EdgeInsets.all(9),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(9)),color: lightColor,),

          width: width== null ?450:width,
          height: height==null?470:height,
          child: widget,
        ),
      ),
    );
  }
}