import 'package:flutter/material.dart';
import 'package:fuel_calculator/model/fuel_record.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'main_fuel_page.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FuelRecordAdapter());
  await Hive.openBox('fuelRecords');
  runApp(const HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainFuelPage(),
    );
  }
}
