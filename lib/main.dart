import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './splashpage.dart';

void main() async {
  // initialize hive
  await Hive.initFlutter();

  await Hive.openBox('workoutBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.grey[850],
          fontFamily: 'Urbanist'),
          debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
