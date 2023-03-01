import 'package:flutter/material.dart';
import './workout_categories/chestexercises.dart';
import './workout_categories/backexercises.dart';
import './workout_categories/legsexercises.dart';
import './workout_categories/cardioexercises.dart';

class WorkoutCategoryPage extends StatefulWidget {
  const WorkoutCategoryPage({super.key, required this.title});

  final String title;

  @override
  State<WorkoutCategoryPage> createState() => _WorkoutCategoryState();
}

class _WorkoutCategoryState extends State<WorkoutCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      // lists all the workout categories as buttons
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 25,
                    side: const BorderSide(width: 1.5, color: Colors.black),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    fixedSize: const Size(400, 120),
                    backgroundColor: Colors.red[400]),
                child: const Text(
                  'Chest',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChestExercisesPage(
                          title: 'Select a Chest Workout'),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 25,
                    side: const BorderSide(width: 1.5, color: Colors.black),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    fixedSize: const Size(400, 120),
                    backgroundColor: Colors.red[400]),
                child: const Text(
                  'Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BackExercisesPage(
                          title: 'Select a Back Workout'),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 25,
                    side: const BorderSide(width: 1.5, color: Colors.black),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    fixedSize: const Size(400, 120),
                    backgroundColor: Colors.red[400]),
                child: const Text(
                  'Legs',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LegsExercisesPage(
                          title: 'Select a Leg Workout'),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 25,
                    side: const BorderSide(width: 1.5, color: Colors.black),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    fixedSize: const Size(400, 120),
                    backgroundColor: Colors.red[400]),
                child: const Text(
                  'Cardio',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CardioExercisesPage(
                          title: 'Select a Cardio Workout'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
