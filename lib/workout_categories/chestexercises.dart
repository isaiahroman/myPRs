import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChestExercisesPage extends StatefulWidget {
  const ChestExercisesPage({super.key, required this.title});

  final String title;
  @override
  State<ChestExercisesPage> createState() => _ChestExercisesState();
}

class _ChestExercisesState extends State<ChestExercisesPage> {

  // text controllers
  final _weightController = TextEditingController();
  final _repsController = TextEditingController();

  BorderRadius roundBorder = const BorderRadius.all(
    Radius.circular(20),
  );

  // refernce our workoutBox database
  final _box = Hive.box('workoutBox');

  // write data
  void _writeData(int key, String value) {
    _box.put(key, value);
  }

  // read data
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
              onPressed: (() => _updateText(keyValue)),
              child: const Text("Done"),
            )
          ],
        );
      },
    );
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
  //  0-1: 'Cable Crossover'
  //  2-3: 'Decline Machine Chest Press'
  //  4-5: 'Horizontal Barbell Bench Press'
  //  6-7: 'Incline Dumbbell Bench Press'
  //  8-9: 'Landmine Press'

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
                  _displayWorkout('Cable Crossover', _ifNull(0), _ifNull(1)),
                  _addPR('Cable Crossover', 0)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout(
                      'Decline Machine Chest Press', _ifNull(2), _ifNull(3)),
                  _addPR('Decline Machine Chest Press', 2)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout(
                      'Horizontal Barbell Bench Press', _ifNull(4), _ifNull(5)),
                  _addPR('Horizontal Barbell Bench Press', 4)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout(
                      'Incline Dumbbell Bench Press', _ifNull(6), _ifNull(7)),
                  _addPR('Incline Dumbbell Bench Press', 6)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Landmine Press', _ifNull(8), _ifNull(9)),
                  _addPR('Landmine Press', 8)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
