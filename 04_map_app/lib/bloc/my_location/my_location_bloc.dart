import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'my_location_event.dart';
part 'my_location_state.dart';

class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {

  StreamSubscription<Position> _positionSubscription;

  MyLocationBloc() : super(MyLocationState());

  @override
  Stream<MyLocationState> mapEventToState(MyLocationEvent event) async* {
    if (event is OnLocationChanged) {
      yield state.copyWith(
        existLocation: true,
        coord: event.location
      );
    }
  }

  void startTracking(){
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10
    ).listen((Position position) { 
      // print(position);
      final newLocation = new LatLng(position.latitude, position.longitude);
      add(OnLocationChanged(newLocation));
    });
  }

  void stopTracking() {
    _positionSubscription?.cancel();  
  }

}
