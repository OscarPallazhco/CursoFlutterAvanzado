/* Other Packages */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polyline/polyline.dart' as Poly;

/* Blocs */
import 'package:map_app/bloc/map/map_bloc.dart';
import 'package:map_app/bloc/my_location/my_location_bloc.dart';
import 'package:map_app/bloc/search/search_bloc.dart';

/* Models */
import 'package:map_app/models/search_result.dart';

import 'package:map_app/search/search_destination.dart';

/* Services */
import 'package:map_app/services/traffic_service.dart';

/* Custom Widgets */
part 'btn_my_location_widget.dart';
part 'btn_draw_my_route_widget .dart';
part 'btn_move_camera_automatic_widget.dart';
part 'searchbar_widget.dart';
part 'manual_marker.dart';