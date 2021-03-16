import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GpsAccesPage extends StatefulWidget {
  @override
  _GpsAccesPageState createState() => _GpsAccesPageState();
}

class _GpsAccesPageState extends State<GpsAccesPage> with WidgetsBindingObserver{

  bool popup = false;

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
    // super.didChangeAppLifecycleState(state);

    // caso de cuando regresa de las settings de la app, reenviarlo a la sgte pagina solo si concedió el
    // permiso, caso contrario no realiza nada
    if (state == AppLifecycleState.resumed && !popup) {
      if (await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, 'loadingpage');
      }
    }
  }

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
                  popup = true;
                  final status = await Permission.location.request();
                  await accesGps(status);
                  popup = false;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future accesGps(PermissionStatus status) async{
    switch (status) {
      case PermissionStatus.granted:
        print("otorgado");
        await Navigator.pushReplacementNamed(context, 'loadingpage');
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.undetermined:        
      case PermissionStatus.limited:        
        openAppSettings();
    }
  }

}


