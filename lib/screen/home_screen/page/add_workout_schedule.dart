import 'package:fitness_app_bloc/common_app/common_widget.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_anlytics/analytics_bloc.dart';

import 'package:fitness_app_bloc/config/config.dart';
import 'package:fitness_app_bloc/reused/method_reused.dart';
import 'package:fitness_app_bloc/screen/home_screen/page/bloc/bloc_analytics/analytics_toggle_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

class AddWorkoutSheduleScreen extends StatelessWidget {
  const AddWorkoutSheduleScreen(this.day, {super.key});
  final String day;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.blackColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: AppDimens.dimens_0,
        backgroundColor: AppColor.whiteColor,
        automaticallyImplyLeading: false,
        title: Text('Add Workout Shedule',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor)),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          dayOff(day, controller),
          chooseMethod(controller),
          chooseExcercise(controller)
        ],
      ),
    );
  }
}

Widget dayOff(String day, PageController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
        child: Text(
          'Choose your day off:',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
        ),
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.dimens_50, vertical: AppDimens.dimens_10),
          child: BlocConsumer<AnalyticsToggleBloc, AnalyticsToggleState>(
            listener: (context, state) {},
            builder: (context, state) {
              return ListView.builder(
                itemCount: MethodReused.getWeek(DateTime.now()).length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (day == AppString.day1) {
                        context.read<AnalyticsToggleBloc>().add(AddDayOff(
                            0,
                            DateFormat('E').format(
                                MethodReused.getWeek(DateTime.now())[index])));
                      } else if (day == AppString.day2) {
                        context.read<AnalyticsToggleBloc>().add(AddDayOff(
                            1,
                            DateFormat('E').format(
                                MethodReused.getWeek(DateTime.now())[index])));
                      } else if (day == AppString.day3) {
                        context.read<AnalyticsToggleBloc>().add(AddDayOff(
                            3,
                            DateFormat('E').format(
                                MethodReused.getWeek(DateTime.now())[index])));
                      } else if (day == AppString.day4) {
                        context.read<AnalyticsToggleBloc>().add(AddDayOff(
                            6,
                            DateFormat('E').format(
                                MethodReused.getWeek(DateTime.now())[index])));
                      } else {
                        context.read<AnalyticsToggleBloc>().add(AddDayOff(
                            7,
                            DateFormat('E').format(
                                MethodReused.getWeek(DateTime.now())[index])));
                      }
                    },
                    child: Container(
                      height: AppDimens.dimens_50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          vertical: AppDimens.dimens_5),
                      decoration: BoxDecoration(
                          color: state.allDay.split(',').contains(
                                  DateFormat('E').format(MethodReused.getWeek(
                                      DateTime.now())[index]))
                              ? AppColor.blueColor1.withOpacity(0.8)
                              : AppColor.greenColor1,
                          borderRadius:
                              BorderRadius.circular(AppDimens.dimens_15)),
                      child: Text(
                        DateFormat('EEEE').format(
                            MethodReused.getWeek(DateTime.now())[index]),
                        style: AppAnother.textStyleDefault(AppDimens.dimens_22,
                            AppFont.semiBold, AppColor.whiteColor),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
        child: BlocBuilder<AnalyticsToggleBloc, AnalyticsToggleState>(
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.greenColor,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimens.dimens_15))),
              onPressed: () {
                if (day == AppString.day1) {
                  if (state.allDay.split(',').isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CommonWidget.errorSnackBar('can not submit'));
                  } else {
                    controller.animateToPage(1,
                        curve: Curves.linear,
                        duration: const Duration(microseconds: 1));
                  }
                } else if (day == AppString.day2) {
                  if (state.allDay.split(',').length - 1 > 2) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CommonWidget.errorSnackBar('can not submit'));
                  } else {
                    controller.animateToPage(1,
                        curve: Curves.linear,
                        duration: const Duration(microseconds: 1));
                  }
                } else if (day == AppString.day3) {
                  if (state.allDay.split(',').length - 1 > 5) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CommonWidget.errorSnackBar('can not submit'));
                  } else {
                    controller.animateToPage(1,
                        curve: Curves.linear,
                        duration: const Duration(microseconds: 1));
                  }
                } else if (day == AppString.day4) {
                  if (state.allDay.split(',').length - 1 < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CommonWidget.errorSnackBar('can not submit'));
                  } else {
                    controller.animateToPage(1,
                        curve: Curves.linear,
                        duration: const Duration(microseconds: 1));
                  }
                } else {
                  if (state.allDay.split(',').length - 1 != 7) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CommonWidget.errorSnackBar('can not submit'));
                  } else {
                    controller.animateToPage(1,
                        curve: Curves.linear,
                        duration: const Duration(microseconds: 1));
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: AppDimens.dimens_50,
                width: double.infinity,
                child: Text(
                  'Submit',
                  style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                      AppFont.semiBold, AppColor.whiteColor),
                ),
              ),
            );
          },
        ),
      )
    ],
  );
}

