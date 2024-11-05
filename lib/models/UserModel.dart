class User {
  String name;
  List<Achivement> achievements;
  List<Goal> goals;

  User(this.name, this.achievements, this.goals);
}

class Achivement {
  DateTime date;
  String exerciseName;
  int exerciseId;
  int achievementTreshold;

  Achivement(this.date, this.exerciseName, this.exerciseId, this.achievementTreshold);

}

class Goal {
  String exerciseName;
  int exerciseId;
  int goalTreshold;

  Goal(this.exerciseName, this.exerciseId, this.goalTreshold);

}