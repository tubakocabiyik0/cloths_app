import 'package:bitirme_projesi/service/api_service.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:flutter/material.dart';

class WeatherPages extends StatefulWidget {
  @override
  _WeatherPagesState createState() => _WeatherPagesState();
}

class _WeatherPagesState extends State<WeatherPages> {
  @override
  Widget build(BuildContext context) {
    ApiService().getWeather("istanbul");
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: champagnePink,

        ),
      ),
    );
  }
}