Widget chooseMethod(
  PageController controller,
) {
  return BlocConsumer<AnalyticsToggleBloc, AnalyticsToggleState>(
    listener: (context, state) {
      if (state.status.isSuccess) {
        context.read<AnalyticsBloc>().add(UpdateData());
        Navigator.of(context).pop();
      }
    },
    builder: (context, state) {
      return state.allDay.contains(state.count)
          ? Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.dimens_20,
                  vertical: AppDimens.dimens_10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimens.dimens_10),
                      child: Text(
                        state.count,
                        style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                            AppFont.medium, AppColor.blackColor),
                      )),
                  Center(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimens.dimens_10),
                        child: Text(
                          'Let`s choose your exercise method today',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_18,
                              AppFont.medium,
                              AppColor.blackColor),
                        )),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.dimens_30,
                          vertical: AppDimens.dimens_10),
                      child: ListView.builder(
                          itemCount: AppAnother.exerciseMethod.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context.read<AnalyticsToggleBloc>().add(
                                    AddExerciseMethod(
                                        AppAnother.exerciseMethod[index],
                                        state.count));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: AppDimens.dimens_10),
                                width: double.infinity,
                                height: AppDimens.dimens_50,
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppDimens.dimens_10,
                                    horizontal: AppDimens.dimens_20),
                                decoration: BoxDecoration(
                                    color: checkMethod(
                                            state,
                                            AppAnother.exerciseMethod[index],
                                            state.count)
                                        ? AppColor.greenColor
                                        : AppColor.blueColor1,
                                    borderRadius: BorderRadius.circular(
                                        AppDimens.dimens_15)),
                                child: Center(
                                  child: Text(
                                    AppAnother.exerciseMethod[index],
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_20,
                                        AppFont.medium,
                                        AppColor.whiteColor),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (checkEmpty(
                        state,
                      )) {
                        controller.animateToPage(2,
                            duration: const Duration(milliseconds: 1),
                            curve: Curves.linear);
                        nextAddExercise(state, context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CommonWidget.errorSnackBar(
                                'Please enter the exercise method'));
                      }
                    },
                    child: Container(
                      height: AppDimens.dimens_50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColor.orangeColor1,
                          borderRadius:
                              BorderRadius.circular(AppDimens.dimens_15)),
                      child: Center(
                        child: state.status.isInProgress
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'Next',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_25,
                                    AppFont.semiBold,
                                    AppColor.whiteColor),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${state.count}:',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                        AppFont.semiBold, AppColor.blackColor)),
                Expanded(
                  child: Center(
                    child: Text(
                      'Day Off',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_30,
                          AppFont.semiBold, AppColor.blackColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.dimens_20),
                  child: InkWell(
                    onTap: () {
                      if (state.count != AppString.sun) {
                        context
                            .read<AnalyticsToggleBloc>()
                            .add(AddDayOffDay(state.count));
                        context
                            .read<AnalyticsToggleBloc>()
                            .add(UpdateCount(state.count));
                      } else {
                        context
                            .read<AnalyticsToggleBloc>()
                            .add(AddDayOffDay(state.count));
                        context
                            .read<AnalyticsToggleBloc>()
                            .add(SubmitWorkoutSchedule());
                      }
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(bottom: AppDimens.dimens_10),
                      width: double.infinity,
                      height: AppDimens.dimens_50,
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimens.dimens_10,
                          horizontal: AppDimens.dimens_20),
                      decoration: BoxDecoration(
                          color: AppColor.blueColor1,
                          borderRadius:
                              BorderRadius.circular(AppDimens.dimens_15)),
                      child: state.status.isInProgress
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              'Next',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.medium,
                                  AppColor.whiteColor),
                            ),
                    ),
                  ),
                ),
              ],
            );
    },
  );
}

