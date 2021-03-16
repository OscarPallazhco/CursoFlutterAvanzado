part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapIsReady extends MapEvent{}
class OnMapChangeLocation extends MapEvent{
  final LatLng location;
  OnMapChangeLocation(this.location);
}
class OnMapShowRoute extends MapEvent{}
class OnMapMoveCameraAutomatic extends MapEvent{}

