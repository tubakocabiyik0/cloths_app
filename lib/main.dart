import 'package:bitirme_projesi/view/signup_page.dart';
import 'package:bitirme_projesi/view/signın_page.dart';
import 'package:bitirme_projesi/view/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cloths App',
      home: SignUpPAge(),

    );
  }
}
