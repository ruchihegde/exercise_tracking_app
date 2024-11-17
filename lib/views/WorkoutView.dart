import 'package:flutter/material.dart';
import 'package:exercise_tracking_app/views/widgets/LiveWorkout.dart';
import 'package:exercise_tracking_app/views/widgets/PastWorkout.dart';

class WorkoutView extends StatefulWidget{
  const WorkoutView({super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: <Widget> [ // depending on what they click
        const LiveWorkout(),
        const PastWorkout(),
      ][_selectedIndex]
      );
  }
}