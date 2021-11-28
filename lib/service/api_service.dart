import 'dart:convert';
import 'dart:io';

import 'package:bitirme_projesi/models/weather.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<WeatherResponse> getWeather(String cityName) async {

    //6H29tD51G9ACgtyrlDx3tV:3nFypr1ngW3QbA9Vo9cZH0
    //"api.openweathermap.org", "/data/2.5/weather", queryParameters
    final response = await http.get(
      Uri.parse('https://api.collectapi.com/weather/getWeather?data.city=$cityName'),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: 'apikey 6H29tD51G9ACgtyrlDx3tV:3nFypr1ngW3QbA9Vo9cZH0',
      },
    );
    final responseJson = jsonDecode(response.body);
    print(WeatherResponse.fromJson(responseJson).result[1].date.toString());
  }
}
