import 'package:bitirme_projesi/view/wardrobe_page.dart';
import 'package:bitirme_projesi/widgets/button.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:bitirme_projesi/widgets/listTile.dart';
import 'package:bitirme_projesi/widgets/textFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String userMail;

  // ignore: non_constant_identifier_names
  String user_location;

  // ignore: non_constant_identifier_names
  String user_name;
  final mailController = TextEditingController();
  final locationController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfos();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: lightColor,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.15),
        child: listTiles(width, height),
      ),
    );
  }

  listTiles(double width, double height) {
    return Column(
      children: [
        Listtile(
          title: "Gece Modu",
          trailing: CupertinoSwitch(
            value: false,
            trackColor: light,
          ),
          leading_icon: Icon(Icons.wb_sunny_outlined),
        ),
        SizedBox(
          height: 20,
        ),
        Listtile(
          onTap: () => alertDialog(width, height),
          title: "Hesap Bilgileri",
          trailing: Icon(Icons.navigate_next),
          leading_icon: Icon(Icons.person_outline_outlined),
        ),
        SizedBox(
          height: 20,
        ),
        Listtile(
          title: "Bilgi",
          trailing: Icon(Icons.navigate_next),
          leading_icon: Icon(Icons.bookmarks_outlined),
        )
      ],
    );
  }

  Widget infoDialog() {
    return Dialog(
      child: Container(
        color: lightColor,
        height: 400,
        width: 200,
      ),
    );
  }

  void alertDialog(double width, double height) {
    var alert = Dialog(
      child: Container(
        color: lightColor,
        width: 280,
        height: 470,
        child: column(width, height),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  column(double width, double height) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: width * 0.27, top: height * 0.05),
          child: Text(
            "Bilgileri Güncelle",
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(right: width * 0.08, left: width * 0.03),
          child: TextForm(
            onChange: (value) {
              setState(() {
                user_name = value;
              });
            },
            // controller: nameController,
            initialValue: user_name != null ? user_name : "",
            obscureText: false,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.only(right: width * 0.08, left: width * 0.03),
          child: TextForm(
            onChange: (value) {
              setState(() {
                userMail = value;
              });
            },
            initialValue: userMail != null ? userMail : "",
            obscureText: false,
            // controller: mailController,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.only(right: width * 0.08, left: width * 0.03),
          child: TextForm(
              onChange: (value) {
                setState(() {
                  user_location = value;
                });
              },
              // controller: locationController,
              obscureText: false,
              initialValue: user_location != null ? user_location : ""),
        ),
        SizedBox(
          height: 30,
        ),
        updateButton(),
        SizedBox(
          height: 30,
        ),
        exitButton(),
      ],
    );
  }

  updateButton() {
    return MyButton(
      onPressed: () {
        saveAll();
      },
      text: "Güncelle",
    );
  }

  exitButton() {
    return MyButton(
      onPressed: () {
        Navigator.pop(context);
      },
      text: "Vazgeç",
    );
  }

  void getUserInfos() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userMail = sharedPreferences.getString("userMail");
      user_location = sharedPreferences.getString("user_location");
      user_name = sharedPreferences.getString("user_name");
    });
  }

  void saveAll() {}
}
