import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  Function onPressed;
  String text;

  MyButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)), color: darkGreen),
      child: MaterialButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(bottom:5.0),
          child: Text(text, style: TextStyle(color: Colors.white, fontSize: 27,fontFamily: "Zen")),
        ),
        elevation: 0,
      ),
    );
  }
}
