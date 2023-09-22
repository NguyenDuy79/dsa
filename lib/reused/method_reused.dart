import 'package:fitness_app_bloc/data/local/prefs.dart';
import 'package:fitness_app_bloc/data/model/chart.dart';
import 'package:fitness_app_bloc/screen/into_screen/home_page_bloc/home_page_bloc.dart';
import 'package:intl/intl.dart';
import '../config/config.dart';

class MethodReused {
  MethodReused._();
  static String? validWeight(String value) {
    if (value.isEmpty) {
      return 'Please enter the value';
    } else if (value.contains(',') ||
        value.contains(' ') ||
        value.contains('-')) {
      return 'Please enter the number';
    } else if (value[value.indexOf('.') + 1] == '.') {
      return 'Pleas enter the number';
    } else if (double.parse(value) == 0) {
      return 'Please enter the weight';
    } else {
      return null;
    }
  }

  static String filterDouble(String value) {
    if (value.split('.')[1] == '0') {
      return value.split('.')[0];
    } else {
      return value;
    }
  }

  static double getCalories(HomePageState state, bool isMetric) {
    if (state.gender == AppString.male) {
      //
      if (!isMetric) {
        //
        if (state.activity == AppString.activity1) {
          return (66 +
                  (13.7 * state.weight * 0.45359237) +
                  (5 * (state.feet * 30.48 + state.inch * 2.54)) -
                  (6.8 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.2;
        } else if (state.activity == AppString.activity2) {
          return (66 +
                  (13.7 * state.weight * 0.45359237) +
                  (5 * (state.feet * 30.48 + state.inch * 2.54)) -
                  (6.8 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.375;
        } else if (state.activity == AppString.activity3) {
          return (66 +
                  (13.7 * state.weight * 0.45359237) +
                  (5 * (state.feet * 30.48 + state.inch * 2.54)) -
                  (6.8 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.55;
        } else if (state.activity == AppString.activity4) {
          return (66 +
                  (13.7 * state.weight * 0.45359237) +
                  (5 * (state.feet * 30.48 + state.inch * 2.54)) -
                  (6.8 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.725;
        } else {
          return (66 +
                  (13.7 * state.weight * 0.45359237) +
                  (5 * (state.feet * 30.48 + state.inch * 2.54)) -
                  (6.8 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.9;
        }
      } else {
        if (state.activity == AppString.activity1) {
          return (66 +
                  (13.7 * state.weight) +
                  (5 * state.height) -
                  (6.8 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.2;
        } else if (state.activity == AppString.activity2) {
          return (66 +
                  (13.7 * state.weight) +
                  (5 * state.height) -
                  (6.8 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.375;
        } else if (state.activity == AppString.activity3) {
          return (66 +
                  (13.7 * state.weight) +
                  (5 * state.height) -
                  (6.8 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.55;
        } else if (state.activity == AppString.activity4) {
          return (66 +
                  (13.7 * state.weight) +
                  (5 * state.height) -
                  (6.8 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.725;
        } else {
          return (66 +
                  (13.7 * state.weight) +
                  (5 * state.height) -
                  (6.8 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.9;
        }
      }
    } else {
      if (!isMetric) {
        //
        if (state.activity == AppString.activity1) {
          return (655 +
                  (9.6 * state.weight * 0.45359237) +
                  (1.8 * (state.feet * 30.48 + state.inch * 2.54)) -
                  (4.7 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.2;
        } else if (state.activity == AppString.activity2) {
          return (655 +
                  (9.6 * state.weight * 0.45359237) +
                  (1.8 * (state.feet * 30.48 + state.inch * 2.54)) -
                  (4.7 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.375;
        } else if (state.activity == AppString.activity3) {
          return (655 +
                  (9.6 * state.weight * 0.45359237) +
                  (1.8 * (state.feet * 30.48 + state.inch * 2.54)) -
                  (4.7 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.55;
        } else if (state.activity == AppString.activity4) {
          return (655 +
                  (9.6 * state.weight * 0.45359237) +
                  (1.8 * (state.feet * 30.48 + state.inch * 2.54)) -
                  (4.7 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.725;
        } else {
          return (655 +
                  (9.6 * state.weight * 0.45359237) +
                  (1.8 * (state.feet * 30.48 + state.inch * 2.54)) -
                  (4.7 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.9;
        }
      } else {
        if (state.activity == AppString.activity1) {
          return (655 +
                  (9.6 * state.weight) +
                  (1.8 * state.height) -
                  (4.7 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.2;
        } else if (state.activity == AppString.activity2) {
          return (655 +
                  (9.6 * state.weight) +
                  (1.8 * state.height) -
                  (4.7 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.375;
        } else if (state.activity == AppString.activity3) {
          return (655 +
                  (9.6 * state.weight) +
                  (1.8 * state.height) -
                  (4.7 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.55;
        } else if (state.activity == AppString.activity4) {
          return (655 +
                  (9.6 * state.weight) +
                  (1.8 * state.height) -
                  (4.7 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.725;
        } else {
          return (655 +
                  (9.6 * state.weight) +
                  (1.8 * state.height) -
                  (4.7 *
                      DateTime.now()
                          .difference(DateTime.parse(state.age))
                          .inDays ~/
                      365.25)) *
              1.9;
        }
      }
    }
  }

  static List<ChartData> getList() {
    List<ChartData> newList = [];
    for (int i = 0; i < 24; i++) {
      newList.add(ChartData(i.toString(), LocalPref.getInt(i.toString())!));
    }
    return newList;
  }

  static List<DateTime> getWeek(DateTime dateTime) {
    List<DateTime> listDateTime = [];
    switch (dateTime.weekday) {
      case 1:
        for (int i = 0; i < 7; i++) {
          listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(dateTime.add(Duration(days: i)))));
        }
        return listDateTime;

      case 2:
        listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
            .format(dateTime.subtract(const Duration(days: 1)))));
        for (int i = 0; i < 6; i++) {
          listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(dateTime.add(Duration(days: i)))));
        }
        return listDateTime;
      case 3:
        for (int i = 2; i > 0; i--) {
          listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(dateTime.subtract(Duration(days: i)))));
        }
        for (int j = 0; j < 5; j++) {
          listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(dateTime.add(Duration(days: j)))));
        }
        return listDateTime;
      case 4:
        for (int i = 3; i > 0; i--) {
          listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(dateTime.subtract(Duration(days: i)))));
        }
        for (int j = 0; j < 4; j++) {
          listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(dateTime.add(Duration(days: j)))));
        }
        return listDateTime;
      case 5:
        for (int i = 4; i > 0; i--) {
          listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(dateTime.subtract(Duration(days: i)))));
        }
        for (int j = 0; j < 3; j++) {
          listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(dateTime.add(Duration(days: j)))));
        }
        return listDateTime;
      case 6:
        for (int i = 5; i > 0; i--) {
          listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(dateTime.subtract(Duration(days: i)))));
        }
        for (int j = 0; j < 2; j++) {
          listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(dateTime.add(Duration(days: j)))));
        }
        return listDateTime;
      default:
        for (int i = 6; i > 0; i--) {
          listDateTime.add(DateTime.parse(DateFormat('yyyy-MM-dd')
              .format(dateTime.subtract(Duration(days: i)))));
        }

        listDateTime
            .add(DateTime.parse(DateFormat('yyyy-MM-dd').format(dateTime)));

        return listDateTime;
    }
  }

  static List<String> listExercise(
      List<String> muscleGroup, List<String> exercise) {
    List<String> newList = [];
    for (int i = 0; i < exercise.length - 1; i++) {
      if (muscleGroup.contains(exercise[i])) {
        newList.add(exercise[i]);
      }
    }
    return newList;
  }

  static bool getBool(String rep, String weight, index) {
    return rep == '0'
        ? (rep == '0' && weight == '0')
        : (rep.split(':')[index] == '' && weight.split(':')[index] == '');
  }

  static int getQauntity(
    String rep,
  ) {
    if (rep == '0') {
      return 0;
    } else {
      int total = 0;
      for (int i = 0; i < rep.split(':').length - 1; i++) {
        if (rep.split(':')[i].isNotEmpty) {
          total += 1;
        }
      }
      return total;
    }
  }

  static String getExerciseOrMethod(Map<String, Object?> currentData, int index,
      String hint, DateTime dateTime, String value) {
    String exercise = '';
    String methodExercise = '';
    if (currentData[
                DateFormat('E').format(MethodReused.getWeek(dateTime)[index])]
            .toString() !=
        '${AppString.dayOff},') {
      exercise = value.split(';')[index].split(':')[1];
      methodExercise = value.split(';')[index].split(':')[0];
    }
    return hint == AppString.exercise ? exercise : methodExercise;
  }

  static List<String> getMuscleGroup(Map<String, Object?> currentData,
      int index, String hint, DateTime dateTime, String exercise) {
    List<String> back = [];
    List<String> chest = [];
    List<String> shoulder = [];
    List<String> arm = [];
    List<String> legAndGlutes = [];
    if (currentData[
                DateFormat('E').format(MethodReused.getWeek(dateTime)[index])]
            .toString() !=
        '${AppString.dayOff},') {
      back = MethodReused.listExercise(
          AppAnother.backExercise, exercise.split(','));
      chest = MethodReused.listExercise(
          AppAnother.chestExcercise, exercise.split(','));
      shoulder = MethodReused.listExercise(
          AppAnother.shoulderExercise, exercise.split(','));
      arm = MethodReused.listExercise(
          AppAnother.armExercise, exercise.split(','));
      legAndGlutes = MethodReused.listExercise(
          AppAnother.legAndGlutesExercise, exercise.split(','));
    }
    switch (hint) {
      case AppString.back:
        return back;
      case AppString.chest:
        return chest;
      case AppString.shoulder:
        return shoulder;
      case AppString.arm:
        return arm;
      default:
        return legAndGlutes;
    }
  }
}
