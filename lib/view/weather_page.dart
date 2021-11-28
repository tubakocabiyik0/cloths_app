import 'package:bitirme_projesi/service/api_service.dart';
import 'package:flutter/material.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String dropdownValue = 'İstanbul';
  final _apiService = ApiService();
  double _celsius = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfff8e1),
      body: Center(
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.40),
          child: Column(
            children: [
              _celsius != null ? Text("${_celsius.toStringAsPrecision(3)} C ",style: TextStyle(fontSize: 32),) : Text(""),
              SizedBox(height: 20),
              Text("Choose Your City"),
              SizedBox(height: 10),
              buildDropdownButton(),
              SizedBox(height: 20),
              searchButton(),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton(
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: ['İstanbul', "İzmir", "Bursa", "Bolu"].map((value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
    );
  }

  Widget searchButton() {
    return MaterialButton(
        onPressed: () {

        },
        elevation: 0,
        child: Container(
          height: 45,
          width: 150,
          //color: Colors.teal.shade100,
          child: Center(
              child: Text(
            "search",
            style: TextStyle(color: Colors.black, fontSize: 20),
          )),
          decoration: BoxDecoration(
              color: Colors.orangeAccent.shade100,
              borderRadius: BorderRadius.all(Radius.circular(25))),
        ));
  }



  double toCelsius(double kelvin) {
    double celsius = kelvin - 273.15;
    return celsius;
  }
}
