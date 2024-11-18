import 'package:exercise_tracking_app/views/StatsView.dart';
import 'package:exercise_tracking_app/views/widgets/ExerciseTile.dart';
import 'package:flutter/material.dart';

import '../../models/WorkoutModel.dart';

class WorkoutSummary extends StatefulWidget{
  const WorkoutSummary({super.key});

  @override
  _WorkoutSummaryState createState() => _WorkoutSummaryState();

}

class _WorkoutSummaryState extends State<WorkoutSummary>{
  List<String> selectedTags = [];

  List<Exercise> exercises = [Exercise('Leg Press', 2, 120, 12)];
  
  void _removeExercise(int index) {
    setState(() {
      exercises.removeAt(index);
    });
  }

  /*void _addTag(String tagName){
    setState(() {
      selectedTags.add(tagName);
    });
  }*/

  /*void _saveWorkout(){
      final workout = Workout(

      )
  }*/



  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: const BoxDecoration(
              color: Colors.blue, 
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WorkoutHeader(),
                TagButton(),
              ],
            ),
          ),
          const SizedBox(height: 16.0), 
          for(int i = 0; i < exercises.length; i++) // have to incorporate as custom based on templates
          ExerciseTile(exerciseName: exercises[i].name, isSwim: false, isEditable: false, onDeleteExercise: () => _removeExercise(i),),
          const Intensity(), 
          const SizedBox(height: 16.0),
          const CloseDisplay(),
        ],
      ),
    ),
  );
  }
}

class Intensity extends StatefulWidget {
  const Intensity({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IntensityState createState() => _IntensityState();
}

class _IntensityState extends State<Intensity> {
  int selectedIntensity = 0; // Initial selected value

  void _incrementIntensity() {
    setState(() {
      selectedIntensity = (selectedIntensity + 1).clamp(1, 10);
    });
  }

  void _decrementIntensity() {
    setState(() {
      selectedIntensity = (selectedIntensity - 1).clamp(1, 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.blue, 

        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            IconButton(
            icon: const Icon(Icons.arrow_upward, size: 30, color: Colors.black),
            onPressed: _incrementIntensity,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_downward, size: 30, color: Colors.black),
              onPressed: _decrementIntensity,
            ),
            Text(
            selectedIntensity.toString(), 
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
          ],
          ),
          const Text(
            'Intensity',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CloseDisplay extends StatelessWidget{
  const CloseDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox( // green + button
      width: MediaQuery.of(context).size.width * 0.95, 
      height: 30, 
      child: ElevatedButton(
        onPressed: () {
          // send info to workout view model to save workout in model
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StatsView(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          backgroundColor: const Color.fromRGBO(144, 238, 144, 1),
          padding: const EdgeInsets.all(16),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Close Display',
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

class TagButton extends StatelessWidget{
  const TagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
      child: ElevatedButton(
      onPressed: (){},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
      ),
      child:  const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.tag_outlined,
            size: 10, 
            color: Colors.black, 
          ),
          Text('Tags', style: TextStyle(color: Colors.black),),
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
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
        color: Colors.blue, // Customize the background color
      ),
      child: const Align(
        alignment: Alignment.topLeft, // Center the text horizontally
        child: Text(
          'WORKOUT NAME',
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
