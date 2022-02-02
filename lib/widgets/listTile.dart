import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

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
    return ExpansionTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_drop_down),
        children: [
          SingleChildScrollView(
            child: Container(
              height: 300,
              width: 300,
            ),
          ),
        ],

    );
  }
}
