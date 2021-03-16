part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapIsReady;
  final bool drawRoute;
  final Map<String, Polyline> polylines;

  MapState({
    this.mapIsReady = false,
    this.drawRoute = true,
    Map<String, Polyline> polylines
  }): this.polylines = polylines ?? new Map();

  MapState copyWith({bool mapIsReady, bool drawRoute, Map<String, Polyline> polylines})
    =>  MapState(
      mapIsReady: mapIsReady ?? this.mapIsReady,
      drawRoute: drawRoute ?? this.drawRoute,
      polylines: polylines ?? this.polylines,
    );

}
