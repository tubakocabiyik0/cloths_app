import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final String labelText;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final TextEditingController controller;
  final Function validationFunc;
  final String initialValue;
  final Function onChange;

  TextForm({
    this.labelText,
    this.obscureText,
    this.controller,
    this.validationFunc,
    this.validator,
    this.initialValue,
    this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      initialValue: initialValue,
        style: TextStyle(color:Theme.of(context).dividerColor),
        decoration: InputDecoration(
          contentPadding:
              new EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color:Theme.of(context).canvasColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color:Theme.of(context).canvasColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color:Theme.of(context).canvasColor),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Theme.of(context).splashColor,fontFamily: "Zen",fontSize: 20),
        ),
        validator: validator,
        obscureText: obscureText,
        controller: controller);
  }
}
