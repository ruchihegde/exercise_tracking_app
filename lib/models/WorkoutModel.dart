class Workout{
  final List<Exercise> completed;
  final int time;
  final String workoutName;
  final DateTime date;
  final int intensity;
  final List<Tag> tags;

  Workout(this.completed, this.time, this.workoutName, this.date, this.intensity, this.tags);

  Map<String, dynamic> toJson() {
    return {
      'completed': completed.map((exercise) => exercise.toJson()).toList(),
      'time': time,
      'workoutName': workoutName,
      'date': date.toIso8601String(),
      'intensity': intensity,
    };
  }

}

class Tag {
  final String name;

  Tag(this.name);
}

class Exercise{
  String name;
  int sets;
  int weight;
  int time;

  Exercise(this.name, this.sets, this.weight, this.time);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets,
      'weight': weight,
      'time': time,
    };
  }

}