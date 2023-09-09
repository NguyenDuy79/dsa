import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fitness_app_bloc/config/app_another.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/db/database_recipes.dart';
import 'package:formz/formz.dart';
import '../../../db/database_helper.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  var isMetric = true;
  int? inch;
  int? feet;
  int? gender;
  int? activity;
  int? target;
  String? age;
  var pageView = 0;
  bool submited = false;
  bool isValid = false;
  String heightError = 'Please enter height';
  String weightError = 'Please enter weight';
  String ageError = 'Please enter ange';
  String bodyFatError = 'Please enter body fat';

  HomePageBloc() : super(HomePageInitial()) {
    on<SetGender>(_getGender);

    on<UntiChange>(_changeUnti);
    on<SetSplash>(_splash);
    on<PageViewChange>(_getPageViewChange);
    on<SetInch>(_setInch);
    on<SetFeet>(_setFeet);
    on<SetTarget>(_setTarget);
    on<SetActivity>(_setActivity);
    on<OnChangeAge>(_getChangeAge);
    on<OnChangeBodyFat>(_getChangeBodyFat);
    on<OnChangeHeight>(_getChangeHeight);
    on<OnChangeWeight>(_getChangeWeight);
    on<Submit>(_enterInformation);
    on<AddSubmit>(_addInformation);
  }

  void _getGender(HomePageEvent event, Emitter<HomePageState> emit) {
    if (event is SetGender) {
      gender = event.value;
      if (event.value == 1) {
        emit(state.copyWith(gender: AppString.male));
      } else {
        emit(state.copyWith(gender: AppString.female));
      }
    }
  }

  void _getPageViewChange(HomePageEvent event, Emitter<HomePageState> emit) {
    if (event is PageViewChange) {
      pageView += 1;
      emit(PageViewChangeState());
    }
  }

  void _changeUnti(HomePageEvent event, Emitter<HomePageState> emit) {
    if (event is UntiChange) {
      isMetric = event.isMetric;
      if (isMetric) {
        feet = null;
        inch = null;
        emit(state.copyWith(feet: 0, inch: 0));
      } else {
        emit(state.copyWith(height: 0));
      }
      emit(MetricChange());
    }
  }

  void _splash(HomePageEvent event, Emitter<HomePageState> emit) async {
    if (event is SetSplash) {
      emit(SplashLoading());
      await Future.delayed(const Duration(seconds: 2));
      emit(SplashLoaded());
    }
  }

  void _setInch(HomePageEvent event, Emitter<HomePageState> emit) {
    if (event is SetInch) {
      inch = event.value;
      emit(state.copyWith(inch: AppAnother.listInch[event.value]));
    }
  }

  void _setTarget(SetTarget event, Emitter<HomePageState> emit) {
    target = event.value;
    emit(state.copyWith(
        target: AppAnother.listTarget[event.value][AppString.target]));
  }

  void _setFeet(HomePageEvent event, Emitter<HomePageState> emit) {
    if (event is SetFeet) {
      feet = event.value;

      emit(state.copyWith(feet: AppAnother.listFeet[event.value]));
    }
  }

  void _setActivity(HomePageEvent event, Emitter<HomePageState> emit) {
    if (event is SetActivity) {
      activity = event.value;
      emit(state.copyWith(
          activity: AppAnother.listAcctivity[event.value][AppString.activity]));
    }
  }

  void _getChangeAge(OnChangeAge event, Emitter<HomePageState> emit) {
    if (event.value.isEmpty) {
      ageError = 'Please enter age';
      emit(state.copyWith());
    } else {
      ageError = '';
      age = event.value;
      emit(state.copyWith(age: event.value));
    }
  }

  void _getChangeBodyFat(OnChangeBodyFat event, Emitter<HomePageState> emit) {
    if (event.value.isEmpty) {
      bodyFatError = 'Please enter body fat';
      emit(state.copyWith());
    } else if (event.value.contains(',') ||
        event.value.contains(' ') ||
        event.value.contains('-') ||
        event.value.contains('.')) {
      bodyFatError = 'Please enter a positive integer';
      emit(state.copyWith());
    } else {
      if (double.parse(event.value) <= 0 || double.parse(event.value) > 100) {
        bodyFatError = 'Please enter corect body fat';
        emit(state.copyWith(bodyFat: int.parse(event.value)));
      } else {
        bodyFatError = '';
        emit(state.copyWith(bodyFat: int.parse(event.value)));
      }
    }
  }

  void _getChangeHeight(OnChangeHeight event, Emitter<HomePageState> emit) {
    if (event.value.isEmpty) {
      heightError = 'Please enter height';
      emit(state.copyWith());
    } else if (event.value.contains(',') ||
        event.value.contains(' ') ||
        event.value.contains('-') ||
        event.value.contains('.')) {
      heightError = 'Please enter a positive integer';
      emit(state.copyWith());
    } else if (int.parse(event.value) <= 50 || int.parse(event.value) > 272) {
      heightError = 'Please enter corect height';
      emit(state.copyWith(height: int.parse(event.value)));
    } else {
      heightError = '';
      emit(state.copyWith(height: int.parse(event.value)));
    }
  }

  void _getChangeWeight(OnChangeWeight event, Emitter<HomePageState> emit) {
    if (event.value.isEmpty) {
      weightError = 'Please enter weight';
      emit(state.copyWith());
    } else if (event.value.contains(',') ||
        event.value.contains(' ') ||
        event.value.contains('-') ||
        event.value.contains('.')) {
      weightError = 'Please enter a positive interger';
      emit(state.copyWith());
    } else {
      if (int.parse(event.value) <= 5) {
        weightError = 'Please enter corect weight';
        emit(state.copyWith(weight: int.parse(event.value)));
      } else {
        weightError = '';
        emit(state.copyWith(weight: int.parse(event.value)));
      }
    }
  }

  Future<void> _enterInformation(
      Submit event, Emitter<HomePageState> emit) async {
    emit(state.copyWith());
    submited = true;

    if (isMetric) {
      if (gender != null &&
          activity != null &&
          weightError.isEmpty &&
          heightError.isEmpty &&
          target != null &&
          ageError.isEmpty &&
          bodyFatError.isEmpty) {
        isValid = true;
      } else {
        isValid = false;
      }
    } else {
      if (inch != null &&
          feet != null &&
          gender != null &&
          activity != null &&
          target != null &&
          weightError.isEmpty &&
          ageError.isEmpty &&
          bodyFatError.isEmpty) {
        isValid = true;
      } else {
        isValid = false;
      }
    }

    if (isValid) {
      DateTime dateTime = DateTime.now();
      emit(state.copyWith(
          status: FormzSubmissionStatus.inProgress,
          dateTime: dateTime.toString()));

      try {
        await DbHelper().insert(AppString.informationTable, {
          AppString.dateTime: state.dateTime,
          AppString.gender: state.gender,
          AppString.age: state.age,
          AppString.target: state.target,
          AppString.height: isMetric
              ? state.height.toString()
              : (state.feet * 30.48 + state.inch * 2.54).toString(),
          AppString.weight: isMetric
              ? state.weight.toString()
              : (state.weight * 0.45359237).toString(),
          AppString.activity: state.activity,
          AppString.bodyFat: state.bodyFat,
        });
        double calories = AppAnother.getCalories(state, isMetric);

        await DbRecipes().insert(AppString.recipesTable, {
          AppString.calories: calories.toInt().toString(),
          AppString.protein: '0',
          AppString.fats: '0',
          AppString.carbs: '0'
        });

        emit(state.copyWith(status: FormzSubmissionStatus.success));
        log('Done');
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
        log('Feild');
      }
    }
  }

  Future<void> _addInformation(
      AddSubmit event, Emitter<HomePageState> emit) async {
    var listInfo = await DbHelper().getData(AppString.informationTable);

    emit(state.copyWith(
        age: listInfo.first[AppString.age].toString(),
        gender: listInfo.first[AppString.gender].toString()));
    submited = true;

    if (isMetric) {
      if (activity != null &&
          weightError.isEmpty &&
          heightError.isEmpty &&
          target != null &&
          bodyFatError.isEmpty) {
        isValid = true;
      } else {
        isValid = false;
      }
    } else {
      if (inch != null &&
          feet != null &&
          activity != null &&
          target != null &&
          weightError.isEmpty &&
          bodyFatError.isEmpty) {
        isValid = true;
      } else {
        isValid = false;
      }
    }

    if (isValid) {
      DateTime dateTime = DateTime.now();
      emit(state.copyWith(
          status: FormzSubmissionStatus.inProgress,
          dateTime: dateTime.toString()));

      try {
        await DbHelper().insert(AppString.informationTable, {
          AppString.dateTime: state.dateTime,
          AppString.gender: state.gender,
          AppString.age: state.age,
          AppString.target: state.target,
          AppString.height: isMetric
              ? state.height
              : (state.feet * 30.48 + state.inch * 2.54).toInt(),
          AppString.weight: isMetric ? state.weight : state.weight * 0.45359237,
          AppString.activity: state.activity,
          AppString.bodyFat: state.bodyFat,
        });
        double calories = AppAnother.getCalories(state, isMetric);

        await DbRecipes().insert(AppString.recipesTable, {
          AppString.calories: calories.toInt().toString(),
          AppString.protein: '0',
          AppString.fats: '0',
          AppString.carbs: '0'
        });

        emit(state.copyWith(status: FormzSubmissionStatus.success));

        log('Done');
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
        log('Feild');
      }
    }
  }
}
