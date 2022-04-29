import 'dart:io';

import 'package:bitirme_projesi/controller/db_controller.dart';
import 'package:bitirme_projesi/icons_icons.dart';
import 'package:bitirme_projesi/models/images.dart';
import 'package:bitirme_projesi/models/items.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:bitirme_projesi/widgets/listTile.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../viewmodel/settings_viewmodel.dart';
import '../viewmodel/settings_viewmodel.dart';

class WardrobePage extends StatefulWidget {
  @override
  _WardrobePageState createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  List<Images> list;

  @override
  Widget build(BuildContext context) {
    //getData().then((value) => {print(value[1].user_mail.toString())});
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: tile(context),
    );
  }

  tile(BuildContext context) {
    return Container(
      //overscroll removing
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 11,
            itemBuilder: (context, index) {
              return expansionTile(index, context);
            }),
      ),
    );
  }

  Widget expansionTile(int listIndex, BuildContext context) {
    return ExpansionTile(
      trailing: Icon(Icons.keyboard_arrow_down,color: Theme.of(context).dividerColor,),
      title: Text(
        listOfClothesName[listIndex],
        style: TextStyle(fontSize: 19,color: Theme.of(context).dividerColor),
      ),
      children: [
        FutureBuilder(
            future: getData(categories[listIndex].toString()),
            builder:
                (BuildContext context, AsyncSnapshot<List<Images>> snapshot) {
              if (snapshot.hasData == true) {
                if (snapshot.data.length > 0) {
                  return gridView(snapshot);
                } else {
                  return Container(
                    height: 100,
                    width: 100,
                  );
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
      ],
    );
  }

  Widget gridView(
    AsyncSnapshot<List<Images>> snapshot,
  ) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          File image = File(snapshot.data[index].image_url);
          int imageId = snapshot.data[index].id;
          return imageViews(image, imageId);
        });
  }

  Widget imageViews(File image, int id) {
    return
      Card(
        elevation: 1,
        child: Container(
            alignment: Alignment.center,
            child: Image.file(
              image,
              width: 250,
              height: 150,
            ),
          ),
    );
  }

  Future<String> getUserMail() async {
    String userMail = await SharedPreferences.getInstance().then((value) {
      return value.getString('userMail');
    });

    return userMail;
  }

  Future<List<Images>> getData(String category) async {
    SettingsViewModel settingsViewModel = SettingsViewModel();
    String userMail = await getUserMail();
    int id = await settingsViewModel.getCurrentId();
    return await DbConnection().getImages(id, category);
  }


}
