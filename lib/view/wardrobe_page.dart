import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:bitirme_projesi/widgets/listTile.dart';
import 'package:flutter/material.dart';

class WardrobePage extends StatefulWidget {
  @override
  _WardrobePageState createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  @override
  Widget build(BuildContext context) {
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
}
