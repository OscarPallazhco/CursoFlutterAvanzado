part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapIsReady;

  MapState({this.mapIsReady = false});

  MapState copyWith({bool mapIsReady})
    =>  MapState(
      mapIsReady: mapIsReady ?? this.mapIsReady
    );

}
