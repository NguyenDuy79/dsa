import 'package:fitness_app_bloc/common_bloc/bloc_activity/activity_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_anlytics/analytics_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_application/application_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_history/history_bloc.dart';

import 'package:fitness_app_bloc/common_bloc/bloc_recipes/recipes_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_water/water_bloc.dart';

import 'package:fitness_app_bloc/respository/app_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CommonBloc {
  CommonBloc._();
  static final activityBloc =
      ActivityBloc(dbRespository: AppRepository.dbInformationRepository);
  static final historyBloc =
      HistoryBloc(dbHistoryRepository: AppRepository.dbHistoryRespository);
  static final recipesBloc = RecipesBloc(
      recipesRepository: AppRepository.dbRecipesRespository,
      recipesPerdayRepository: AppRepository.dbRecipesPerdayRepository);
  static final applicationBloc = ApplicationBloc();
  static final analyticsBloc =
      AnalyticsBloc(dbAnalyticsRepository: AppRepository.dbAnalyticsRepository);
  static final waterBloc = WaterBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<ActivityBloc>(create: (context) => activityBloc),
    BlocProvider<HistoryBloc>(
      create: (context) => historyBloc,
    ),
    BlocProvider<RecipesBloc>(
      create: (context) => recipesBloc,
    ),
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<AnalyticsBloc>(
      create: (context) => analyticsBloc,
    ),
    BlocProvider<WaterBloc>(
      create: (context) => waterBloc,
    )
  ];

  static void dispose() {
    activityBloc.close();
    historyBloc.close();
    recipesBloc.close();
    applicationBloc.close();
    waterBloc.close();
  }
}
