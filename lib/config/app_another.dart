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

  static TextStyle textStyleDefault(
      double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

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

  static const List<Map<String, dynamic>> listFood = [
    {
      AppString.name: AppString.rice,
      AppString.protein: 2.91,
      AppString.calories: 122.8,
      AppString.fats: 0.38,
      AppString.carbs: 26.9,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.beef,
      AppString.calories: 182.3,
      AppString.protein: 21.5,
      AppString.fats: 10.7,
      AppString.carbs: 0,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.pork,
      AppString.calories: 297,
      AppString.protein: 25.7,
      AppString.fats: 20.8,
      AppString.carbs: 0,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.chickenBreast,
      AppString.calories: 165,
      AppString.protein: 31,
      AppString.fats: 3.6,
      AppString.carbs: 0,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.chicken,
      AppString.calories: 209,
      AppString.protein: 26,
      AppString.fats: 11,
      AppString.carbs: 0,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.duckBreast,
      AppString.calories: 140,
      AppString.protein: 27.6,
      AppString.fats: 2.4,
      AppString.carbs: 0,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.duck,
      AppString.calories: 337,
      AppString.protein: 19,
      AppString.fats: 28.4,
      AppString.carbs: 0,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.chickenEgg,
      AppString.calories: 62.5,
      AppString.protein: 5.5,
      AppString.fats: 4.2,
      AppString.carbs: 0,
      AppString.unit: 1
    },
    {
      AppString.name: AppString.duckEgg,
      AppString.calories: 130,
      AppString.protein: 9,
      AppString.fats: 9.6,
      AppString.carbs: 1,
      AppString.unit: 1
    },
    {
      AppString.name: AppString.tuna,
      AppString.calories: 129,
      AppString.protein: 29,
      AppString.fats: 0.6,
      AppString.carbs: 0,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.bread,
      AppString.calories: 264,
      AppString.protein: 9,
      AppString.fats: 3.2,
      AppString.carbs: 49,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.sanwich,
      AppString.calories: 67,
      AppString.protein: 2,
      AppString.fats: 0.7,
      AppString.carbs: 13,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.tilapia,
      AppString.calories: 129,
      AppString.protein: 26,
      AppString.fats: 2.7,
      AppString.carbs: 0,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.salmon,
      AppString.calories: 208,
      AppString.protein: 22,
      AppString.fats: 12,
      AppString.carbs: 0,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.milk,
      AppString.calories: 42,
      AppString.protein: 3.4,
      AppString.fats: 1,
      AppString.carbs: 5,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.soymilk,
      AppString.calories: 54,
      AppString.protein: 3.3,
      AppString.fats: 1.8,
      AppString.carbs: 6,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.potato,
      AppString.calories: 89,
      AppString.protein: 1.9,
      AppString.fats: 0.1,
      AppString.carbs: 20.1,
      AppString.unit: 100,
    },
    {
      AppString.name: AppString.tomato,
      AppString.calories: 21,
      AppString.protein: 0.9,
      AppString.fats: 0.2,
      AppString.carbs: 3.9,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.sweetPotato,
      AppString.calories: 119,
      AppString.protein: 0.8,
      AppString.fats: 0.2,
      AppString.carbs: 28.5,
      AppString.unit: 100
    },
    {
      AppString.name: AppString.orange,
      AppString.calories: 52,
      AppString.protein: 0.6,
      AppString.fats: 0,
      AppString.carbs: 12.3,
      AppString.unit: 100
    }
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
}
