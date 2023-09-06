import 'package:fitness_app_bloc/respository/repository.dart';

class AppRepository {
  AppRepository._();
  static final dbHistoryRepository = DbHistoryRepository();
  static final dbInformationRespository = DbInformationRespository();
}
