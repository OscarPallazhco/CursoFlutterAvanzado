import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: Center(
        child: BlocBuilder<MyLocationBloc, MyLocationState>(
          builder: (BuildContext context, state) {
            return state.existLocation
            ? Text('${state.coord.latitude}, ${state.coord.longitude}')
            : Text('MapPage');
          },
        ),
      ),
    );
  }
}