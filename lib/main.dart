import 'package:flutter/material.dart';
import 'package:playground/ui/home.dart';

import 'di.dart';

void main() async {
  configureDependencies();
  runApp(const MaterialApp(
    home: Home(),
  ));
}
