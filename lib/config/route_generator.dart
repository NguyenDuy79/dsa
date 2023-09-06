import 'package:fitness_app_bloc/screen/home_screen/bloc/home_index_bloc.dart';
import 'package:fitness_app_bloc/screen/home_screen/page/action_screen.dart';

import 'package:fitness_app_bloc/common_app/ticker.dart';
import 'package:fitness_app_bloc/screen/home_screen/page/add_information.dart';
import 'package:fitness_app_bloc/screen/home_screen/page/detail_history.dart';
import 'package:fitness_app_bloc/screen/home_screen/page/detail_informatton_screen.dart';
import 'package:fitness_app_bloc/screen/home_screen/page/history_screen.dart';
import 'package:fitness_app_bloc/screen/home_screen/page/information_screen.dart';
import 'package:fitness_app_bloc/screen/home_screen/page/setup_exercise_screen.dart';
import 'package:fitness_app_bloc/screen/home_screen/tabs/bloc/bloc/recipes_toggle_bloc.dart';
import 'package:fitness_app_bloc/screen/splash_screen.dart';
import 'package:fitness_app_bloc/screen/home_screen/tabs/screen/home_screen.dart';
import 'package:fitness_app_bloc/screen/into_screen/enter_information.dart';
import 'package:fitness_app_bloc/screen/into_screen/into_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screen/home_screen/page/bloc/action_bloc/action_bloc.dart';
import '../screen/home_screen/page/bloc/filter_bloc/filter_bloc.dart';
import '../screen/home_screen/page/bloc/timer_bloc/timer_bloc.dart';
import '../screen/home_screen/page/bloc/visibility_bloc/visibility_bloc.dart';
import '../screen/into_screen/home_page_bloc/home_page_bloc.dart';

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
  static const detailHistoryScreen = '/detail-history-screen';

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
              create: (context) => RecipesToggleBloc(),
            ),
            BlocProvider(create: (context) => HomeIndexBloc()),
          ], child: const HomeScreen()),
        );
      case setupExerciseScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ActionBloc(),
                  child: SetupExerciseScreen(),
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
            ),
          ),
        );
      case informationScreen:
        return MaterialPageRoute(
          builder: (context) => const InfomationScreen(),
        );
      case addInformationScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => HomePageBloc(),
              child: const AddInformationScreen()),
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
      case detailHistoryScreen:
        var args = settings.arguments as Map<String, Object?>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomePageBloc(),
            child: DetailHistoryScreen(args),
          ),
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
