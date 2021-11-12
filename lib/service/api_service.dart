import 'dart:convert';

import 'package:bitirme_projesi/models/weather.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<WeatherResponse> getWeather(String cityName) async {

    //6H29tD51G9ACgtyrlDx3tV:3nFypr1ngW3QbA9Vo9cZH0
    //api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    final queryParameters = {
      'q': cityName,
      'appid': 'f6860a27e7f3e43bb0702b83cb0aa054'
    };
    final uri = Uri.http(
        "api.openweathermap.org", "/data/2.5/weather", queryParameters);

    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
