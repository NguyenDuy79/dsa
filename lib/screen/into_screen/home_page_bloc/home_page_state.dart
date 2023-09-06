part of 'home_page_bloc.dart';

class HomePageState {
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
      this.weight = 0});

  final FormzSubmissionStatus status;
  final String dateTime;
  final String gender;
  final String age;
  final int height;
  final int weight;
  final String activity;
  final int bodyFat;
  final String target;

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
    int? inch,
    int? weight,
  }) {
    return HomePageState(
        status: status ?? this.status,
        activity: activity ?? this.activity,
        bodyFat: bodyFat ?? this.bodyFat,
        age: age ?? this.age,
        feet: feet ?? this.feet,
        inch: inch ?? this.inch,
        gender: gender ?? this.gender,
        dateTime: dateTime ?? this.dateTime,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        target: target ?? this.target);
  }
}

class HomePageInitial extends HomePageState {}

class TabIndex extends HomePageState {
  TabIndex();
}

class MetricChange extends HomePageState {
  MetricChange();
}

// class GetFeet extends HomePageState {}

// class GetInch extends HomePageState {}

class PageViewChangeState extends HomePageState {}

class SplashLoading extends HomePageState {}

class SplashLoaded extends HomePageState {}

// class Gender extends HomePageState {}

// class GetActivity extends HomePageState {}

// class TextChange extends HomePageState {}

// class Submitted extends HomePageState {
//   final FormzSubmissionStatus status;
//   final String dateTime;
//   final int age;
//   final double height;
//   final double weight;
//   final String activity;
//   final int bodyFat;
//   final bool isValid;
//   const Submitted(
//       {this.status = FormzSubmissionStatus.initial,
//       this.age = 0,
//       this.activity = '',
//       this.bodyFat = 0,
//       this.dateTime = '',
//       this.height = 0,
//       this.isValid = false,
//       this.weight = 0});
//   Submitted copyWith(
//       {FormzSubmissionStatus? status,
//       String? dateTime,
//       String? activity,
//       int? age,
//       int? bodyFat,
//       double? height,
//       double? weight,
//       bool? isValid}) {
//     return Submitted(
//         status: status ?? this.status,
//         activity: activity ?? this.activity,
//         bodyFat: bodyFat ?? this.bodyFat,
//         age: age ?? this.age,
//         dateTime: dateTime ?? this.dateTime,
//         height: height ?? this.height,
//         isValid: isValid ?? this.isValid,
//         weight: weight ?? this.weight);
//   }

