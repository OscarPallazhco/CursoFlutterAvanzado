import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:map_app/global/environments.dart';

import 'package:map_app/models/traffic_response.dart';

class TrafficService{

  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService(){
    return _instance;
  }

  final _dio = new Dio();
  final _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey = Environments.apiKey;

  Future getStartAndEndCoords(LatLng start, LatLng end) async{
    final coordsString = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '${this._baseUrl}/mapbox/driving/$coordsString';
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

}