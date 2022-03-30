import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  Function onPressed;
  String text;
  double width;
  Color colors;
  Color textColor;
  MyButton(this.onPressed, this.text,this.width,{this.colors,this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)), color: colors==null? darkGreen:colors),
      child: MaterialButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(bottom:5.0),
          child: Text(text, style: TextStyle(color: textColor==null ? Colors.white : textColor , fontSize: 27,fontFamily: "Zen")),
        ),
        elevation: 0,
      ),
    );
  }
}
