import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_three_assessment/httpRequests/weatherRequest.dart';
import 'package:web_three_assessment/models/latLonModel.dart';

part 'lat_long_event.dart';

part 'lat_long_state.dart';

/// LatLongBloc to get the latitude and longitude of the city.
class LatLongBloc extends Bloc<LatLongEvent, LatLongState> {
  LatLongBloc() : super(LatLongState.initial()) {
    on<LatLongEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetLatLongEvent>((event, emit) async {
      emit(state.copyWith(latLongStatus: LatLongStatus.loading));
      try {
        LatLonModel latLonModel = await WeatherRequest.getLatLong(event.cityName);
        emit(state.copyWith(latLongStatus: LatLongStatus.loaded, latLonModel: latLonModel));
      } catch (e) {
        emit(state.copyWith(latLongStatus: LatLongStatus.error, error: "Please enter valid city name"));
      }
    });
  }
}
