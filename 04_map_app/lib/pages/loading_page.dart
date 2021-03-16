import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_app/pages/map_page.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:map_app/pages/gps_acces_page.dart';
import 'package:map_app/helpers/helpers.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);  //para que esté pendiente del estado de la pagina actual
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    if (state == AppLifecycleState.resumed) {
      print('resumed');
        setState(() {
        _checkGpsAndLocation(context);        
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _checkGpsAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future _checkGpsAndLocation(BuildContext context) async {
    final gpsPermit = await Permission.location.isGranted;
    // final geoPermit = await Geolocator().isLocationServiceEnabled();  //versiones +6 cambia
    final geoPermit = await Geolocator.isLocationServiceEnabled();
    // await Future.delayed(Duration(seconds: 3));

    if (gpsPermit && geoPermit) {
      Navigator.pushReplacement(context, navigateFadeInToPage(context, MapPage() ));
      return 'permisos concedidos';
    }else {
      Navigator.pushReplacement(context, navigateFadeInToPage(context, GpsAccesPage() ));
      return 'permisos no concedidos';
    }
  }
}