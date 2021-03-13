import 'package:flutter/material.dart';
import 'package:map_app/pages/gps_acces_page.dart';

import 'package:map_app/helpers/helpers.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _checkPermissions(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
        child: CircularProgressIndicator(),
      );
        },
      ),
    );
  }

  Future _checkPermissions(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 2000));
    Navigator.pushReplacement(context, navigateFadeInToPage(context, GpsAccesPage() ));
  }

}