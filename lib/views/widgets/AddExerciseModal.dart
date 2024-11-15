import 'package:exercise_tracking_app/viewmodels/ExerciseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExerciseModal extends StatefulWidget {
  const AddExerciseModal({super.key,});

  @override
  State<AddExerciseModal> createState() => _AddExerciseModalState();
}

class _AddExerciseModalState extends State<AddExerciseModal> {
  List<String> selectedExercises = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise')
      ),
      body: Consumer<ExerciseViewModel>(
        builder: (context, exerciseViewModel, child) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: exerciseViewModel.exercises.length,
            itemBuilder: (context, index) {
              final exercise = exerciseViewModel.exercises[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedExercises.add(exercise.name);
                  });
                },
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(exercise.name),
                      Text('ID: ${exercise.id}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, selectedExercises);
        },
        child: const Icon(Icons.check),
      ),
    );
  }

}