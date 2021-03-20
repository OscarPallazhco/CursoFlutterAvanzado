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
class OnMapCameraMoved extends MapEvent{
  final LatLng location;
  OnMapCameraMoved(this.location);
}
class OnCreateRoute extends MapEvent{
  final List<LatLng> routePoints;
  final double distance;
  final double duration;
  OnCreateRoute(this.routePoints, this.distance, this.duration);
}