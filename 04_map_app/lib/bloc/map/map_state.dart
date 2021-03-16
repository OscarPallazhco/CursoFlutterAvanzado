part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapIsReady;
  final bool drawRoute;
  final bool moveCameraAutomatic;
  final Map<String, Polyline> polylines;

  MapState({
    this.mapIsReady = false,
    this.drawRoute = true,
    this.moveCameraAutomatic = false,
    Map<String, Polyline> polylines
  }): this.polylines = polylines ?? new Map();

  MapState copyWith({bool mapIsReady, bool drawRoute, bool moveCameraAutomatic, Map<String, Polyline> polylines})
    =>  MapState(
      mapIsReady: mapIsReady ?? this.mapIsReady,
      drawRoute: drawRoute ?? this.drawRoute,
      moveCameraAutomatic: moveCameraAutomatic ?? this.moveCameraAutomatic,
      polylines: polylines ?? this.polylines,
    );

}
