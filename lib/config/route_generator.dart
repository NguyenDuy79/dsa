import 'package:fitness_app_bloc/screen/action_screen/screen/action_screen.dart';
import 'package:fitness_app_bloc/common_app/ticker.dart';
import 'package:fitness_app_bloc/screen/infomation_screen/screen/add_information.dart';
import 'package:fitness_app_bloc/screen/meals_screen.dart/screen/add_meals_screen.dart';
import 'package:fitness_app_bloc/screen/history_screen/screen/detail_history.dart';
import 'package:fitness_app_bloc/screen/history_screen/screen/history_screen.dart';
import 'package:fitness_app_bloc/screen/history_screen/screen/history_today_screen.dart';
import 'package:fitness_app_bloc/screen/infomation_screen/screen/information_screen.dart';
import 'package:fitness_app_bloc/screen/setup_screen/screen/setup_exercise_screen.dart';
import 'package:fitness_app_bloc/screen/schedule_screen/screen/workout_schedule_detail.dart';
import 'package:fitness_app_bloc/screen/splash_screen.dart';
import 'package:fitness_app_bloc/screen/home_screen/screen/home_screen.dart';
import 'package:fitness_app_bloc/screen/into_screen/enter_information.dart';
import 'package:fitness_app_bloc/screen/into_screen/into_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../common_bloc/bloc_index/index_common_bloc.dart';
import '../reused/reused.dart';
import '../screen/action_screen/bloc/timer_bloc/timer_bloc.dart';
import '../screen/action_screen/bloc/visibility_bloc/visibility_bloc.dart';
import '../screen/history_screen/bloc/filter_bloc/filter_bloc.dart';
import '../screen/home_screen/bloc/bloc_home_index/home_index_bloc.dart';
import '../screen/meals_screen.dart/bloc/bloc_add_meals/add_meals_bloc.dart';
import '../screen/schedule_screen/bloc/bloc_analytics/analytics_toggle_bloc.dart';
import '../screen/schedule_screen/screen/add_workout_schedule.dart';
import '../screen/infomation_screen/screen/detail_information_screen.dart';
import '../screen/into_screen/home_page_bloc/home_page_bloc.dart';
import '../screen/setup_screen/bloc/action_bloc/action_bloc.dart';

class RouteGenerator {
  RouteGenerator._();
  static const homePage = '/homepage';
  static const splashScreen = '/';
  static const intoScreen = '/into-screen';
  static const enterInformation = '/enter-information';
  static const setupExerciseScreen = '/setup-exercise';
  static const actionScreen = '/action-screen';
  static const informationScreen = '/information-screen';
  static const addInformationScreen = '/add-information-screen';
  static const detailInformation = '/detail-information';
  static const historyScreen = '/history-screen';
  static const historyTodayScreen = '/history-today-screen';
  static const detailHistoryScreen = '/detail-history-screen';
  static const addMealsScreen = '/add-meals-screen';
  static const addWorkoutShedule = '/add-workout-shedule-screen';
  static const workoutScheduleDetail = '/workout-schedule-detail-screen';
  static const supersetDropsetScreen = '/super-drop-screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => HomePageBloc(), child: const SplashScreen()),
        );
      case intoScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => HomePageBloc(),
                child: const IntoScreen()));

      case enterInformation:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                providers: [BlocProvider(create: (context) => HomePageBloc())],
                child: const EnterInfomation()));
      case homePage:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => HomeIndexBloc(),
            ),
            BlocProvider<IndexCommonBloc>(
                create: (context) => IndexCommonBloc()
                  ..add(ScrollPageView(
                      MethodReused.getWeek(DateTime.now()).indexWhere(
                    (element) =>
                        DateFormat('E').format(DateTime.now()) ==
                        DateFormat('E').format(element),
                  )))),
            BlocProvider(create: (context) => HomePageBloc())
          ], child: const HomeScreen()),
        );
      case setupExerciseScreen:
        var args = settings.arguments as Map<String, Object?>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ActionBloc(),
                  child: SetupExerciseScreen(args),
                ));
      case actionScreen:
        var args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => TimerBloc(ticker: const Ticker()),
              ),
              BlocProvider(
                create: (context) => VisibilityBloc(),
              ),
              BlocProvider(
                create: (context) => HomePageBloc(),
              )
            ],
            child: ActionScreen(
                args['method'],
                args['exercise'],
                args['muscle group'],
                args['rest time'],
                args['set'],
                args['cardioMethod'],
                args['hiitMethod'],
                args['time']),
          ),
        );
      case informationScreen:
        return MaterialPageRoute(
          builder: (context) => const InfomationScreen(),
        );
      case addInformationScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => HomePageBloc(),
            ),
          ], child: const AddInformationScreen()),
        );
      case detailInformation:
        var args = settings.arguments as Map<String, Object?>;
        return MaterialPageRoute(
          builder: (context) => DetailInformationScreen(args),
        );
      case historyScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => FilterBloc(),
            child: const HistoryScreen(),
          ),
        );
      case historyTodayScreen:
        return MaterialPageRoute(
          builder: (context) => const HistoryTodayScreen(),
        );
      case detailHistoryScreen:
        var args = settings.arguments as Map<String, Object?>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomePageBloc(),
            child: DetailHistoryScreen(args),
          ),
        );
      case addMealsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AddMealsBloc(),
            child: const AddMealsScreen(),
          ),
        );
      case addWorkoutShedule:
        var args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AnalyticsToggleBloc(),
            child: AddWorkoutSheduleScreen(args),
          ),
        );
      case workoutScheduleDetail:
        var args = settings.arguments as Map<String, Object?>;
        return MaterialPageRoute(
          builder: (context) => WorkoutScheduleDetail(args),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
