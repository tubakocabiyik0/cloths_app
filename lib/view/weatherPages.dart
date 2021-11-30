import 'package:bitirme_projesi/models/weather.dart';
import 'package:bitirme_projesi/service/api_service.dart';
import 'package:bitirme_projesi/widgets/colors.dart';
import 'package:bitirme_projesi/widgets/weatherCards.dart';
import 'package:flutter/material.dart';

class WeatherPages extends StatefulWidget {
  @override
  _WeatherPagesState createState() => _WeatherPagesState();
}

class _WeatherPagesState extends State<WeatherPages> {
  Future<WeatherResponse> fetchData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData = ApiService().getWeather("istanbul");
  }

  @override
  Widget build(BuildContext context) {
    // ApiService().getWeather("istanbul");
    return Scaffold(
      body: buildFutureBuilder(0,"Today"),
    );
  }

  FutureBuilder<WeatherResponse> buildFutureBuilder(int count, String day) {
    return FutureBuilder(
      future: fetchData,
      builder:
          (BuildContext context, AsyncSnapshot<WeatherResponse> snapshot) {
        if (snapshot.hasData) {
          return (WeatherCards(snapshot.data.result[count].degree, day,
              snapshot.data.result[count].description));
        } else {
          return Container(
            width: 550,
            height: 550,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: champagnePink,
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
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
    fetchData = ApiService().getWeather("istanbul");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildFutureBuilder(),
    );
  }

  FutureBuilder<WeatherResponse> buildFutureBuilder() {
    return FutureBuilder(
      future: fetchData,
      builder:
          (BuildContext context, AsyncSnapshot<WeatherResponse> snapshot) {
        if (snapshot.hasData) {
          print("that" + snapshot.data.result[1].degree);
          return (WeatherCards(snapshot.data.result[1].degree, "Tomorrow",
              snapshot.data.result[1].description));
        } else {
          return Container(
            width: 550,
            height: 550,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: champagnePink,
            ),
            child: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
      },
    );
  }
}


class WeatherPagesThree extends StatefulWidget {
  @override
  _WeatherPagesThree createState() => _WeatherPagesThree();
}

class _WeatherPagesThree extends State<WeatherPagesThree> {
  Future<WeatherResponse> fetchData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData = ApiService().getWeather("istanbul");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildFutureBuilder(),
    );
  }

  FutureBuilder<WeatherResponse> buildFutureBuilder() {
    return FutureBuilder(
      future: fetchData,
      builder:
          (BuildContext context, AsyncSnapshot<WeatherResponse> snapshot) {
        if (snapshot.hasData) {
          return (WeatherCards(snapshot.data.result[2].degree, snapshot.data.result[2].day,
              snapshot.data.result[2].description));
        } else {
          return Container(
              width: 550,
              height: 550,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: champagnePink,
              ),
              child: Center(
                child: CircularProgressIndicator(),
              )
          );
        }
      },
    );
  }
}