Widget chooseExcercise(PageController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_20),
    child: BlocConsumer<AnalyticsToggleBloc, AnalyticsToggleState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.read<AnalyticsBloc>().add(UpdateData());
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${state.count}:',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_18, AppFont.medium, AppColor.blackColor),
            ),
            Center(
              child: Text(
                state.countMethod,
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_22, AppFont.medium, AppColor.blackColor),
              ),
            ),
            Center(
              child: Text(
                'Choose exercise',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_18, AppFont.medium, AppColor.blackColor),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (state.muscleGroup
                              .contains(AppAnother.muscleGroup[index])) {
                            BlocProvider.of<AnalyticsToggleBloc>(context).add(
                                UnChooseMuscleGroupSelection(
                                    AppAnother.muscleGroup[index]));
                          } else {
                            BlocProvider.of<AnalyticsToggleBloc>(context).add(
                                ChooseMuscleGroupSelection(
                                    AppAnother.muscleGroup[index]));
                          }
                        },
                        child: Container(
                            width: double.infinity,
                            height: AppDimens.dimens_50,
                            margin: const EdgeInsets.only(
                                bottom: AppDimens.dimens_10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppDimens.dimens_20,
                                vertical: AppDimens.dimens_10),
                            decoration: BoxDecoration(
                                color: AppColor.greenColor,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_15)),
                            child: Text(
                              AppAnother.muscleGroup[index],
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.medium,
                                  AppColor.blackColor),
                            )),
                      ),
                      if (state.muscleGroup
                          .contains(AppAnother.muscleGroup[index]))
                        SizedBox(
                          height: AppDimens.dimens_30 *
                              AppAnother
                                  .exercise[AppAnother.muscleGroup[index]]!
                                  .length,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: AppAnother
                                  .exercise[AppAnother.muscleGroup[index]]!
                                  .length,
                              itemBuilder: (context, indexExercise) {
                                int curentExcercise =
                                    getIndex(state, index, indexExercise);
                                return GestureDetector(
                                    onTap: () {
                                      addOrRemoveExercise(
                                          state, index, indexExercise, context);
                                    },
                                    child: Container(
                                      height: AppDimens.dimens_35,
                                      padding: const EdgeInsets.only(
                                          left: AppDimens.dimens_2,
                                          bottom: AppDimens.dimens_2,
                                          top: AppDimens.dimens_2),
                                      child: Row(
                                        children: [
                                          if (curentExcercise >= 0)
                                            CircleAvatar(
                                              backgroundColor: AppColor.blue1,
                                              child: Text(
                                                (curentExcercise + 1)
                                                    .toString(),
                                                style:
                                                    AppAnother.textStyleDefault(
                                                        AppDimens.dimens_20,
                                                        AppFont.semiBold,
                                                        AppColor.whiteColor),
                                              ),
                                            ),
                                          if (curentExcercise < 0)
                                            CircleAvatar(
                                              backgroundColor:
                                                  AppColor.whiteColor,
                                              child: Text(
                                                (curentExcercise + 1)
                                                    .toString(),
                                                style:
                                                    AppAnother.textStyleDefault(
                                                        AppDimens.dimens_20,
                                                        AppFont.semiBold,
                                                        AppColor.whiteColor),
                                              ),
                                            ),
                                          const SizedBox(
                                            height: AppDimens.dimens_10,
                                          ),
                                          Text(
                                              AppAnother.exercise[
                                                  AppAnother.muscleGroup[
                                                      index]]![indexExercise],
                                              style:
                                                  AppAnother.textStyleDefault(
                                                AppDimens.dimens_20,
                                                AppFont.normal,
                                                AppColor.blackColor,
                                              )),
                                        ],
                                      ),
                                    ));
                              }),
                        )
                    ],
                  );
                },
                itemCount: AppAnother.muscleGroup.length,
              ),
            ),
            InkWell(
              onTap: () {
                switch (state.count) {
                  case AppString.mon:
                    nextCountSate(state.mon, state.countMethod, context,
                        state.count, controller);
                  case AppString.tue:
                    nextCountSate(state.tue, state.countMethod, context,
                        state.count, controller);
                  case AppString.wed:
                    nextCountSate(state.wed, state.countMethod, context,
                        state.count, controller);
                  case AppString.thu:
                    nextCountSate(state.thu, state.countMethod, context,
                        state.count, controller);
                  case AppString.fri:
                    nextCountSate(state.fri, state.countMethod, context,
                        state.count, controller);
                  case AppString.sat:
                    nextCountSate(state.sat, state.countMethod, context,
                        state.count, controller);
                  default:
                    // print(state.fri);
                    // print(state.thu);
                    // print(state.wed);
                    // print(state.tue);
                    // print(state.mon);
                    nextCountSate(state.sun, state.countMethod, context,
                        state.count, controller);
                }
              },
              child: Container(
                height: AppDimens.dimens_50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.orangeColor1,
                    borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                child: Center(
                  child: state.status.isInProgress
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          'Next',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_25,
                              AppFont.semiBold,
                              AppColor.whiteColor),
                        ),
                ),
              ),
            )
          ],
        );
      },
    ),
  );
}

