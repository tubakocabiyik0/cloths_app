import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String labelText;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final TextEditingController controller;
  final Function validationFunc;

  TextForm({
    this.labelText,
    this.obscureText,
    this.controller,
    this.validationFunc,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(
          contentPadding:
              new EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black38,fontFamily: "Zen",fontSize: 20),
        ),
        validator: validator,
        obscureText: obscureText,
        controller: controller);
  }
}
