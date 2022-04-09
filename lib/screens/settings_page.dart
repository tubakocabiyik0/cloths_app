import 'package:bitirme_projesi/screens/sign%C4%B1n_page.dart';
import 'package:bitirme_projesi/screens/wardrobe_page.dart';
import 'package:bitirme_projesi/viewmodel/register_viewmodel.dart';
import 'package:bitirme_projesi/viewmodel/settings_viewmodel.dart';
import 'package:bitirme_projesi/widgets/alertDialog.dart';
import 'package:bitirme_projesi/widgets/button.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:bitirme_projesi/widgets/listTile.dart';
import 'package:bitirme_projesi/widgets/textFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
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
  String password;
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
    final registerViewModel = Provider.of<RegisterViewModel>(context);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: lightColor,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.15),
        child: listTiles(width, height, registerViewModel),
      ),
    );
  }

  listTiles(double width, double height, RegisterViewModel userViewModel) {
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
          onTap: () => passwordAlert(width, height),
          title: "Şifre",
          trailing: Icon(
            Icons.navigate_next,
          ),
          leading_icon: Icon(
            Icons.vpn_key_outlined,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Listtile(
          title: "Bilgi",
          trailing: Icon(Icons.navigate_next),
          leading_icon: Icon(Icons.bookmarks_outlined),
        ),
        SizedBox(
          height: 20,
        ),
        Listtile(
          onTap: () => signOut(userViewModel),
          title: "Çıkış Yap",
          leading_icon: Icon(Icons.logout),
        ),
        SizedBox(
          height: 20,
        ),
        Listtile(
          onTap: () => deleteAccountDialog(userViewModel),
          title: "Hesabı Sil",
          leading_icon: Icon(Icons.delete_outline),
        ),
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
    //dialog
    var alert = MyAlertDialog(
      Container(
        color: lightColor,
        width: 280,
        height: 470,
        child:infoUpdateDialog(width, height),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  infoUpdateDialog(double width, double height) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.55),
          child: IconButton(icon: Icon(Icons.clear_outlined), onPressed: (){
            exit();
          }),
        ),
        Padding(
          padding: EdgeInsets.only(right: width * 0.27, top: height * 0.01),
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
      ],
    );
  }

  updateButton() {
    return Padding(
      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),
      child: MyButton(() {
        saveAll();
      }, "Güncelle", 260),
    );
  }

  exit() {
    Navigator.pop(context);
  }

  void getUserInfos() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      oldMail = sharedPreferences.getString("userMail");
      userMail = sharedPreferences.getString("userMail");
      userLocation = sharedPreferences.getString("user_location");
      userName = sharedPreferences.getString("user_name");
    });
  }

  void saveAll() async {
    saved = await SettingsViewModel().updateUser(
        oldMail: oldMail,
        mail: userMail,
        name: userName,
        location: userLocation);
    if (saved = true) {
      Fluttertoast.showToast(msg: "Güncellendi");
    } else {
      Fluttertoast.showToast(msg: "Güncelleme Yapılamadı");
    }
  }

  passwordAlert(double width, double height) {
    var alert = MyAlertDialog(passwordBody(width, height));
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget passwordBody(double width, double height) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.55),
          child: IconButton(icon: Icon(Icons.clear_outlined), onPressed: (){
            exit();
          }),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: height * 0.08, right: width * 0.08, left: width * 0.03),
          child: TextForm(
            labelText: "Yeni şifrenizi yazınız",
            obscureText: false,
            onChange: (newValue) {
              setState(() {
                password = newValue.toString();
              });
            },
          ),
        ),
        SizedBox(
          height: 90,
        ),
        MyButton(() {
          updatePassword(password, oldMail);
        }, "Kaydet", 260),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  void updatePassword(String password, String oldMail) async {
    saved = await SettingsViewModel()
        .updatePassword(oldMail: oldMail, password: password);
    Navigator.pop(context);
    saved == true
        ? Fluttertoast.showToast(msg: "Şifreniz Güncellendi")
        : Fluttertoast.showToast(msg: "Şifre güncellemesi başarısız");
  }

  signOut(RegisterViewModel registerViewModel) async {
    bool result = await registerViewModel.userLogOut();
    if (result == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    }
  }

  deleteAccountDialog(RegisterViewModel registerViewModel) {
    var alert = MyAlertDialog(
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
                left: MediaQuery.of(context).size.width * 0.02),
            child: Text(
                "Hesabınız kalıcı olarak silinecek. Silmek istediğinize emin misiniz?",
                style: TextStyle(fontSize: 20)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Vazgeç",
                    style: TextStyle(color: Colors.black, fontSize: 21),
                  )),
              TextButton(
                  onPressed: () {
                    deleteAccount(registerViewModel);
                  },
                  child: Text("Evet",
                      style: TextStyle(color: Colors.black, fontSize: 21))),
            ],
          ),
        ],
      ),
      width: 500,
      height: 180,
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void deleteAccount(RegisterViewModel registerViewModel) async {
    int id = await SettingsViewModel().getCurrentId();
    bool result = await registerViewModel.deleteAccount(id);
    print(result);
    signOut(registerViewModel);
  }
}
