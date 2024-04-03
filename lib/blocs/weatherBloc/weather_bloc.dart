import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_three_assessment/httpRequests/weatherRequest.dart';
import 'package:web_three_assessment/models/weatherModel.dart';

part 'weather_event.dart';

part 'weather_state.dart';

/// WeatherBloc to get the weather data based on latitude and longitude of the city.
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.initial()) {
    on<WeatherEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetWeatherEvent>((event, emit) async {
      emit(state.copyWith(weatherStatus: WeatherStatus.loading));
      try {
        WeatherModel weatherModel = await WeatherRequest.getWeather(event.latitude.toString(), event.longitude.toString());
        if (weatherModel.cod == 200) {
          emit(state.copyWith(weatherStatus: WeatherStatus.loaded, weatherModel: weatherModel));
        } else {
          emit(state.copyWith(weatherStatus: WeatherStatus.error, error: weatherModel.message));
        }
      } catch (e) {
        emit(state.copyWith(weatherStatus: WeatherStatus.error, error: e.toString()));
      }
    });
  }
}
