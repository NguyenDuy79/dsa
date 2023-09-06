import 'package:fitness_app_bloc/data/local/prefs.dart';
import 'package:fitness_app_bloc/screen/into_screen/home_page_bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';

import '../data/model/chart.dart';
import '../screen/home_screen/tabs/screen/activity_screen.dart';
import '../screen/home_screen/tabs/screen/analytics_screen.dart';
import '../screen/home_screen/tabs/screen/recipes_screen.dart';
import '../screen/home_screen/tabs/screen/setting_screen.dart';
import 'app_string.dart';

class AppAnother {
  AppAnother._();
  static const List<int> listInch = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  static const List<int> listFeet = [3, 4, 5, 6, 7, 8];
  static const List<Map<String, dynamic>> listTarget = [
    {'Value': 1, AppString.target: AppString.maintenance},
    {'Value': 2, AppString.target: AppString.cutting},
    {'Value': 3, AppString.target: AppString.bulking}
  ];
  static const List<Map<String, dynamic>> listAcctivity = [
    {'Value': 1, AppString.activity: AppString.activity1},
    {'Value': 2, AppString.activity: AppString.activity2},
    {'Value': 3, AppString.activity: AppString.activity3},
    {'Value': 4, AppString.activity: AppString.activity4},
    {'Value': 5, AppString.activity: AppString.activity5}
  ];

  static const List<String> muscleGroup = [
    AppString.chest,
    AppString.back,
    AppString.shoulder,
    AppString.arm,
    AppString.legAndGlutes,
  ];
  static const List<String> chestExcercise = [
    AppString.inclineBenchPress,
    AppString.benchPress,
    AppString.dips
  ];
  static const Map<String, List<String>> exercise = {
    AppString.chest: chestExcercise,
    AppString.back: backExercise,
    AppString.legAndGlutes: legAndGlutesExercise,
    AppString.shoulder: shoulderExercise,
    AppString.arm: armExercise
  };
  static const List<String> backExercise = [
    AppString.chinUps,
    AppString.pullUp,
    AppString.chestSupportedRowing,
    AppString.bentOverBarbellRowing,
    AppString.tbarRow
  ];
  static const List<String> shoulderExercise = [
    AppString.barbellShoulderPress,
    AppString.dumbbellShoulderPress,
    AppString.fontRaise,
    AppString.lateralRaise,
    AppString.cableUprightRow,
    AppString.frontCableRaise
  ];
  static const List<String> armExercise = [
    AppString.closeGripBenchPress,
    AppString.closeGripDeclinePress,
    AppString.standingBarbellCurl,
    AppString.preacherCurl
  ];

  static const List<String> legAndGlutesExercise = [
    AppString.lowbarSquat,
    AppString.heightbarSquat,
    AppString.frontSquat,
    AppString.deadlift,
    AppString.romanianDeadlift,
    AppString.sumoDeadlift,
    AppString.stiffLegDeadlift
  ];
  static const List<String> exerciseMethod = [
    AppString.yoga,
    AppString.inTheGym,
    AppString.calisthenics,
    AppString.cardio,
  ];

  static TextStyle textStyleDefault(
      double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static List<BottomNavigationBarItem> bottomNavItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Activity'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.analytics,
        ),
        label: 'Analytics'),
    BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Recipes'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
  ];
  static const List<Widget> bottomNavScreen = <Widget>[
    ActivityScreen(),
    AnalyticsScreen(),
    RecipesScreen(),
    SettingScreen()
  ];

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
}
