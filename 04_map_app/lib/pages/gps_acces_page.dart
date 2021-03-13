import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GpsAccesPage extends StatefulWidget {
  @override
  _GpsAccesPageState createState() => _GpsAccesPageState();
}

class _GpsAccesPageState extends State<GpsAccesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Se requiere permisos para su uso',
              style: TextStyle(color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: MaterialButton(
                color: Colors.black,
                shape: StadiumBorder(),
                splashColor: Colors.transparent,
                child: Text('Solicitar acceso', style: TextStyle(color: Colors.white),),
                elevation: 0,
                onPressed: () async {
                  var status = await Permission.location.request();
                  accesGps(status);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void accesGps(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        print("otorgado");
        Navigator.pushReplacementNamed(context, 'mappage');
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }

}


