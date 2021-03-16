part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapIsReady;
  final bool drawRoute;
  final bool moveCameraAutomatic;
  final LatLng centralPosition;
  final Map<String, Polyline> polylines;

  MapState({
    this.mapIsReady = false,
    this.drawRoute = false,
    this.moveCameraAutomatic = false,
    this.centralPosition, // comenzará con null
    Map<String, Polyline> polylines
  }): this.polylines = polylines ?? new Map();

  MapState copyWith({
    bool mapIsReady,
    bool drawRoute,
    bool moveCameraAutomatic,
    LatLng centralPosition,
    Map<String, Polyline> polylines
  }) => MapState(
    mapIsReady: mapIsReady ?? this.mapIsReady,
    drawRoute: drawRoute ?? this.drawRoute,
    moveCameraAutomatic: moveCameraAutomatic ?? this.moveCameraAutomatic,
    centralPosition: centralPosition ?? this.centralPosition,
    polylines: polylines ?? this.polylines,
  );

}
