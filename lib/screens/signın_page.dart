
import 'package:bitirme_projesi/screens/signup_page.dart';
import 'package:bitirme_projesi/viewmodel/register_viewmodel.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:bitirme_projesi/widgets/button.dart';
import 'package:bitirme_projesi/widgets/textFormField.dart';
import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final mailController = TextEditingController();
  final passController = TextEditingController();
  final _mailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  String result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: signUpBody(context),
    );
  }

  signUpBody(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.055),
              child: Text(
                "Hoşgeldiniz",
                style: TextStyle(
                    fontFamily: "Zen", fontSize: 55, color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 70,
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.06, right: width * 0.06),
          child: Form(
            key: _mailKey,
            child: mailForm(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.06, right: width * 0.06),
          child: Form(key: _passwordKey, child: passwordForm()),
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.56),
          child: TextButton(
              onPressed: () {
                forgetPassword();
              },
              child: Text(
                "Şifreni mi unuttun?",
                style: TextStyle(
                    fontFamily: "Zen", color:Theme.of(context).dividerColor, fontSize: 17),
              )),
        ),
        SizedBox(
          height: 60,
        ),

          MyButton(() {
            signIn(context);
          }, "Giriş Yap", 220,colors: Theme.of(context).primaryColor,textColor: Theme.of(context).cardColor,),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPAge()));
            },
            child: Text(
              "Yeni hesap oluştur",
              style: TextStyle(
                  fontFamily: "Zen", color: Theme.of(context).dividerColor, fontSize: 17),
            )),
      ],
    );
  }

  TextForm mailForm() {
    return TextForm(
      labelText: "mail",
      obscureText: false,
      controller: mailController,
      validator: (value) {
        if (value.isEmpty) {
          return "Burası boş olamaz";
        }
        if (!value.isEmail()) {
          return "Bu email adresi geçerli değil.";
        } else {
          return null;
        }
      },
    );
  }

  passwordForm() {
    return TextForm(
      labelText: "şifre",
      obscureText: true,
      controller: passController,
      validator: (value) {
        if (value.isEmpty) {
          return "Burası boş olamaz";
        }
        if (!value.isPasswordEasy()) {
          return "Şifre 8 karakterden az olamaz.";
        } else {
          return null;
        }
      },
    );
  }

  void signIn(BuildContext context) async {
    if (!_mailKey.currentState.validate() ||
        !_passwordKey.currentState.validate()) {
    } else {
      result = await RegisterViewModel()
          .userLogIn(mailController.text, passController.text);
      if (result == "logged in") {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      } else {
        Fluttertoast.showToast(msg: result);
      }}}
}

void forgetPassword() {}
