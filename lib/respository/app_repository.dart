import 'package:fitness_app_bloc/respository/db_analytics_repository.dart';
import 'package:fitness_app_bloc/respository/db_recipes_perday_repository.dart';
import 'package:fitness_app_bloc/respository/repository.dart';

class AppRepository {
  AppRepository._();
  static final dbInformationRepository = DbInformationRespository();
  static final dbHistoryRespository = DbHistoryRepository();
  static final dbRecipesRespository = DbRecipesRepository();
  static final dbMealsRepository = DbMealsRepository();
  static final dbAnalyticsRepository = DbAnalyticsRepository();
  static final dbRecipesPerdayRepository = DbRecipesPerdayRepository();
}
