import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LegsExercisesPage extends StatefulWidget {
  const LegsExercisesPage({super.key, required this.title});

  final String title;

  @override
  State<LegsExercisesPage> createState() => _LegsExercisesState();
}

class _LegsExercisesState extends State<LegsExercisesPage> {

  // text controllers
  final _weightController = TextEditingController();
  final _repsController = TextEditingController();

  BorderRadius roundBorder = const BorderRadius.all(
    Radius.circular(20),
  );

  // refernce our workoutBox database
  final _box = Hive.box('workoutBox');

  // write data to box
  void _writeData(int key, String value) {
    _box.put(key, value);
  }

  // reads data from box, and if there is no data will give a value of '0'
  String _ifNull(int keyValue) {
    if (_box.get(keyValue) == null) {
      return '0';
    } else {
      return _box.get(keyValue);
    }
  }

  Widget _displayWorkout(String workout, String weight, String reps) {
    return (Container(
      width: 300,
      height: 120,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.red[400],
        border: Border.all(width: 1.5, color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            workout,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'Weight: $weight    Reps: $reps',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    ));
  }

  Widget _addPR(String workout, int keyValue) {
    return (ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 25,
          side: const BorderSide(width: 1.5, color: Colors.black),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          fixedSize: const Size(100, 120),
          backgroundColor: Colors.red[400]),
      child: const Text(
        'Add PR',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _dialogBuilder(context, workout, keyValue),
    ));
  }

  void _updateText(int keyValue) {
    // adds data to local database
    _writeData(keyValue, _weightController.text.trim());
    _writeData(keyValue + 1, _repsController.text.trim());
    // setSet makes the page refresh
    setState(() {
      _weightController.clear();
      _repsController.clear();
    });
    Navigator.of(context).pop();
  }

  Future<void> _dialogBuilder(
      BuildContext context, String workout, int keyValue) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Add Record for $workout",
              textAlign: TextAlign.center,
            ),
            content: Form(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 8),
                    _buildAddWeight(),
                    const SizedBox(height: 8),
                    _buildAddReps(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              //Done Button Widget
              TextButton(
                  onPressed: (() => _updateText(keyValue)), child: const Text("Done"))
            ],
          );
        });
  }

  Widget _buildAddWeight() => TextField(
        controller: _weightController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: roundBorder),
          hintText: 'Enter Weight',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );

  Widget _buildAddReps() => TextField(
        controller: _repsController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: roundBorder),
          hintText: 'Enter Reps',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );

  // map to assign each workout to a key in the database
  //  20-21: 'Back Squat'
  //  22-23: 'Bulgarian Split Squat'
  //  24-25: 'Deadlift'
  //  26-27: 'Hip Thrust'
  //  28-29: 'Leg Extension'
  //  30-31: 'Leg Press'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      // lists all the chest workouts as buttons
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Back Squat', _ifNull(20), _ifNull(21)),
                  _addPR('Back Squat', 20)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout(
                      'Bulgarian Split Squat', _ifNull(22), _ifNull(23)),
                  _addPR('Bulgarian Split Squat', 22)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Deadlift', _ifNull(24), _ifNull(25)),
                  _addPR('Deadlift', 24)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Hip Thrust', _ifNull(26), _ifNull(27)),
                  _addPR('Hip Thrust', 26)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Leg Extension', _ifNull(28), _ifNull(29)),
                  _addPR('Leg Extension', 28)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Leg Press', _ifNull(30), _ifNull(31)),
                  _addPR('Leg Press', 30)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
