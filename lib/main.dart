import 'package:flutter/material.dart';
import 'package:maverick/bt_service/SelectBondedDevicePage.dart';
import 'package:maverick/themes/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home: const SelectBondedDevicePage(checkAvailability: false),
    );
  }
}
