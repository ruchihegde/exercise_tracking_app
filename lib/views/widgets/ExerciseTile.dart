import 'package:flutter/material.dart';
import 'ExerciseTileListItem.dart';

class ExerciseTile extends StatefulWidget{
  final String exerciseName;
  final bool isSwim;
  final VoidCallback onDeleteExercise;

  const ExerciseTile({super.key, required this.exerciseName, required this.isSwim, required this.onDeleteExercise});

  @override
  // ignore: library_private_types_in_public_api
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  int _numSets = 1;
  String _selectedUnit = 'lbs';

  void _addSet() {
    setState(() {
      _numSets++;
    });
  }

  void _changeUnit(String? newUnit) {
    if(newUnit != null) {
      setState(() {
        _selectedUnit = newUnit;
      });
    }
  }
  
  void _deleteExercise() {
    widget.onDeleteExercise(); 
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.exerciseName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text('Add Notes'),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Handle note editing
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _deleteExercise,
                    ),
                  ],
                ),
              ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < _numSets; i++)
          ExerciseTileListItem(
              setNumber: i + 1,
              repsController: TextEditingController(),
              weightController: TextEditingController(),
              onUnitChanged: _changeUnit,
          ),
          ElevatedButton(
            onPressed: _addSet,
            child: const Align(
              alignment: Alignment.center,
              child: Text('Add Set')
            ),
          ),
        ],
      ),
    );
  }
}