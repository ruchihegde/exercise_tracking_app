import 'package:flutter/material.dart';

class PastWorkout extends StatefulWidget {
  const PastWorkout({super.key});

  @override
  _PastWorkoutState createState() => _PastWorkoutState();
}

class _PastWorkoutState extends State<PastWorkout>{
  final _workoutSetInputState = _WorkoutSetInputState(); // Create state instance

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
            WorkoutSetInput(exerciseName: 'Leg Press', isSwim: false, onDeleteExercise: _deleteExercise),
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

class WorkoutSetInput extends StatefulWidget {
  final String exerciseName;
  final bool isSwim;
  final VoidCallback onDeleteExercise;

  const WorkoutSetInput({super.key, required this.exerciseName, required this.isSwim, required this.onDeleteExercise});

  @override
  // ignore: library_private_types_in_public_api
  _WorkoutSetInputState createState() => _WorkoutSetInputState();
}

class _WorkoutSetInputState extends State<WorkoutSetInput> {
  int _numSets = 1;
  String _selectedUnit = 'lbs';

  void _changeUnit(String newUnit) {
    setState(() {
      _selectedUnit = newUnit;
    });
  }

  void _addSet() {
    setState(() {
      _numSets++;
    });
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Text('${i + 1}. '),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Reps',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Weight',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: 'lbs', // Default value
                      items: const [
                        DropdownMenuItem(value: 'lbs', child: Text('lbs')),
                        DropdownMenuItem(value: 'kgs', child: Text('kgs')),
                      ],
                      onChanged: (value) {
                        _changeUnit(value!);
                      },
                    ),
                  ),
                ],
              ),
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