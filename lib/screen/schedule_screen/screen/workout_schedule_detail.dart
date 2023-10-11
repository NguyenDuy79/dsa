import 'package:fitness_app_bloc/common_bloc/bloc_anlytics/analytics_bloc.dart';
import 'package:fitness_app_bloc/config/config.dart';
import 'package:fitness_app_bloc/reused/method_reused.dart';
import 'package:fitness_app_bloc/reused/widget_reused.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutScheduleDetail extends StatelessWidget {
  const WorkoutScheduleDetail(this.schedule,{super.key});
  final Map<String, Object?> schedule;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        elevation: AppDimens.dimens_0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.blackColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: AppColor.whiteColor,
        title: Text(
          'Schedule Detail',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Monday:',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
              dayWidget(schedule[AppString.mon] as String),
              Text(
                'Tuesday:',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
              dayWidget(schedule[AppString.tue] as String),
              Text(
                'wednesday:',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
              dayWidget(schedule[AppString.wed] as String),
              Text(
                'Thursday:',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
              dayWidget(schedule[AppString.thu] as String),
              Text(
                'Friday:',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
              dayWidget(schedule[AppString.fri] as String),
              Text(
                'Saturday:',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
              dayWidget(schedule[AppString.sat] as String),
              Text(
                'Sunday:',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
              dayWidget(schedule[AppString.sun] as String),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: AppDimens.dimens_10),
        height: AppDimens.dimens_50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.blue2,
          ),
          onPressed: () async {
            schedule[AppString.use] == 0
                ? context
                    .read<AnalyticsBloc>()
                    .add(UpdateUse(schedule[AppString.id] as int, 1))
                : context
                    .read<AnalyticsBloc>()
                    .add(UpdateUse(schedule[AppString.id] as int, 0));
            Navigator.of(context).pop();
           
          },
          child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
            builder: (context, state) {
              return state is AnalyticsInitial
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      schedule[AppString.use] == 0 ? 'Unapply' : 'Apply',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                          AppFont.semiBold, AppColor.blackColor),
                    );
            },
          ),
        ),
      ),
    );
  }
}

Widget dayWidget(
  String value,
) {
  return value == AppString.dayOff
      ? Center(
          child: Text('Day Off',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor)),
        )
      : SizedBox(
          height: getDouble(value),
          child: ListView.builder(
              itemCount: value.split(';').length - 1,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                String exercise = value.split(';')[index].split(':')[1];

                String methodExercise = value.split(';')[index].split(':')[0];
                List<String> back = [];
                List<String> chest = [];
                List<String> shoulder = [];
                List<String> arm = [];
                List<String> legAndGlutes = [];

                if (methodExercise == AppString.inTheGym ||
                    methodExercise == AppString.frontCableRaise) {
                  back = MethodReused.listExercise(
                      AppAnother.backExercise, exercise.split(','));
                  chest = MethodReused.listExercise(
                      AppAnother.chestExercise, exercise.split(','));
                  shoulder = MethodReused.listExercise(
                      AppAnother.shoulderExercise, exercise.split(','));
                  arm = MethodReused.listExercise(
                      AppAnother.armExercise, exercise.split(','));
                  legAndGlutes = MethodReused.listExercise(
                      AppAnother.legAndGlutesExercise, exercise.split(','));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: AppDimens.dimens_15),
                      child: Text(
                          '${methodExercise.contains('.') ? methodExercise.split('.')[1] : methodExercise}:',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.semiBold,
                              AppColor.blackColor)),
                    ),
                    if ((methodExercise.contains('.')
                                ? methodExercise.split('.')[0]
                                : methodExercise) ==
                            AppString.cardio &&
                        exercise.contains('.'))
                      cardioHiitGroup(exercise),
                    if ((methodExercise.contains('.')
                                ? methodExercise.split('.')[0]
                                : methodExercise) ==
                            AppString.cardio &&
                        !exercise.contains('.'))
                      cardio(exercise),
                    if (methodExercise == AppString.inTheGym ||
                        methodExercise == AppString.frontCableRaise)
                      gymAndCalisthenics(
                          back, chest, arm, legAndGlutes, shoulder)
                  ],
                );
              }),
        );
}

