import 'package:flutter/material.dart';
import 'package:map_app/custom_markers/start_marker.dart';

class TestMarkerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            painter: StartMarkerPainter(minutes: 152),
          ),
        ),
      ),
    );
  }
}
