part of 'my_location_bloc.dart';

@immutable
class MyLocationState {
  final bool following, existLocation;
  final LatLng coord;

  MyLocationState({this.following, this.existLocation, this.coord});

  MyLocationState copyWith({bool following, bool existLocation, LatLng coord})
    => new MyLocationState(
      following     : following ?? this.following,
      existLocation : existLocation ?? this.existLocation,
      coord         : coord ?? this.coord,
    );
}
