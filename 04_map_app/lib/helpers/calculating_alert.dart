part of 'helpers.dart';

void calculatingAlert(BuildContext context){
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Espere por favor'),
        content: Text('Calculando ruta'),
      )
    );
  } else if(Platform.isIOS){
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Espere por favor'),
        content: CupertinoActivityIndicator(),
      )
    );
  }
}