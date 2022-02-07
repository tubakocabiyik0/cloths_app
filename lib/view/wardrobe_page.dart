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

class WardrobePage extends StatefulWidget {
  @override
  _WardrobePageState createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  List<ImagesTable> list;

  @override
  Widget build(BuildContext context) {
    //getData().then((value) => {print(value[1].user_mail.toString())});
    return Scaffold(
      backgroundColor: lightColor,
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
      title: Text(listOfClothesName[listIndex]),
      children: [
        FutureBuilder(
            future: getData(categories[listIndex].toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<ImagesTable>> snapshot) {
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
    AsyncSnapshot<List<ImagesTable>> snapshot,
  ) {
    return GridView.builder(

        shrinkWrap: true,
        itemCount: snapshot.data.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          File image = File(snapshot.data[index].image_url);
          return imageViews(image);
        });
  }
  Container imageViews(File image) {
    return Container(
     height: 200,
     width: 200,
     alignment: Alignment.center,
      child: Image.file(image),

    );
  }

  Future<String> getUserMail() async {
    String userMail = await SharedPreferences.getInstance().then((value) {
      return value.getString('userMail');
    });

    return userMail;
  }

  Future<List<ImagesTable>> getData(String category) async {
    String userMail = await getUserMail();

    return await DbConnection().getCloths(userMail, category);
  }
}
