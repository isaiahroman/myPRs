import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CardioExercisesPage extends StatefulWidget {
  const CardioExercisesPage({super.key, required this.title});

  final String title;

  @override
  State<CardioExercisesPage> createState() => _CardioExercisesState();
}

class _CardioExercisesState extends State<CardioExercisesPage> {

  // text controller
  final _timeController = TextEditingController();

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

  Widget _displayWorkout(String workout, String time) {
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
            'Time: $time',
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
    _writeData(keyValue, _timeController.text.trim());
    // setSet makes the page refresh
    setState(() {
      _timeController.clear();
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
                    _buildAddTime(),
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

  Widget _buildAddTime() => TextField(
        controller: _timeController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: roundBorder),
          hintText: 'Enter Time',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );

  // map to assign each workout to a key in the database
  //  32: 'Cycling'
  //  33: 'Elliptical'
  //  34: 'Rowing Machine'
  //  35: 'Running'
  //  36: 'Stairmaster'

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
                  _displayWorkout('Cycling', _ifNull(32)),
                  _addPR('Cycling', 32)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Elliptical', _ifNull(33)),
                  _addPR('Elliptical', 33)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Rowing Machine', _ifNull(34)),
                  _addPR('Rowing Machine', 34)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Running', _ifNull(35)),
                  _addPR('Running', 35)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _displayWorkout('Stairmaster', _ifNull(36)),
                  _addPR('Stairmaster', 36)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
