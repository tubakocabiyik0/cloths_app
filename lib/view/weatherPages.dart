import 'package:bitirme_projesi/models/weather.dart';
import 'package:bitirme_projesi/service/api_service.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:bitirme_projesi/widgets/weatherCards.dart';
import 'package:bitirme_projesi/widgets/weatherPageViews.dart';
import 'package:flutter/material.dart';

class WeatherPages extends StatefulWidget {
  @override
  _WeatherPagesState createState() => _WeatherPagesState();
}

class _WeatherPagesState extends State<WeatherPages> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ApiService().getWeather("istanbul");
    return Scaffold(
      body: WeatherPageWidgets(0),
    );
  }


  }

class WeatherPagesTwo extends StatefulWidget {
  @override
  _WeatherPagesTwo createState() => _WeatherPagesTwo();
}

class _WeatherPagesTwo extends State<WeatherPagesTwo> {
  Future<WeatherResponse> fetchData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeatherPageWidgets(1),
    );
  }
  }



class WeatherPagesThree extends StatefulWidget {
  @override
  _WeatherPagesThree createState() => _WeatherPagesThree();
}

class _WeatherPagesThree extends State<WeatherPagesThree> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeatherPageWidgets(2),
    );
  }}