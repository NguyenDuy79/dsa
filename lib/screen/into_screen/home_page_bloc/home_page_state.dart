part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  const HomePageState(
      {this.status = FormzSubmissionStatus.initial,
      this.age = '',
      this.activity = '',
      this.target = '',
      this.bodyFat = 0,
      this.gender = '',
      this.dateTime = '',
      this.height = 0,
      this.feet = 0,
      this.inch = 0,
      this.weight = 0,
      this.isMetric = true,
      this.temporary = '',
      this.index = 0});

  final FormzSubmissionStatus status;
  final String dateTime;
  final String gender;
  final String age;
  final int height;
  final int weight;
  final String activity;
  final int bodyFat;
  final bool isMetric;
  final String target;
  final int index;
  final String temporary;

  final int feet;
  final int inch;
  HomePageState copyWith({
    FormzSubmissionStatus? status,
    String? dateTime,
    String? activity,
    String? gender,
    String? target,
    String? age,
    int? bodyFat,
    int? height,
    int? feet,
    bool? isMetric,
    int? inch,
    String? temporary,
    int? index,
    int? weight,
  }) {
    return HomePageState(
        status: status ?? this.status,
        activity: activity ?? this.activity,
        bodyFat: bodyFat ?? this.bodyFat,
        age: age ?? this.age,
        feet: feet ?? this.feet,
        index: index ?? this.index,
        temporary: temporary ?? this.temporary,
        inch: inch ?? this.inch,
        gender: gender ?? this.gender,
        dateTime: dateTime ?? this.dateTime,
        height: height ?? this.height,
        isMetric: isMetric ?? this.isMetric,
        weight: weight ?? this.weight,
        target: target ?? this.target);
  }

  @override
  List<Object?> get props => [
        status,
        dateTime,
        activity,
        gender,
        target,
        age,
        bodyFat,
        height,
        feet,
        inch,
        index,
        weight,
        isMetric,
        temporary,
      ];
}

class HomePageInitial extends HomePageState {}

class PageViewChangeState extends HomePageState {}

class SplashLoading extends HomePageState {}

class SplashLoaded extends HomePageState {}
