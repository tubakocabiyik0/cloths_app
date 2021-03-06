import 'dart:io';
import 'package:bitirme_projesi/models/items.dart';
import 'package:bitirme_projesi/screens/home_page.dart';
import 'package:bitirme_projesi/viewmodel/images_viewmodel.dart';
import 'package:bitirme_projesi/widgets/button.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewmodel/settings_viewmodel.dart';
import '../viewmodel/settings_viewmodel.dart';

class PhotoAddPage extends StatefulWidget {
  @override
  _PhotoAddPageState createState() => _PhotoAddPageState();
}

class _PhotoAddPageState extends State<PhotoAddPage> {
  ImagePicker _imagePicker = ImagePicker();
  File currentImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              currentImage != null ? photoProperties() : galleryButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget galleryButton() {
    return Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.16,
        ),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(20),
          color: Theme.of(context).splashColor,
          padding: EdgeInsets.all(20),
          dashPattern: [10, 5],
          strokeWidth: 1,
          child: Container(
            child: GestureDetector(
                onTap: () {
                  takePhoto();
                },
                child: Image.asset(
                  "asset/images/add.png",
                  color: Theme.of(context).splashColor,
                )),
            width: 140,
            height: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
              Radius.circular(25),
            )),
          ),
        ));
  }

  void takePhoto() {
    showAnimatedDialog(
        context: context,
        // ignore: missing_return
        barrierDismissible: true,
        animationType: DialogTransitionType.fadeScale,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: lightColor,
            title: const Text("Birini Se??in"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  goGallery();
                  Navigator.pop(context);
                },
                child: Text("Galeri"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  goCamera();
                  Navigator.pop(context);
                },
                child: Text("Kamera"),
              )
            ],
          );
        });
  }

  void goGallery() async {
    PickedFile image = (await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50));
    File fileFormat = File(image.path);
    if (image != null) {
      setState(() {
        currentImage = fileFormat;
      });
    }
  }

  Widget saveAllButton() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: MyButton(() {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        saveImagesToDatabase();
      }, "Kaydet", 220),
    );
  }

  Widget exitButton() {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: MyButton(() {
        setState(() {
          currentImage = null;
        });
      }, "Vazge??", 220),
    );
  }

  goCamera() async {
    PickedFile image = (await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50));
    File fileFormat = File(image.path);
    if (image != null) {
      setState(() {
        currentImage = fileFormat;
      });
    }
  }

  Future<bool> saveImagesToDatabase() async {
    String userMail = await SharedPreferences.getInstance().then((value) {
      return value.getString('userMail');
    });
    SettingsViewModel _settingsViewModel = SettingsViewModel();
    int user_id = await _settingsViewModel.getCurrentId();
    bool saved = await ImagesViewModel()
        .imageSave(currentImage.path.toString(),user_id,userMail,selectedCategory,selectedSeason,selectedColor);
    return saved != true
        ? Fluttertoast.showToast(msg: "Resim kaydedilmedi")
        : Fluttertoast.showToast(msg: "Resim kaydedildi");
  }

  String selectedCategory = categories[0].toString();

  category() {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: DropdownButton(
          dropdownColor: lightColor,
          value: selectedCategory,
          items: categories.map((String items) {
            return DropdownMenuItem(
                value: items, child: Text(items, style: TextStyle(fontSize: 20)));
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
            });
          }),
    );
  }

  String selectedSeason = seasons[1].toString();

  season() {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: DropdownButton(
          dropdownColor: lightColor,
          value: selectedSeason,
          items: seasons.map((String items) {
            return DropdownMenuItem(
                value: items,
                child: Text(items, style: TextStyle(fontSize: 20)));
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedSeason = value;
            });
          }),
    );
  }

  String selectedColor = colors[1].toString();

  color() {
    return Padding(
      padding: const EdgeInsets.only(left:15),
      child: DropdownButton(
          value: selectedColor,
          dropdownColor: lightColor,
          items: colors.map((e) {
            return DropdownMenuItem(
                value: e, child: Text(e, style: TextStyle(fontSize: 20)));
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedColor = value;
            });
          }),
    );
  }

  photoProperties() {
    return Padding(
      padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.10),
      child: Dialog(
          elevation: 5,
          child: SingleChildScrollView(
            child: Container(
              color: lightColor,
              height: 560,
              width: 250,
              child: Column(
                children: [
                  Container(
                      height: 250, width: 300, child: Image.file(currentImage)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Text(
                          "Kategori : ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      category(),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:23),
                        child: Text(
                          "Mevsim : ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      season(),
                    ],
                  ),
                  Row(

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 50.0, left: 23),
                        child: Text(
                          "Renk : ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      color(),
                    ],
                  ),
                  saveAllButton(),
                  exitButton(),
                ],
              ),
            ),
          )),
    );
  }
}
