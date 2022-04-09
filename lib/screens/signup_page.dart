import 'package:bitirme_projesi/viewmodel/register_viewmodel.dart';
import 'package:bitirme_projesi/widgets/button.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:bitirme_projesi/widgets/textFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';

import 'home_page.dart';

class SignUpPAge extends StatefulWidget {
  @override
  _SignUpPAgeState createState() => _SignUpPAgeState();
}

class _SignUpPAgeState extends State<SignUpPAge> {
  var _nameController = TextEditingController();
  var _mailController = TextEditingController();
  var _passwordController = TextEditingController();
  final _mailKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormState>();
  String dropdownValue = 'İstanbul';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightColor,
      body: signUpBody(),
    );
  }

  signUpBody() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.15),
          child: Text(
            "Create Account",
            style: TextStyle(fontFamily: "Zen", color: darkBlue, fontSize: 50),
          ),
        ),
        SizedBox(
          height: 70,
        ),
        nameForm(width),
        SizedBox(
          height: 20,
        ),
        mailForm(width, height),
        SizedBox(
          height: 20,
        ),
        passwordForm(width),
        SizedBox(
          height: 30,
        ),
        buildDropdownButton(),
        SizedBox(
          height: 60,
        ),
        MyButton(() {
          signUp();
        }, "Sign-up", 220),
      ],
    );
  }

  nameForm(double width) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.06, right: width * 0.06),
      child: Form(
        key: _nameKey,
        child: TextForm(
          labelText: "name",
          obscureText: false,
          controller: _nameController,
          validator: (v) {
            if (v.isEmpty) {
              return "cant be empty";
            }
            if (!v.isUsername()) {
              return "name can't be less 3 character";
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  mailForm(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.06, right: width * 0.06),
      child: Form(
        key: _mailKey,
        child: TextForm(
          labelText: "mail",
          obscureText: false,
          controller: _mailController,
          validator: (value) {
            if (value.isEmpty) {
              return "mail can't be empty";
            }
            if (!value.isEmail()) {
              return "please change email";
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Container buildDropdownButton() {
    return Container(
      width: 341,
      child: DropdownButton(
        style: TextStyle(fontFamily: "Zen", color: Colors.black, fontSize: 20),
        icon: Icon(
          Icons.arrow_drop_down_sharp,
          color: darkBlue,
        ),
        dropdownColor: lightColor,
        value: dropdownValue,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: ['İstanbul', "İzmir", "Bursa", "Bolu", "Adana", "Ankara"]
            .map((value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
      ),
    );
  }

  passwordForm(double width) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.06, right: width * 0.06),
      child: Form(
        key: _passKey,
        child: TextForm(
          labelText: "password",
          obscureText: true,
          controller: _passwordController,
          validator: (value) {
            if (value.isEmpty) {
              return "can't be empty";
            }
            if (!value.isPasswordEasy()) {
              return "Password can't be less 8 character";
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  void signUp() {
    if (!_nameKey.currentState.validate() ||
        !_mailKey.currentState.validate() ||
        !_passKey.currentState.validate()) {
    } else {
      RegisterViewModel()
          .userRegister(_mailController.text, _passwordController.text,
              _nameController.text, dropdownValue)
          .then((value) {
        if (value == false) {

        } else if (value == true) {
          print("basarili");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }
      });
    }
  }
}
