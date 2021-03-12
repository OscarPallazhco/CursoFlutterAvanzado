import 'package:flutter/material.dart';

import 'package:map_app/pages/gps_acces_page.dart';
import 'package:map_app/pages/loading_page.dart';
import 'package:map_app/pages/map_page.dart';
 
final Map<String, Widget Function(BuildContext) > routes = {
  'loadingpage': (_) => LoadingPage(),
  'gpsaccespage': (_) => GpsAccesPage(),
  'mappage': (_) => MapPage(),
};