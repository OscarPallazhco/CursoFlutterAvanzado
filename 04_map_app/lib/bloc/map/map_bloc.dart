import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:map_app/themes/uber_map_2017_theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  // ignore: unused_field
  GoogleMapController _mapCtrller;
  Polyline _myRoutePolyline = new Polyline(
    polylineId: PolylineId('myRoute'),
    color: Colors.black87
  );

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
    }else if (event is OnMapChangeLocation) {
      List<LatLng> points = [...this._myRoutePolyline.points, event.location];  // crear arreglo de ptos actuales más el nuevo pto
      this._myRoutePolyline = this._myRoutePolyline.copyWith(pointsParam: points);  // actualizar el polyline actual con el nuevo arreglo de ptos
      Map<String, Polyline> currentPolylines = state.polylines; // obtener el mapa de polylines actual del state
      currentPolylines['myRoute'] = this._myRoutePolyline;  // actualizar en el mapa el polyline de myRoute
      yield state.copyWith(polylines: currentPolylines);  // crear un nuevo estado con el mapa de polylines actualizado
    }else if (event is OnMapShowRoute) {
      if (!state.drawRoute) {
        this._myRoutePolyline = this._myRoutePolyline.copyWith(colorParam: Colors.black87);
      }else{
        this._myRoutePolyline = this._myRoutePolyline.copyWith(colorParam: Colors.transparent);
      }
      Map<String, Polyline> currentPolylines = state.polylines;
      currentPolylines['myRoute'] = this._myRoutePolyline;
      yield state.copyWith(
        drawRoute: !state.drawRoute,
        polylines: currentPolylines,
      );
    }
  }
}
