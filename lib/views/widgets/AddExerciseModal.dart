import 'package:flutter/material.dart';

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
      body: ListView(
        children: [
          ListTile(
            title: const Text('Exercise 1'),
            onTap: () {
              setState(() {
                selectedExercises.add('Exercise 1');
              });
            },
          ),
          ListTile(
            title: const Text('Exercise 2'),
            onTap: () {
              setState(() {
                selectedExercises.add('Exercise 2');
              });
            },
          ),
          // Add more exercises here
        ],
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