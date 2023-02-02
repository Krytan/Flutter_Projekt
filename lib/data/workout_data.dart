import 'package:flutter/material.dart';
import 'package:test_app/data/hive_database.dart';
import 'package:test_app/date&time/date_time.dart';
import 'package:test_app/models/exercise.dart';
import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabsae();

  /*

  WORKOUT DATA STRUCTURE

  */

  List<Workout> workoutList = [
    Workout(
      name: "Upper Body",
      exercises: [
        Exercise(name: "Bicep Curls", weight: "10", reps: "10", sets: "3"),
      ],
    ),
    Workout(
      name: "Lower Body",
      exercises: [
        Exercise(name: "Squats", weight: "10", reps: "10", sets: "3"),
      ],
    ),
  ];

  // if there are workouts already in database, then get that workout list,
  void initializeWorkoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDatabase();
      // otherwise use default workouts
    } else {
      db.saveToDatabase(workoutList);
    }

    // load heat map
    loadHeatMap();
  }

  // get length of a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  // get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // add a workout
  void addWorkout(String name) {
    // add a new workout with a blank list of exercises
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
  }

  // add an exercise to a workout

  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises.add(
      Exercise(
        name: exerciseName,
        weight: weight,
        reps: reps,
        sets: sets,
      ),
    );

    notifyListeners();
  }

  // check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    // find the relevant workout and relevant exercise in that workout
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
    // load heat map
    loadHeatMap();
  }

  // return the relevant workout object, given a workout name
  Workout getRelevantWorkout(String workoutName) {
    //Find relevant Workout
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }

  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    //find relevant workout first
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    // then find the relevant exercise in that workout
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }

  // get start date
  String getStartDate() {
    return db.getStartDate();
  }

  /*

  HEAT MAP

  */

  Map<DateTime, int> heatMapDataSet = {};

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(getStartDate());

    // count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today, and add each completion status to the dataset
    // "COMPLETION_STATUS_" will be the key in the database
    for (int i = 0; i < daysInBetween + 1; i++) {
      String dayTime = convertDateTime(startDate.add(Duration(days: i)));

      // complettion status = 0 or 1
      int completionStatus = db.getCompletionStatus(dayTime);

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // year
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): completionStatus
      };

      // add to the heat map dateset
      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}
