import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:map_app/global/environments.dart';

import 'package:map_app/helpers/debouncer.dart';

import 'package:map_app/models/places_response.dart';
import 'package:map_app/models/traffic_response.dart';
import 'package:map_app/models/infoCoords_response.dart';

class TrafficService{

  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService(){
    return _instance;
  }

  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 400 ));

  final StreamController<PlacesResponse> _placesStreamCtrller = new StreamController<PlacesResponse>.broadcast();
  Stream<PlacesResponse> get getPlacesStream => this._placesStreamCtrller.stream;

  final _baseDirUrl = 'https://api.mapbox.com/directions/v5';
  final _baseGeoUrl = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey = Environments.apiKey;



  Future<TrafficResponse> getStartAndEndCoords(LatLng start, LatLng end) async{
    final coordsString = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '${this._baseDirUrl}/mapbox/driving/$coordsString';
    final queryParameters = {
      'alternatives' : 'true',
      'geometries' : 'polyline6',
      'steps' : 'false',
      'access_token' : _apiKey,
      'language' : 'es',
    };

    //TODO: tryCatch
    final resp = await _dio.get(url, queryParameters: queryParameters);

    final data = TrafficResponse.fromJson(resp.data);

    return data;
  }

  Future<PlacesResponse> _getPlacesResults(String query, LatLng proximity) async{
    try {
      final url = '${this._baseGeoUrl}/mapbox.places/$query.json';
      final queryParameters = {
        'autocomplete' : 'true',
        'proximity' : '${proximity.longitude},${proximity.latitude}',
        'access_token' : _apiKey,
        'language' : 'es',
      };

      final resp = await _dio.get(url, queryParameters: queryParameters);

      if (resp.statusCode == 200) {
        final data = placesResponseFromJson(resp.data);
        return data;
      } else {
        print('respuesta fallida del servidor: ${resp.statusCode}');
        return PlacesResponse(features: []);
      }

   } catch (e) {
      print(e);
      return PlacesResponse(features: []);
    }
  }

  // esta funcion sera la encargada de hacer la consulta a la api solo cada 2000 ms y no
  // en cada tecleo del usuario
  void getPlacesResults( String query, LatLng proximity ) {
    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final results = await this._getPlacesResults(value, proximity);
      this._placesStreamCtrller.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 400), (_) {
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 401)).then((_) => timer.cancel()); 

  }

  Future<InfoCoordsResponse> getInfoOfCoords(LatLng location) async{
    try {
      final url = '${this._baseGeoUrl}/mapbox.places/${location.longitude},${location.latitude}.json';
      final queryParameters = {
        'access_token' : _apiKey,
        'language' : 'es',
      };

      final resp = await _dio.get(url, queryParameters: queryParameters);

      if (resp.statusCode == 200) {
        final data = infoCoordsResponseFromJson(resp.data);
        return data;
      } else {
        print('respuesta fallida del servidor: ${resp.statusCode}');
        return InfoCoordsResponse();
      }

   } catch (e) {
      print(e);
      return InfoCoordsResponse();
    }
  }

}