import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BackExercisesPage extends StatefulWidget {
  const BackExercisesPage({super.key, required this.title});

  final String title;

  @override
  State<BackExercisesPage> createState() => _BackExercisesState();
}

class _BackExercisesState extends State<BackExercisesPage> {

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

  // reads data from box, and if there is no data will give a vaklue of '0'
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
  //  10-11: 'Dumbbell Pull-Over'
  //  12-13: 'Front Barbell Shrugs'
  //  14-15: 'Lat Pulldown'
  //  16-17: 'Seated Row'
  //  18-19: 'T-Bar Row'

  @override
  Widget build(context) {
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
                  _displayWorkout(
                      'Dumbbell Pull-Over', _ifNull(10), _ifNull(11)),
                  _addPR('Dumbell Pull-Over', 10)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout(
                      'Front Barbell Shrugs', _ifNull(12), _ifNull(13)),
                  _addPR('Front Barbell Shrugs', 12)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Lat Pulldown', _ifNull(14), _ifNull(15)),
                  _addPR('Lat Pulldown', 14)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Seated Row', _ifNull(16), _ifNull(17)),
                  _addPR('Seated Row', 16)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('T-Bar Row', _ifNull(18), _ifNull(19)),
                  _addPR('T-Bar Row', 18)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
