
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:map_app/bloc/map/map_bloc.dart';
import 'package:map_app/bloc/my_location/my_location_bloc.dart';

import 'package:map_app/widgets/myWidgets.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  // CameraPosition _currentCameraPosition;

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
    return BlocBuilder<MyLocationBloc, MyLocationState>(
        builder: (BuildContext context, state) {
          // print(' build: ${state.coord.latitude},${state.coord.longitude}');
          return state.existLocation
          ? _scaffoldWithMap(state)
          : _scaffoldWithoutMap();
        },
    );
    
  }

  Widget _scaffoldWithMap(MyLocationState state){

    // ignore: close_sinks
    final mapBloc = BlocProvider.of<MapBloc>(context);
    // print(' _bodyWithMap: ${state.coord.latitude},${state.coord.longitude}');

    mapBloc.add(OnMapChangeLocation(state.coord));

    CameraPosition _kinitialPosition = CameraPosition(
      target: state.coord,
      zoom: 15.0
    );

    return Scaffold(
      body: Stack(
        children: [
          _drawMap(_kinitialPosition, mapBloc),
          Positioned(
            child: SearchBar(),
            top: 10,
            left: 10,
            right: 10,
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           BtnMyLocation(),
           BtnDrawMyRoute(),
           BtnMoveCameraAutomatic(),
        ],
      ),
    );
  }

  GoogleMap _drawMap(CameraPosition _kinitialPosition, MapBloc mapBloc) {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      initialCameraPosition: _kinitialPosition,
      zoomControlsEnabled: false,
      polylines: mapBloc.state.polylines.values.toSet(),
      onMapCreated: (GoogleMapController controller) {
        mapBloc.initMap(controller);
      },
      onCameraMove: (CameraPosition cameraPosition){
        mapBloc.add(OnMapCameraMoved(cameraPosition.target));
        // this._currentCameraPosition = cameraPosition;
      },
      // onCameraIdle: (){
      //   if (this._currentCameraPosition != null) {
      //     mapBloc.add(OnMapCameraMoved(this._currentCameraPosition.target));
      //   }
      // },
    );
  }

  Widget _scaffoldWithoutMap(){
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}