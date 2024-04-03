part of 'lat_long_bloc.dart';

/// LatLongStatus to handle the different state of the bloc.
enum LatLongStatus { initial, loading, loaded, error }

class LatLongState extends Equatable {
  final LatLongStatus latLongStatus;
  final LatLonModel latLonModel;
  final String error;

  const LatLongState({required this.latLongStatus, required this.latLonModel, required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [latLongStatus, latLonModel, error];

  factory LatLongState.initial() {
    return LatLongState(latLongStatus: LatLongStatus.initial, latLonModel: LatLonModel(), error: "");
  }

  LatLongState copyWith({LatLongStatus? latLongStatus, LatLonModel? latLonModel, String? error}) {
    return LatLongState(latLongStatus: latLongStatus ?? this.latLongStatus, latLonModel: latLonModel ?? this.latLonModel, error: error ?? this.error);
  }
}
