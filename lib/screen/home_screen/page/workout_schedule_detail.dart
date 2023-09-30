import 'package:fitness_app_bloc/common_bloc/bloc_anlytics/analytics_bloc.dart';
import 'package:fitness_app_bloc/config/config.dart';
import 'package:fitness_app_bloc/reused/method_reused.dart';
import 'package:fitness_app_bloc/reused/widget_reused.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutScheduleDetail extends StatelessWidget {
  const WorkoutScheduleDetail(this.schedule, {super.key});
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
              AppDimens.dimens_25, AppFont.normal, AppColor.blackColor),
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
        margin: const EdgeInsets.symmetric(
            horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
        height: AppDimens.dimens_50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.greenColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.dimens_10))),
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
                          AppFont.semiBold, AppColor.whiteColor),
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

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(methodExercise,
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.semiBold,
                              AppColor.blackColor)),
                    ),
                    WidgetReused.exercise(back, AppString.back),
                    WidgetReused.exercise(chest, AppString.chest),
                    WidgetReused.exercise(arm, AppString.arm),
                    WidgetReused.exercise(legAndGlutes, AppString.legAndGlutes),
                    WidgetReused.exercise(shoulder, AppString.shoulder),
                  ],
                );
              }),
        );
}

double getDouble(String value) {
  double result = 0;
  for (int i = 0; i < value.split(';').length - 1; i++) {
    String exercise = value.split(';')[i].split(':')[1];

    List<String> back =
        MethodReused.listExercise(AppAnother.backExercise, exercise.split(','));
    List<String> chest = MethodReused.listExercise(
        AppAnother.chestExercise, exercise.split(','));
    List<String> shoulder = MethodReused.listExercise(
        AppAnother.shoulderExercise, exercise.split(','));
    List<String> arm =
        MethodReused.listExercise(AppAnother.armExercise, exercise.split(','));
    List<String> legAndGlutes = MethodReused.listExercise(
        AppAnother.legAndGlutesExercise, exercise.split(','));
    result = result +
        25 +
        (back.isNotEmpty ? 30 + 25 * back.length : 0) +
        (chest.isNotEmpty ? 30 + 25 * chest.length : 0) +
        (shoulder.isNotEmpty ? 30 + 25 * shoulder.length : 0) +
        (arm.isNotEmpty ? 30 + 25 * arm.length : 0) +
        (legAndGlutes.isNotEmpty ? 30 + 25 * legAndGlutes.length : 0);
  }
  return result;
}
