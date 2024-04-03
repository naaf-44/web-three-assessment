part of 'weather_bloc.dart';

/// WeatherState to handle the different state of the bloc.
enum WeatherStatus { initial, loading, loaded, error }

class WeatherState extends Equatable {
  final WeatherStatus weatherStatus;
  final WeatherModel weatherModel;
  final String error;

  const WeatherState({required this.weatherStatus, required this.weatherModel, required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [weatherStatus, weatherModel, error];

  factory WeatherState.initial() {
    return WeatherState(weatherStatus: WeatherStatus.initial, weatherModel: WeatherModel(), error: "");
  }

  WeatherState copyWith({WeatherStatus? weatherStatus, WeatherModel? weatherModel, String? error}) {
    return WeatherState(weatherStatus: weatherStatus ?? this.weatherStatus, weatherModel: weatherModel ?? this.weatherModel, error: error ?? this.error);
  }
}
