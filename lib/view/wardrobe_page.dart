import 'package:bitirme_projesi/controller/db_controller.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:bitirme_projesi/widgets/listTile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WardrobePage extends StatefulWidget {
  @override
  _WardrobePageState createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {

  @override
  Widget build(BuildContext context) {
    getUserMail();
    return Scaffold(
      backgroundColor: lightColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 65.0),
          child: Column(
            children: [
              Listtile("Mont"),
              Listtile("Ceket"),
              Listtile("Tişört"),
              Listtile("Kazak"),
              Listtile("Hırka"),
              Listtile("Pantalon"),
              Listtile("Şort"),
              Listtile("Etek"),
              Listtile("Ayakkabı"),
              Listtile("Bot"),
              Listtile("Çizme"),
            ],
          ),
        ),
      ),
    );
  }
  Future<String> getUserMail() async{
    String userMail = await SharedPreferences.getInstance().then((value) {
      return value.getString('userMail');
    });
    await DbConnection().getCloths(userMail);
    return userMail.toString();
  }
}
