
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:map_app/bloc/map/map_bloc.dart';
import 'package:map_app/bloc/my_location/my_location_bloc.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  void initState() {
    BlocProvider.of<MyLocationBloc>(context).startTracking();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MyLocationBloc>(context).stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyLocationBloc, MyLocationState>(
        builder: (BuildContext context, state) {
          // print(' build: ${state.coord.latitude},${state.coord.longitude}');
          return state.existLocation
          ? _bodyWithMap(state)
          : _bodyWithoutMap();
        },
      ),
    );
  }

  Widget _bodyWithMap(MyLocationState state){

    // ignore: close_sinks
    final mapBloc = BlocProvider.of<MapBloc>(context);
    print(' _bodyWithMap: ${state.coord.latitude},${state.coord.longitude}');

    CameraPosition _kinitialPosition = CameraPosition(
      target: state.coord,
      zoom: 15.0,
    );

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kinitialPosition,
      onMapCreated: (GoogleMapController controller) {
        mapBloc.initMap(controller);
      },
    );
  }

  Widget _bodyWithoutMap(){
    return Center(
      child: Text('No existen coordenadas'),
    );
  }

}