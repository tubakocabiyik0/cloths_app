import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class MyAlertDialog extends StatelessWidget {
  Widget widget;

  MyAlertDialog(this.widget);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: lightColor,
        width: 450,
        height: 470,
        child: widget,
      ),
    );
  }
}