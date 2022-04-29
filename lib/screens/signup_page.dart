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
      backgroundColor: Theme.of(context).backgroundColor,
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
            "Hesap Oluştur",
            style: TextStyle(fontFamily: "Zen", color: Theme.of(context).primaryColor, fontSize: 50),
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
        }, "Kaydol", 220,colors: Theme.of(context).canvasColor,textColor: Theme.of(context).cardColor,),
      ],
    );
  }

  nameForm(double width) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.06, right: width * 0.06),
      child: Form(
        key: _nameKey,
        child: TextForm(
          labelText: "isim",
          obscureText: false,
          controller: _nameController,
          validator: (v) {
            if (v.isEmpty) {
              return "Burası boş olamaz!";
            }
            if (!v.isUsername()) {
              return "isim 3 karakterden az olamaz!";
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
              return "Burası boş olamaz";
            }
            if (!value.isEmail()) {
              return "Bu email geçerli değil";
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
      child: Padding(
        padding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01),
        child: DropdownButton(

          style:
              TextStyle(fontFamily: "Zen", color: Colors.black, fontSize: 20),
          icon:Icon(
              Icons.arrow_drop_down_sharp,
              color: Theme.of(context).primaryColor,
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
            return DropdownMenuItem(value: value, child: Padding(
              padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.04),
              child: Text(value,style: TextStyle(color:Theme.of(context).splashColor,fontSize: 20),),
            ));
          }).toList(),
        ),
      ),
    );
  }

  passwordForm(double width) {
    return Padding(
      padding: EdgeInsets.only(left: width * 0.06, right: width * 0.06),
      child: Form(
        key: _passKey,
        child: TextForm(
          labelText: "şifre",
          obscureText: true,
          controller: _passwordController,
          validator: (value) {
            if (value.isEmpty) {
              return "Burası boş olamaz";
            }
            if (!value.isPasswordEasy()) {
              return "Şifre 8 karakterden az olamaz";
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
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      });
    }
  }
}
