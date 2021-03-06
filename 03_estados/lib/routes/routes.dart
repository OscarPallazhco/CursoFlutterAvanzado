import 'package:flutter/material.dart';

import 'package:estados/pages/page1.dart';
import 'package:estados/pages/page2.dart';



final Map<String, Widget Function(BuildContext) > routes = {
  "page1"     : (_) => Page1(),
  "page2"     : (_) => Page2(),
};