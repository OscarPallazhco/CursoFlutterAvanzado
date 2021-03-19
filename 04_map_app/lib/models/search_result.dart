import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool cancel;
  final bool manual;
  final LatLng destinationPosition;
  final String destinationName;
  final String destinationDescription;

  SearchResult({@required this.cancel, this.manual, this.destinationPosition, this.destinationName, this.destinationDescription});

}