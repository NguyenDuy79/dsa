part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class TabChange extends HomePageEvent {
  final int tabIndex;
  TabChange({required this.tabIndex});
}

class PageViewChange extends HomePageEvent {
  PageViewChange();
}

class UntiChange extends HomePageEvent {
  final bool isMetric;
  UntiChange({required this.isMetric});
}

class SetFeet extends HomePageEvent {
  final int value;
  SetFeet({required this.value});
}

class SetTarget extends HomePageEvent {
  final int value;
  SetTarget(this.value);
}

class SetInch extends HomePageEvent {
  final int value;
  SetInch({required this.value});
}

class SetSplash extends HomePageEvent {}

class SetGender extends HomePageEvent {
  final int value;
  SetGender({required this.value});
}

class SetActivity extends HomePageEvent {
  final int value;
  SetActivity({required this.value});
}

class Submit extends HomePageEvent {}

class AddSubmit extends HomePageEvent {}

class OnChangeAge extends HomePageEvent {
  final String value;
  OnChangeAge(this.value);
}

class OnChangeHeight extends HomePageEvent {
  final String value;
  OnChangeHeight(this.value);
}

class OnChangeWeight extends HomePageEvent {
  final String value;
  OnChangeWeight(this.value);
}

class OnChangeBodyFat extends HomePageEvent {
  final String value;
  OnChangeBodyFat(this.value);
}
