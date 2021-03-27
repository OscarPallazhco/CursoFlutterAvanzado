part of 'helpers.dart';

void showAlert(BuildContext context, String title, String message){
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          MaterialButton(
            child: Text('Ok'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      )
    );
  } else if(Platform.isIOS){
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),        
        content: CupertinoActivityIndicator(),
        actions: [
          CupertinoButton(
            child: Text('Ok'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      )
    );
  }
}

void showLoading(BuildContext context){
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Espere...'),
        content: LinearProgressIndicator(),
      )
    );
  } else if(Platform.isIOS){
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Espere...'),
        content: CupertinoActivityIndicator(),
      )
    );
  }
}