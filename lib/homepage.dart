import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './workoutcategory.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(450, 850),
              backgroundColor: Colors.grey[850]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Text(
                  "myPRs allows you to record and see your personal record for numerous workouts.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 20),
                child: Text(
                  "Tap anywhere to continue and select the workout category.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const WorkoutCategoryPage(title: 'Select a Category'),
              ),
            );
          },
        ),
      ),
    );
  }
}
