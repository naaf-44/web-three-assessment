/// LatLonModel which is used to store the latitude and longitude information from the API.
class LatLonModel {
  String? name;
  double? lat;
  double? lon;
  String? country;
  String? state;
  int? cod;
  String? message;

  LatLonModel({this.name, this.lat, this.lon, this.country, this.state, this.cod, this.message});

  LatLonModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lat = json['lat'].toDouble();
    lon = json['lon'].toDouble();
    country = json['country'];
    state = json['state'];
    cod = json['cod'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['country'] = this.country;
    data['state'] = this.state;
    data['cod'] = this.cod;
    data['message'] = this.message;
    return data;
  }
}
