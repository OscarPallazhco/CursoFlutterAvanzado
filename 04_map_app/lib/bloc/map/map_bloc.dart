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
    color: Colors.transparent,
    width: 5
  );
  
  Polyline _myDestinationRoutePolyline = new Polyline(
    polylineId: PolylineId('myDestinationRoute'),
    color: Colors.black87,
    width: 5
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
      yield* _onMapChangeLocation(event);
      // yield* para regresar no el stream sino la emisión del stream
    }else if (event is OnMapShowRoute) {
      yield* _onMapShowRoute(event);
    }else if (event is OnMapMoveCameraAutomatic) {
      // ver en _onMapChangeLocation el uso de la funcion moveCamera()
      yield state.copyWith(moveCameraAutomatic: !state.moveCameraAutomatic);
    }else if (event is OnMapCameraMoved) {
      yield state.copyWith(centralPosition: event.location);
    }else if (event is OnCreateRoute) {
      yield* _onCreateRoute(event);
    }
  }

  Stream<MapState> _onMapChangeLocation(OnMapChangeLocation event) async*{
    if(state.moveCameraAutomatic) moveCamera(event.location); // mover la camara automáticamente solo si el usuario tiene activado la función
    List<LatLng> points = [...this._myRoutePolyline.points, event.location];  // crear arreglo de ptos actuales más el nuevo pto
    this._myRoutePolyline = this._myRoutePolyline.copyWith(pointsParam: points);  // actualizar el polyline actual con el nuevo arreglo de ptos
    Map<String, Polyline> currentPolylines = state.polylines; // obtener el mapa de polylines actual del state
    currentPolylines['myRoute'] = this._myRoutePolyline;  // actualizar en el mapa el polyline de myRoute
    yield state.copyWith(polylines: currentPolylines);  // crear un nuevo estado con el mapa de polylines actualizado
  }
  
  Stream<MapState> _onMapShowRoute(OnMapShowRoute event) async*{
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

  Stream<MapState> _onCreateRoute(OnCreateRoute event) async*{
    // polyline
    this._myDestinationRoutePolyline = this._myDestinationRoutePolyline.copyWith(pointsParam: event.routePoints);
    Map<String, Polyline> currentPolylines = state.polylines;
    currentPolylines['myDestinationRoute'] = this._myDestinationRoutePolyline;

    // start marker
    Marker initialMarker = new Marker(
      markerId: MarkerId('initialMarker'),
      position: event.routePoints[0],
    );
  
    // end marker
    Marker endMarker = new Marker(
      markerId: MarkerId('endMarker'),
      position: event.routePoints[event.routePoints.length - 1],
    );

    Map<String, Marker> currentMarkers = {...state.markers};
    currentMarkers['initialMarker'] = initialMarker;
    currentMarkers['endMarker'] = endMarker;
    
    yield state.copyWith(
      polylines: currentPolylines,
      markers: currentMarkers
    );
  }

}
