part of 'helpers.dart';

Future<BitmapDescriptor> getStartMarkerIcon(int minutes) async{
  final recorder = new PictureRecorder();
  final canvas = new Canvas(recorder);
  final size = new Size(350, 150);
  final startMarker = new StartMarkerPainter(minutes: minutes); 
  startMarker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(350, 150);
  final byteData = await image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());

}

Future<BitmapDescriptor> getEndMarkerIcon(String destinationName, double value, String lengthUnit) async{
  final recorder = new PictureRecorder();
  final canvas = new Canvas(recorder);
  final size = new Size(350, 150);
  final startMarker = new EndMarkerPainter(
    destinationName: destinationName,
    value: value,
    lengthUnit: lengthUnit
  );
  startMarker.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(350, 150);
  final byteData = await image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());

}