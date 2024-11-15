import 'package:exercise_tracking_app/viewmodels/ExerciseViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/TemplateModel.dart';
import './widgets/AddExerciseModal.dart';

class TemplateBuilderView extends StatefulWidget {
  final Template? starterTemplate;

  const TemplateBuilderView({
    super.key,
    this.starterTemplate
  });

  @override
  State<TemplateBuilderView> createState() => _TemplateBuilderViewState();
}

class _TemplateBuilderViewState extends State<TemplateBuilderView> {
  String title = "";
  TextEditingController titleController = TextEditingController();
  List<String> exercises = [];

  @override
  void initState() {
    super.initState();
    titleController.addListener(_onTitleChanged);
    if (widget.starterTemplate != null) {
      title = widget.starterTemplate!.name;
      titleController.text = title;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExerciseViewModel>(context, listen: false).fetchExercises();
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void _onTitleChanged() {
    title = titleController.text;
    print('Title is $title');
  }

  void _showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Feature TBD...'),
      duration: Duration(seconds: 2)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _showAddExerciseModal(BuildContext context) async {
    final selectedExercises = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExerciseModal()),
    );
    if (selectedExercises != null && selectedExercises.length > 0) {
      setState(() {
        exercises.addAll(selectedExercises);
      });
    }
  }

  void _onSaveTemplateButtonClicked(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('save that mf template'),
      duration: Duration(seconds: 2)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: SizedBox(
          width: width * 0.8,
          child: TextField(
            controller: titleController,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: 'New Custom Workout',
              contentPadding: const EdgeInsets.only(left: 10.0, bottom: -4.5),
              enabledBorder: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(),
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),        
        ),
        actions: [
          TextButton.icon(
            onPressed: () => _showSnackBar(context),
            icon: const Icon(Icons.tag),
            label: const Text(
              'Tags',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: SizedBox(
              width: width * 0.80,
              child: TextButton.icon(
                onPressed: () => _showAddExerciseModal(context),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add Exercise',
                  style: TextStyle(
                    fontSize: 20.0
                  )
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ExerciseViewModel>(
              builder: (context, exerciseViewModel, child) {
                return ListView.builder(
                  itemCount: exerciseViewModel.exercises.length,
                  itemBuilder: (context, idx) {
                    final exercise = exerciseViewModel.exercises[idx];
                    return Card(
                      child: Column(
                        children: [
                          Text('${exercise.name} (${exercise.id})'),                        
                        ]
                      )
                    );
                  }
                );
              }
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onSaveTemplateButtonClicked(context),
        label: const Text('Save Template'),
        icon: const Icon(Icons.save_alt_outlined),
        backgroundColor: Colors.green[400],
        foregroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}