part of 'lat_long_bloc.dart';

/// LatLongEvent to handle different events triggered by the user.
abstract class LatLongEvent extends Equatable {
  const LatLongEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

/// get lat long event to get the latitude and longitude of the city.
class GetLatLongEvent extends LatLongEvent {
  final String? cityName;

  const GetLatLongEvent(this.cityName);

  @override
  // TODO: implement props
  List<Object?> get props => [cityName];
}
