import 'package:flutter/material.dart';

import 'colors.dart';

class WeatherCards extends StatelessWidget {
  String degree;
  String day;
  String description;

  WeatherCards(this.degree, this.day,this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      height: 550,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        border: Border.all(width: 1,color:borderColor),
        color: pagerBackground,
      ),
      child: Row(
        children: [
          Image.asset(
            "asset/images/cloud.png",
            width: 150,
            height: 120,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    right: MediaQuery.of(context).size.height * 0.01),
                child: Text(
                  day,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(degree + " C",
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 5,
              ),
              Text(description,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
            ],
          ),
        ],
      ),
    );
  }
}