Widget gymAndCalisthenics(List<String> back, List<String> chest,
    List<String> arm, List<String> legAndGlutes, List<String> shoulder) {
  return Column(
    children: [
      WidgetReused.exercise(back, AppString.back),
      WidgetReused.exercise(chest, AppString.chest),
      WidgetReused.exercise(arm, AppString.arm),
      WidgetReused.exercise(legAndGlutes, AppString.legAndGlutes),
      WidgetReused.exercise(shoulder, AppString.shoulder),
    ],
  );
}

Widget cardio(String exercise) {
  List<String> listExercise = exercise.split(',');
  return SizedBox(
    height: AppDimens.dimens_22 * exercise.split(',').length - 1,
    child: ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listExercise.length - 1,
      itemBuilder: (context, index) => Center(child: Text(listExercise[index])),
    ),
  );
}

Widget cardioHiitGroup(String exercise) {
  return SizedBox(
      height: getHiitHeight(exercise),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: exercise.split('.').length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Level ${index + 1}',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                        AppFont.medium, AppColor.blackColor),
                  ),
                ),
                SizedBox(
                  height: (exercise.split('.')[index].split(',').length - 1) *
                      AppDimens.dimens_22,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: exercise.split('.')[index].split(',').length - 1,
                    itemBuilder: (context, indexExercise) => Center(
                        child: Text(
                      exercise.split('.')[index].split(',')[indexExercise],
                    )),
                  ),
                ),
              ],
            );
          }));
}

double getDouble(
  String value,
) {
  double result = 0;
  for (int i = 0; i < value.split(';').length - 1; i++) {
    String exercise = value.split(';')[i].split(':')[1];
    String exerciseMethod = value.split(';')[i].split(':')[0];
    if (exerciseMethod == AppString.inTheGym ||
        exerciseMethod == AppString.calisthenics) {
      List<String> back = MethodReused.listExercise(
          AppAnother.backExercise, exercise.split(','));
      List<String> chest = MethodReused.listExercise(
          AppAnother.chestExercise, exercise.split(','));
      List<String> shoulder = MethodReused.listExercise(
          AppAnother.shoulderExercise, exercise.split(','));
      List<String> arm = MethodReused.listExercise(
          AppAnother.armExercise, exercise.split(','));
      List<String> legAndGlutes = MethodReused.listExercise(
          AppAnother.legAndGlutesExercise, exercise.split(','));
      result = result +
          25 +
          (back.isNotEmpty ? 30 + 25 * back.length : 0) +
          (chest.isNotEmpty ? 30 + 25 * chest.length : 0) +
          (shoulder.isNotEmpty ? 30 + 25 * shoulder.length : 0) +
          (arm.isNotEmpty ? 30 + 25 * arm.length : 0) +
          (legAndGlutes.isNotEmpty ? 30 + 25 * legAndGlutes.length : 0);
    } else {
      if (exercise.contains('.')) {
        result = result + AppDimens.dimens_30;
        for (int j = 0; j < exercise.split('.').length; j++) {
          result = result +
              AppDimens.dimens_25 +
              (exercise.split('.')[j].split(',').length - 1) *
                  AppDimens.dimens_22;
        }
      } else {
        result = result +
            AppDimens.dimens_30 +
            AppDimens.dimens_22 * (exercise.split(',').length - 1);
      }
    }
  }
  return result;
}

double getHiitHeight(String exercise) {
  double result = 0;
  for (int i = 0; i < exercise.split('.').length; i++) {
    result = result +
        (exercise.split('.')[i].split(',').length - 1) * AppDimens.dimens_22 +
        AppDimens.dimens_25;
  }
  return result;
}
