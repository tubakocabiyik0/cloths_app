import 'package:bitirme_projesi/view/landing_page.dart';
import 'package:bitirme_projesi/view/signup_page.dart';
import 'package:bitirme_projesi/view/signın_page.dart';
import 'package:bitirme_projesi/viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider<RegisterViewModel>(create:(context)=>RegisterViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Authentication',
        home: LandingPage(),
      ), );
  }
}
