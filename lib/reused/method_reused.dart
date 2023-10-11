import 'package:fitness_app_bloc/data/local/prefs.dart';
import 'package:fitness_app_bloc/data/model/chart.dart';
import 'package:fitness_app_bloc/screen/into_screen/home_page_bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../config/config.dart';
import '../screen/schedule_screen/bloc/bloc_analytics/analytics_toggle_bloc.dart';

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

  static String? textError(String value, String hint, int number) {
    if (value.isEmpty) {
      return 'Please enter the $hint';
    } else if (value.contains(',') ||
        value.contains(' ') ||
        value.contains('-') ||
        value.contains('.')) {
      return 'Please enter the number';
    } else if (int.parse(value) < number) {
      return 'Please enter the $hint bigger than $number';
    } else {
      return null;
    }
  }

  static String formatTime(int duration) {
    Duration value = Duration(seconds: duration);

    final hours = value.inHours.remainder(24).toString().padLeft(2, '0');

    final minutes = value.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = value.inSeconds.remainder(60).toString().padLeft(2, '0');

    if (value.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
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
          AppAnother.chestExercise, exercise.split(','));
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

  static void nextCountSate(AnalyticsToggleState state, BuildContext context,
      PageController controller) {
    List<String> exerciseMethod = [];
    for (int i = 0; i < value(state, state.count).split(';').length - 1; i++) {
      exerciseMethod.add(value(state, state.count).split(';')[i].split(':')[0]);
    }

    if (state.countMethod ==
        (exerciseMethod[exerciseMethod.length - 1].contains('.')
            ? exerciseMethod[exerciseMethod.length - 1].split('.')[0]
            : exerciseMethod[exerciseMethod.length - 1])) {
      if (state.count == AppString.sun) {
        context.read<AnalyticsToggleBloc>().add(SubmitWorkoutSchedule());
      } else {
        context.read<AnalyticsToggleBloc>().add(ResetMuscleGroup());

        controller
            .animateToPage(1,
                duration: const Duration(microseconds: 1), curve: Curves.linear)
            .then((value) {
          context.read<AnalyticsToggleBloc>().add(UpdateCount(state.count));
          if (state.caridoMethod != '') {
            context.read<AnalyticsToggleBloc>().add(ResetDataCardio());
          }
        });
      }
    } else {
      String nextMethod = exerciseMethod[exerciseMethod.indexWhere(
            (element) =>
                (element.contains('.') ? element.split('.')[0] : element) ==
                state.countMethod,
          ) +
          1];
      context.read<AnalyticsToggleBloc>().add(ResetMuscleGroup());

      if (nextMethod == AppString.yoga) {
        controller
            .animateToPage(3,
                duration: const Duration(milliseconds: 1), curve: Curves.linear)
            .then((value) => context
                .read<AnalyticsToggleBloc>()
                .add(UpdateCountMethod(nextMethod)));
      } else if (nextMethod == AppString.calisthenics) {
        controller
            .animateToPage(4,
                duration: const Duration(milliseconds: 1), curve: Curves.linear)
            .then((value) => context
                .read<AnalyticsToggleBloc>()
                .add(UpdateCountMethod(nextMethod)));
      } else if (nextMethod == AppString.inTheGym) {
        controller
            .animateToPage(2,
                duration: const Duration(milliseconds: 1), curve: Curves.linear)
            .then((value) => context
                .read<AnalyticsToggleBloc>()
                .add(UpdateCountMethod(nextMethod)));
      } else {
        controller
            .animateToPage(5,
                duration: const Duration(milliseconds: 1), curve: Curves.linear)
            .then((value) => context
                .read<AnalyticsToggleBloc>()
                .add(UpdateCountMethod(nextMethod)));
      }
    }
  }

  static bool checkMethod(
      AnalyticsToggleState state, String exerciseMethod, String day) {
    switch (day) {
      case AppString.mon:
        return state.mon.contains(exerciseMethod);
      case AppString.tue:
        return state.tue.contains(exerciseMethod);
      case AppString.wed:
        return state.wed.contains(exerciseMethod);
      case AppString.thu:
        return state.thu.contains(exerciseMethod);
      case AppString.fri:
        return state.fri.contains(exerciseMethod);
      case AppString.sat:
        return state.sat.contains(exerciseMethod);
      default:
        return state.sun.contains(exerciseMethod);
    }
  }

  static bool checkEmpty(
    AnalyticsToggleState state,
  ) {
    switch (state.count) {
      case AppString.mon:
        return state.mon.isNotEmpty;
      case AppString.tue:
        return state.tue.isNotEmpty;
      case AppString.wed:
        return state.wed.isNotEmpty;
      case AppString.thu:
        return state.thu.isNotEmpty;
      case AppString.fri:
        return state.fri.isNotEmpty;
      case AppString.sat:
        return state.sat.isNotEmpty;
      default:
        return state.sun.isNotEmpty;
    }
  }

  static int indexItem(
      String day, String countMethod, int index, int indexExercise) {
    int indexItem = -1;
    for (int i = 0; i < day.split(';').length - 1; i++) {
      if ((day.split(';')[i].split(':')[0].contains('.')
              ? day.split(';')[i].split(':')[0].split('.')[0]
              : day.split(';')[i].split(':')[0]) ==
          countMethod) {
        indexItem = day.split(';')[i].split(':')[1].split(',').indexWhere(
              (element) =>
                  element ==
                  AppAnother
                      .exercise[AppAnother.muscleGroup[index]]![indexExercise],
            );
      }
    }
    return indexItem;
  }

  static int getIndex(
      AnalyticsToggleState state, int index, int indexExercise) {
    switch (state.count) {
      case AppString.mon:
        return indexItem(state.mon, state.countMethod, index, indexExercise);

      case AppString.tue:
        return indexItem(state.tue, state.countMethod, index, indexExercise);
      case AppString.wed:
        return indexItem(state.wed, state.countMethod, index, indexExercise);
      case AppString.thu:
        return indexItem(state.thu, state.countMethod, index, indexExercise);
      case AppString.fri:
        return indexItem(state.fri, state.countMethod, index, indexExercise);
      case AppString.sat:
        return indexItem(state.sat, state.countMethod, index, indexExercise);
      default:
        return indexItem(state.sun, state.countMethod, index, indexExercise);
    }
  }

  static void addOrRemoveExerciseItem(
      String value,
      String day,
      BuildContext context,
      int index,
      int indexExercise,
      String exerciseMethod) {
    for (int i = 0; i < value.split(';').length - 1; i++) {
      if ((value.split(';')[i].split(':')[0].contains('.')
              ? value.split(';')[i].split(':')[0].split('.')[0]
              : value.split(';')[i].split(':')[0]) ==
          exerciseMethod) {
        if (value.split(';')[i].contains(AppAnother
            .exercise[AppAnother.muscleGroup[index]]![indexExercise])) {
          BlocProvider.of<AnalyticsToggleBloc>(context).add(UnChooseExercise(
            AppAnother.exercise[AppAnother.muscleGroup[index]]![indexExercise],
          ));
        } else {
          BlocProvider.of<AnalyticsToggleBloc>(context).add(ChooseExercise(
            AppAnother.exercise[AppAnother.muscleGroup[index]]![indexExercise],
          ));
        }
      }
    }
  }

  static void addOrRemoveExercise(AnalyticsToggleState state, int index,
      int indexExercise, BuildContext context) {
    switch (state.count) {
      case AppString.mon:
        addOrRemoveExerciseItem(state.mon, AppString.mon, context, index,
            indexExercise, state.countMethod);

      case AppString.tue:
        addOrRemoveExerciseItem(state.tue, AppString.tue, context, index,
            indexExercise, state.countMethod);
      case AppString.wed:
        addOrRemoveExerciseItem(state.wed, AppString.wed, context, index,
            indexExercise, state.countMethod);
      case AppString.thu:
        addOrRemoveExerciseItem(state.thu, AppString.thu, context, index,
            indexExercise, state.countMethod);
      case AppString.fri:
        addOrRemoveExerciseItem(state.fri, AppString.fri, context, index,
            indexExercise, state.countMethod);
      case AppString.sat:
        addOrRemoveExerciseItem(state.sat, AppString.sat, context, index,
            indexExercise, state.countMethod);
      default:
        addOrRemoveExerciseItem(state.sun, AppString.sun, context, index,
            indexExercise, state.countMethod);
    }
  }

  static void nextAddExerciseItem(String value, BuildContext context) {
    List<String> exerciseMethod = [];
    for (int i = 0; i < value.split(';').length - 1; i++) {
      exerciseMethod.add(value.split(';')[i].split(':')[0]);
    }
    context
        .read<AnalyticsToggleBloc>()
        .add(UpdateCountMethod(exerciseMethod[0]));
  }

  static int getIndexExerciseMethod(AnalyticsToggleState state) {
    int index = 0;
    for (int i = 0; i < value(state, state.count).split(';').length - 1; i++) {
      if ((value(state, state.count).split(';')[i].split(':')[0].contains('.')
              ? value(state, state.count)
                  .split(';')[i]
                  .split(':')[0]
                  .split('.')[0]
              : value(state, state.count).split(';')[i].split(':')[0]) ==
          state.countMethod) {
        index = i;
      }
    }
    return index;
  }

  static void nextAddExercise(
      AnalyticsToggleState state, BuildContext context) {
    switch (state.count) {
      case AppString.mon:
        nextAddExerciseItem(state.mon, context);

      case AppString.tue:
        nextAddExerciseItem(state.tue, context);

      case AppString.wed:
        nextAddExerciseItem(state.wed, context);
      case AppString.thu:
        nextAddExerciseItem(state.thu, context);

      case AppString.fri:
        nextAddExerciseItem(state.fri, context);
      case AppString.sat:
        nextAddExerciseItem(state.sat, context);

      default:
        nextAddExerciseItem(state.sun, context);
    }
  }

  static String value(AnalyticsToggleState state, String day) {
    switch (day) {
      case AppString.mon:
        return state.mon;
      case AppString.tue:
        return state.tue;
      case AppString.wed:
        return state.wed;
      case AppString.thu:
        return state.thu;
      case AppString.sat:
        return state.sat;
      case AppString.fri:
        return state.fri;
      default:
        return state.sun;
    }
  }

  static String exerciseResult(AnalyticsToggleState state, String exercise) {
    String result = '';
    for (int i = 0; i < value(state, state.count).split(';').length - 1; i++) {
      if ((value(state, state.count).split(';')[i].split(':')[0].contains('.')
              ? value(state, state.count)
                  .split(';')[i]
                  .split(':')[0]
                  .split('.')[0]
              : value(state, state.count).split(';')[i].split(':')[0]) ==
          state.countMethod) {
        if (state.hiitMethod == 'group') {
          for (int j = 0;
              j <
                  value(state, state.count)
                      .split(';')[i]
                      .split(':')[1]
                      .split('.')
                      .length;
              j++) {
            if (j == state.countLevel) {
              if (j == int.parse(state.level) - 1) {
                result =
                    '$result${value(state, state.count).split(';')[i].split(':')[1].split('.')[j]}$exercise,';
              } else {
                result =
                    '$result${value(state, state.count).split(';')[i].split(':')[1].split('.')[j]}$exercise,.';
              }
            } else {
              if (j == int.parse(state.level) - 1) {
                result =
                    '$result${value(state, state.count).split(';')[i].split(':')[1].split('.')[j]}';
              } else {
                result =
                    '$result${value(state, state.count).split(';')[i].split(':')[1].split('.')[j]}.';
              }
            }
          }
          result =
              '${value(state, state.count).split(';')[i].split(':')[0]}:$result;';
        } else {
          result =
              '$result${value(state, state.count).split(';')[i]}$exercise,;';
        }
      } else {
        result = '$result${value(state, state.count).split(';')[i]};';
      }
      print(result);
    }
    return result;
  }

  static String removeExercise(AnalyticsToggleState state, String exercise) {
    String result = '';
    for (int i = 0; i < value(state, state.count).split(';').length - 1; i++) {
      if ((value(state, state.count).split(';')[i].split(':')[0].contains('.')
              ? value(state, state.count)
                  .split(';')[i]
                  .split(':')[0]
                  .split('.')[0]
              : value(state, state.count).split(';')[i].split(':')[0]) ==
          state.countMethod) {
        if (state.hiitMethod == 'group') {
          result =
              '$result${value(state, state.count).split(';')[i].split('.')[state.countLevel].replaceAll('$exercise,', '')};';
        } else {
          result =
              '$result${value(state, state.count).split(';')[i].replaceAll('$exercise,', '')};';
        }
      } else {
        result = '$result${value(state, state.count).split(';')[i]};';
      }
    }
    return result;
  }

  static String updateExercise(AnalyticsToggleState state) {
    String result = '';
    for (int i = 0;
        i < MethodReused.value(state, state.count).split(';').length - 1;
        i++) {
      if ((value(state, state.count).split(';')[i].split(':')[0].contains('.')
              ? value(state, state.count)
                  .split(';')[i]
                  .split(':')[0]
                  .split('.')[0]
              : value(state, state.count).split(';')[i].split(':')[0]) ==
          state.countMethod) {
        result =
            '$result${MethodReused.value(state, state.count).split(';')[i].split(':')[0]}:';

        for (int j = 0; j < int.parse(state.level) - 1; j++) {
          if (int.parse(state.level) - 2 == j) {
            result = '$result.;';
          } else {
            result = '$result.';
          }
        }
      } else {
        result =
            '$result${MethodReused.value(state, state.count).split(';')[i]};';
      }
    }

    return result;
  }
}
