import 'package:flutter/material.dart';
import 'package:fun_fluter/app.dart';
import 'package:fun_fluter/services/my_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyService().init();
  runApp(const MyApp());
}
