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
          borderRadius: BorderRadius.all(Radius.circular(9)), color: colors==null? Theme.of(context).buttonColor:colors),
      child: MaterialButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(bottom:5.0),
          child: Text(text, style: TextStyle(color: textColor==null ? Colors.white : textColor , fontSize: 19)),
        ),
        elevation: 0,
      ),
    );
  }
}
