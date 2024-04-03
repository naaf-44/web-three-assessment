part of 'weather_bloc.dart';

/// WeatherEvent to handle different events triggered by the user.
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

/// get weather event to get the weather data.
class GetWeatherEvent extends WeatherEvent {
  final String? latitude;
  final String? longitude;

  const GetWeatherEvent(this.latitude, this.longitude);

  @override
  // TODO: implement props
  List<Object?> get props => [latitude, longitude];
}