void nextCountSate(String value, String countMethod, BuildContext context,
    String count, PageController controller) {
  List<String> exerciseMethod = [];
  for (int i = 0; i < value.split(';').length - 1; i++) {
    exerciseMethod.add(value.split(';')[i].split(':')[0]);
  }
  if (countMethod == exerciseMethod[exerciseMethod.length - 1]) {
    if (count == AppString.sun) {
      context.read<AnalyticsToggleBloc>().add(SubmitWorkoutSchedule());
    } else {
      context.read<AnalyticsToggleBloc>().add(ResetMuscleGroup());
      context.read<AnalyticsToggleBloc>().add(UpdateCount(count));
      controller.animateToPage(1,
          duration: const Duration(milliseconds: 1), curve: Curves.linear);
    }
  } else {
    context.read<AnalyticsToggleBloc>().add(ResetMuscleGroup());
    context
        .read<AnalyticsToggleBloc>()
        .add(UpdateCountMethod(exerciseMethod[exerciseMethod.indexWhere(
              (element) => element == countMethod,
            ) +
            1]));
  }
}

bool checkMethod(
    AnalyticsToggleState state, String exerciseMethod, String day) {
  switch (day) {
    case AppString.mon:
      return state.mon.contains(exerciseMethod);
    case AppString.tue:
      return state.tue.contains(exerciseMethod);
    case AppString.wed:
      return state.wed.contains(exerciseMethod);
    case AppString.thu:
      return state.thu.contains(exerciseMethod);
    case AppString.fri:
      return state.fri.contains(exerciseMethod);
    case AppString.sat:
      return state.sat.contains(exerciseMethod);
    default:
      return state.sun.contains(exerciseMethod);
  }
}

bool checkEmpty(
  AnalyticsToggleState state,
) {
  switch (state.count) {
    case AppString.mon:
      return state.mon.isNotEmpty;
    case AppString.tue:
      return state.tue.isNotEmpty;
    case AppString.wed:
      return state.wed.isNotEmpty;
    case AppString.thu:
      return state.thu.isNotEmpty;
    case AppString.fri:
      return state.fri.isNotEmpty;
    case AppString.sat:
      return state.sat.isNotEmpty;
    default:
      return state.sun.isNotEmpty;
  }
}

