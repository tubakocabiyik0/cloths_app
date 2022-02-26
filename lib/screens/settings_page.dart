
import 'package:bitirme_projesi/screens/wardrobe_page.dart';
import 'package:bitirme_projesi/viewmodel/settings_viewmodel.dart';
import 'package:bitirme_projesi/widgets/button.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:bitirme_projesi/widgets/listTile.dart';
import 'package:bitirme_projesi/widgets/textFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String userMail;
  String userLocation;
  String userName;
  String oldMail;
  bool saved;
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
                userName = value;
              });
            },
            // controller: nameController,
            initialValue: userName != null ? userName : "",
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
                  userLocation = value;
                });
              },
              // controller: locationController,
              obscureText: false,
              initialValue: userLocation != null ? userLocation : ""),
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
      oldMail=sharedPreferences.getString("userMail");
      userMail = sharedPreferences.getString("userMail");
      userLocation = sharedPreferences.getString("user_location");
      userName = sharedPreferences.getString("user_name");
    });
  }

  void saveAll() async {
   
   saved = await SettingsViewModel().updateUser(oldMail: oldMail,mail: userMail,name: userName,location: userLocation);
   if(saved=true){
     Fluttertoast.showToast(msg: "Güncellendi");
   }else{
     Fluttertoast.showToast(msg: "Güncelleme Yapılamadı");
   }
   
  }
}