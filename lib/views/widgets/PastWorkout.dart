import 'package:flutter/material.dart';
import 'ExerciseTile.dart';

class PastWorkout extends StatefulWidget {
  const PastWorkout({super.key});

  @override
  _PastWorkoutState createState() => _PastWorkoutState();
}

class _PastWorkoutState extends State<PastWorkout>{
  int _numExercises = 1;
  void _addExercise(){
    setState(() {
      _numExercises++;
    });
  }

  void _deleteExercise(){
    setState(() {
      _numExercises--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WorkoutHeader(),
            const SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 10),
                const Text("Time:"),
                const SizedBox(width: 10),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.6),
                SetAdd(onAddSet: _addExercise),
                const SizedBox(width: 10)
              ],
            ),
            const SizedBox(height:15),
            for(int i = 0; i < _numExercises; i++) // have to incorporate as custom based on templates
            ExerciseTile(exerciseName: 'Leg Press', isSwim: false, onDeleteExercise: _deleteExercise, isEditable: true),
            const SizedBox(height:15),
            const SaveWorkout(),
          ],
        )
      )
    );
  }
}

class SetAdd extends StatelessWidget{
  final VoidCallback onAddSet;
  const SetAdd({super.key, required this.onAddSet});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.2, 
      height: 30, 
      child: ElevatedButton(
        onPressed: onAddSet,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          backgroundColor: const Color.fromRGBO(144, 238, 144, 1),
          padding: const EdgeInsets.all(16),
        ),
        child:  const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 10, 
              color: Colors.black, 
            ),
          ],
        ),
      ),
    );
  }
}

class SaveWorkout extends StatelessWidget{
  const SaveWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.95, 
      height: 30, 
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(16),
        ),
        child:  const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Save Workout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              )
            )
          ],
        ),
      ),
    );
  }
}

class WorkoutHeader extends StatelessWidget{
  const WorkoutHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: const BoxDecoration(
        color: Colors.blue, // Customize the background color
      ),
      child: const Align(
        alignment: Alignment.center, // Center the text horizontally
        child: Text(
          'CURRENT WORKOUT',
          style: TextStyle(
            color: Colors.white, // Customize the text color
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