int indexItem(String day, String countMethod, int index, int indexExercise) {
  int indexItem = -1;
  for (int i = 0; i < day.split(';').length - 1; i++) {
    if (day.split(';')[i].split(':')[0] == countMethod) {
      indexItem = day.split(';')[i].split(':')[1].split(',').indexWhere(
            (element) =>
                element ==
                AppAnother
                    .exercise[AppAnother.muscleGroup[index]]![indexExercise],
          );
    }
  }
  return indexItem;
}

int getIndex(AnalyticsToggleState state, int index, int indexExercise) {
  switch (state.count) {
    case AppString.mon:
      return indexItem(state.mon, state.countMethod, index, indexExercise);

    case AppString.tue:
      return indexItem(state.tue, state.countMethod, index, indexExercise);
    case AppString.wed:
      return indexItem(state.wed, state.countMethod, index, indexExercise);
    case AppString.thu:
      return indexItem(state.thu, state.countMethod, index, indexExercise);
    case AppString.fri:
      return indexItem(state.fri, state.countMethod, index, indexExercise);
    case AppString.sat:
      return indexItem(state.sat, state.countMethod, index, indexExercise);
    default:
      return indexItem(state.sun, state.countMethod, index, indexExercise);
  }
}

void addOrRemoveExerciseItem(String value, String day, BuildContext context,
    int index, int indexExercise) {
  if (value.contains(
      AppAnother.exercise[AppAnother.muscleGroup[index]]![indexExercise])) {
    BlocProvider.of<AnalyticsToggleBloc>(context).add(UnChooseExercise(
      day,
      AppAnother.exercise[AppAnother.muscleGroup[index]]![indexExercise],
    ));
  } else {
    BlocProvider.of<AnalyticsToggleBloc>(context).add(ChooseExercise(
      day,
      AppAnother.exercise[AppAnother.muscleGroup[index]]![indexExercise],
    ));
  }
}

void addOrRemoveExercise(AnalyticsToggleState state, int index,
    int indexExercise, BuildContext context) {
  switch (state.count) {
    case AppString.mon:
      addOrRemoveExerciseItem(
          state.mon, AppString.mon, context, index, indexExercise);

    case AppString.tue:
      addOrRemoveExerciseItem(
          state.tue, AppString.tue, context, index, indexExercise);
    case AppString.wed:
      addOrRemoveExerciseItem(
          state.wed, AppString.wed, context, index, indexExercise);
    case AppString.thu:
      addOrRemoveExerciseItem(
          state.thu, AppString.thu, context, index, indexExercise);
    case AppString.fri:
      addOrRemoveExerciseItem(
          state.fri, AppString.fri, context, index, indexExercise);
    case AppString.sat:
      addOrRemoveExerciseItem(
          state.sat, AppString.sat, context, index, indexExercise);
    default:
      addOrRemoveExerciseItem(
          state.sun, AppString.sun, context, index, indexExercise);
  }
}

void nextAddExerciseItem(String value, BuildContext context) {
  List<String> exerciseMethod = [];
  for (int i = 0; i < value.split(';').length - 1; i++) {
    exerciseMethod.add(value.split(';')[i].split(':')[0]);
  }
  context.read<AnalyticsToggleBloc>().add(UpdateCountMethod(exerciseMethod[0]));
}

void nextAddExercise(AnalyticsToggleState state, BuildContext context) {
  switch (state.count) {
    case AppString.mon:
      nextAddExerciseItem(state.mon, context);

    case AppString.tue:
      nextAddExerciseItem(state.tue, context);

    case AppString.wed:
      nextAddExerciseItem(state.wed, context);
    case AppString.thu:
      nextAddExerciseItem(state.thu, context);

    case AppString.fri:
      nextAddExerciseItem(state.fri, context);
    case AppString.sat:
      nextAddExerciseItem(state.sat, context);

    default:
      nextAddExerciseItem(state.sun, context);
  }
}
