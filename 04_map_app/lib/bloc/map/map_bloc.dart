import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:map_app/themes/uber_map_2017_theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  // ignore: unused_field
  GoogleMapController _mapCtrller;

  void initMap(GoogleMapController controller){
    if (!state.mapIsReady) {
      this._mapCtrller = controller;
      this._mapCtrller.setMapStyle(jsonEncode(mapTheme));
      add(OnMapIsReady());
    }
  }

  void moveCamera(LatLng newLatlng){
    final cameraUpdate = CameraUpdate.newLatLng(newLatlng);
    this._mapCtrller?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event,) async* {
    if (event is OnMapIsReady) {
      yield state.copyWith(mapIsReady: true);
    }
  }
}
