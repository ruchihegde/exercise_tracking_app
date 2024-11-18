import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:exercise_tracking_app/models/WorkoutModel.dart';

class Workoutviewmodel extends ChangeNotifier{
  Workout? _currentWorkout;

  Workout? get currentWorkout => _currentWorkout;

  void startWorkout(String workoutName){
    _currentWorkout = Workout(
      [], 
      0, 
      workoutName, 
      DateTime.now(), 
      0,
      []
    );
    notifyListeners();
  }

  void addExercise(String name, int sets, int weight, int time){
    if(_currentWorkout != null){
      _currentWorkout!.completed.add(Exercise(name, sets, weight, time));
      notifyListeners();
    }
  }

  Future<void> saveWorkout(Workout workout) async {
    const filePath = 'package:exercise_tracking_app/data/workout.json';
    
    final workoutMap = {
    'completed': workout.completed.map((exercise) => exercise.toJson()).toList(),
    'time': workout.time,
    'workoutName': workout.workoutName,
    'date': workout.date.toIso8601String(),
    'intensity': workout.intensity,
    };

    final file = File(filePath);
    await file.writeAsString(jsonEncode(workoutMap));
  }

}