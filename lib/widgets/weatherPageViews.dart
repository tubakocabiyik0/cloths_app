import 'package:bitirme_projesi/controller/db_controller.dart';
import 'package:bitirme_projesi/models/weather.dart';
import 'package:bitirme_projesi/models/weatherC.dart';
import 'package:bitirme_projesi/service/api_service.dart';
import 'package:bitirme_projesi/widgets/weatherCards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';

class WeatherPageWidgets extends StatefulWidget {
  int index;

  WeatherPageWidgets(this.index);

  @override
  _WeatherPagesWidget createState() => _WeatherPagesWidget();
}

class _WeatherPagesWidget extends State<WeatherPageWidgets> {
  Future<WeatherResponse> fetchData;
  String location;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  getLocation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        location = sharedPreferences.getString('user_location').toString();
      });
    }
    print("location" + location);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      fetchData = ApiService().getWeather(location);
    });
    //getLocation();
    //print("burası"+location);
    //fetchData = ApiService().getWeather(location);

    return Scaffold(
      body: buildFutureBuilder(),
    );
  }

  FutureBuilder<WeatherResponse> buildFutureBuilder() {
    return FutureBuilder(
      future: fetchData,
      builder: (BuildContext context, AsyncSnapshot<WeatherResponse> snapshot) {
        if (snapshot.hasData) {
          print("data" + snapshot.data.result[widget.index].day);
          return (WeatherCards(
              snapshot.data.result[widget.index].degree,
              snapshot.data.result[widget.index].day,
              snapshot.data.result[widget.index].description));
        } else {
          return Container(
              width: 550,
              height: 550,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: champagnePink,
              ),
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(darkGreen)),
              ));
        }
      },
    );
  }
}
