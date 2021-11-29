import 'package:flutter/material.dart';
import 'package:playground/ui/auth/login.dart';

import 'di.dart';

void main() async {
  configureDependencies();
  runApp(const MaterialApp(
    home: Login(),
  ));
}
