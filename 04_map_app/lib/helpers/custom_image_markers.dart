part of 'helpers.dart';

Future<BitmapDescriptor> customAssetImageMarker() async{
  return await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(
      devicePixelRatio: 2.5,
    ),
    'assets/custom-pin.png'
  );
}

Future<BitmapDescriptor> customNetworkImageMarker() async{
  // obtiene la imagen de internet y la retorna como un BitmapDescriptor
  // en caso de algún error retorna el BitmapDescriptor del asset
  try {
    final result = await Dio().get(
      'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
      options: Options(
        responseType: ResponseType.bytes
      ),
    );
    if (result.statusCode == 200) {
      // cambiar dimensión, en caso de que la imagen de la web no tenga las adecuadas
      final bytes = result.data;
      final imageCodec = await instantiateImageCodec(bytes, targetHeight: 150, targetWidth: 150);
      final frame = await imageCodec.getNextFrame();
      final data = await frame.image.toByteData(format: ImageByteFormat.png);
      return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
    }else{
      return customAssetImageMarker();
    }
  } catch (e) {
    print('Error al obtener la imagen para el custom marker desde la web');
    return customAssetImageMarker();
  }
}