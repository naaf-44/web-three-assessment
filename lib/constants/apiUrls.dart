/// API URLs which is used accross the app.
class ApiUrls {
  static const String apiKey= "&appid=00bd1bec8c300a65c3a7c49c558e2d53";

  static const String baseUrl = "http://api.openweathermap.org/";

  static const String iconUrl = "https://openweathermap.org/img/wn/{iconCode}@{iconSize}x.png";

  static const String latLongUrl = "geo/1.0/direct?q={cityName}";
  static const String weatherUrl = "data/2.5/weather?lat={lat}&lon={lon}";
}