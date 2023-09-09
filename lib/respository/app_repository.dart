import 'package:fitness_app_bloc/respository/repository.dart';

class AppRepository {
  AppRepository._();
  static final dbInformationRepository = DbInformationRespository();
  static final dbHistoryRespository = DbHistoryRepository();
  static final dbRecipesRespository = DbRecipesRepository();
  static final dbMealsRepository = DbMealsRepository();
}
