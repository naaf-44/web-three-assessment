import 'dart:convert';

import 'package:web_three_assessment/constants/apiUrls.dart';
import 'package:web_three_assessment/httpRequests/apiRequest.dart';
import 'package:web_three_assessment/models/latLonModel.dart';
import 'package:web_three_assessment/models/weatherModel.dart';

class WeatherRequest {
  static getLatLong(String? cityName) async {
    try {
      String url = "${ApiUrls.baseUrl}${ApiUrls.latLongUrl}".replaceAll("{cityName}", cityName!);
      var response = await ApiRequest.getRequest("$url${ApiUrls.apiKey}");
      var jsonResponse = jsonDecode(response.body.toString().replaceAll("[", "").replaceAll("]", ""));
      LatLonModel latLonModel = LatLonModel.fromJson(jsonResponse);

      /*Iterable latLongIterable = json.decode(response.body);
      List<LatLonModel> latLonModel = List<LatLonModel>.from(latLongIterable.map((model)=> LatLonModel.fromJson(model)));*/
      return latLonModel;
    } catch (e) {
      rethrow;
    }
  }

  static getWeather(String? lat, String? long) async {
    try {
      String url = "${ApiUrls.baseUrl}${ApiUrls.weatherUrl}".replaceAll("{lat}", lat!).replaceAll("{lon}", long!);
      var response = await ApiRequest.getRequest("$url${ApiUrls.apiKey}");
      var jsonResponse = jsonDecode(response.body);
      WeatherModel weatherModel = WeatherModel.fromJson(jsonResponse);
      return weatherModel;
    } catch (e) {
      rethrow;
    }
  }
}
