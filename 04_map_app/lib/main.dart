import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:map_app/bloc/map/map_bloc.dart';
import 'package:map_app/bloc/my_location/my_location_bloc.dart';
import 'package:map_app/bloc/search/search_bloc.dart';

import 'package:map_app/routes/routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => MyLocationBloc(),),
        BlocProvider(create: (BuildContext context) => MapBloc(),),
        BlocProvider(create: (BuildContext context) => SearchBloc(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loadingpage',
        routes: routes,
      ),
    );
  }
}