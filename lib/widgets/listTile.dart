import 'package:bitirme_projesi/models/items.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Listtile extends StatelessWidget {
  String title;
  Function onTap;
  Icon leading_icon;
  Widget trailing;

  Listtile({this.title, this.onTap, this.trailing, this.leading_icon});

  @override
  Widget build(BuildContext context) {
    return tile(context);

  }

  tile(BuildContext context) {
    return ListTile(
      onTap: (){
        onTap();
      },
      leading: Container(
        height: 50,
        width: 40,
        child: leading_icon,
      ),
      title: Text(title,style: TextStyle(fontSize: 19,color: Theme.of(context).dividerColor)),
      trailing:trailing ,

    );
  }
}
