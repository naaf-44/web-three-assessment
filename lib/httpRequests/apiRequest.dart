import 'package:http/http.dart' as http;

class ApiRequest {
  /// http get request to call the GET_REQUEST
  static Future getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      print("URL: $url");
      print("RESPONSE BODY: ${response.body}");
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// http get request to call the POST_REQUEST
  /// this method is not used as of now.
  /// this might be required in future
  static Future postRequest(String url, Map body) async {
    try {
      var response = await http.post(Uri.parse(url), body: body);
      print("URL: $url");
      print("RESPONSE BODY: ${response.body}");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
