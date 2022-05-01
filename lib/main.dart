import 'package:bitirme_projesi/screens/home_page.dart';

import 'package:bitirme_projesi/screens/signup_page.dart';
import 'package:bitirme_projesi/screens/signın_page.dart';
import 'package:bitirme_projesi/themes/ThemeNotifier.dart';
import 'package:bitirme_projesi/themes/myThemes.dart';
import 'package:bitirme_projesi/viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //MobileAds.instance.initialize();
  SharedPreferences _sharedP = await SharedPreferences.getInstance();
  bool isLogggedIn = _sharedP.getBool("isLoggedIn");
  print(isLogggedIn.toString()+"buradaaa");
  bool darkModeOn;
  SharedPreferences.getInstance().then((value) {
    darkModeOn = value.getBool("switched");
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider<RegisterViewModel>(
          create: (context) => RegisterViewModel()),
      ChangeNotifierProvider<ThemeNotifier>(
        create: (context) =>
            ThemeNotifier(darkModeOn == true ?  darkTheme: lightTheme),
      )
    ], child: MyApp(isLogggedIn)));
  });
}

class MyApp extends StatefulWidget {
  bool _isLoggedIn;
  MyApp(this._isLoggedIn);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      title: 'Authentication',
      home: widget._isLoggedIn == true ? HomePage() : SignInPage()
    );

    /*ChangeNotifierProvider<RegisterViewModel>(create:(context)=>RegisterViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeNotifier.getTheme(),
        title: 'Authentication',
        home: LandingPage(),
      ), );*/
  }
}
