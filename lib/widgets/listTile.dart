import 'package:bitirme_projesi/models/items.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Listtile extends StatelessWidget {
  String title;
  Function onTap;

  Listtile(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, right: 8, left: 8),
      child: tile(context),
    );
  }

  tile(BuildContext context) {
    return Container(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
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
      ),
    );
  }

  ExpansionTile expansionTile(int index, BuildContext context) {
    return ExpansionTile(
      title: Text(listOfClothesName[index].toString()),
      children: [
        Container(
          height: 400,
          width: 400,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context,index){
            return Text("s");
          }),
        ),
      ],
    );
  }
}
