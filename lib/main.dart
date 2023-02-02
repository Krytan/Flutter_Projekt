import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/data/workout_data.dart';
import 'package:test_app/pages/start_page.dart';
import 'pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize hive
  await Hive.initFlutter();

  // open a hive box
  await Hive.openBox("workout_database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => WorkoutData(),
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startPage(),
      ),
    );
  }
}
