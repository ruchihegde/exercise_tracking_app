class Workout{
  List<Exercise> completed;
  int time;
  String workoutName;
  DateTime date;
  int intensity;

  Workout(this.completed, this.time, this.workoutName, this.date, this.intensity);
}

class Exercise{
  String name;
  int sets;
  int weight;
  int time;

  Exercise(this.name, this.sets, this.weight, this.time);
}