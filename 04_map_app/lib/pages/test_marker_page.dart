import 'package:flutter/material.dart';
import 'package:map_app/custom_markers/custom_markers.dart';

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
            // painter: StartMarkerPainter(minutes: 152),
            painter: EndMarkerPainter(destinationName: 'Parque Samanes, Parque Samanes, Parque Samanes, ', value: 30.6, lengthUnit: 'm'),
          ),
        ),
      ),
    );
  }
}
