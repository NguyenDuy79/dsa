import 'package:fitness_app_bloc/common_bloc/bloc_activity/activity_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_anlytics/analytics_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_index/index_common_bloc.dart';
import 'package:fitness_app_bloc/db/database_helper.dart';
import 'package:fitness_app_bloc/reused/reused.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/config.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final DateTime dateTime = DateTime.now();
    final PageController controller = PageController(
        initialPage: MethodReused.getWeek(dateTime).indexWhere(
      (element) =>
          DateFormat('E').format(dateTime) == DateFormat('E').format(element),
    ));

    return BlocProvider<IndexCommonBloc>(
      create: (context) => IndexCommonBloc()
        ..add(ScrollPageView(MethodReused.getWeek(dateTime).indexWhere(
          (element) =>
              DateFormat('E').format(dateTime) ==
              DateFormat('E').format(element),
        ))),
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          elevation: AppDimens.dimens_0,
          title: Text(
            'Analytics',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: SingleChildScrollView(
          child: BlocConsumer<AnalyticsBloc, AnalyticsState>(
            listener: (context, state) {},
            builder: (context, state) {
              Map<String, Object?> currentInformation = context.select(
                  (ActivityBloc bloc) => bloc.state.activityResponse.last);
              List<Map<String, Object?>> listReplaceable =
                  getListReplace(state.data, currentInformation);
              resetApplySchedule(state.currentData, listReplaceable, context);
              context
                  .read<IndexCommonBloc>()
                  .add(ScrollPageView(MethodReused.getWeek(dateTime).indexWhere(
                    (element) =>
                        DateFormat('E').format(dateTime) ==
                        DateFormat('E').format(element),
                  )));
              return state is AnalyticsInitial
                  ? SizedBox(
                      height: height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: [
                        BlocBuilder<IndexCommonBloc, IndexCommonState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: width,
                              height: AppDimens.dimens_60,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    MethodReused.getWeek(dateTime).length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: width / 7,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              DateFormat('E').format(
                                                  MethodReused.getWeek(
                                                      dateTime)[index]),
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_12,
                                                      AppFont.medium,
                                                      AppColor.colorGrey4)),
                                          GestureDetector(
                                            onTap: () {
                                              controller.animateToPage(index,
                                                  duration: const Duration(
                                                      microseconds: 100),
                                                  curve: Curves.linear);
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  state.index != index
                                                      ? AppColor.colorGrey2
                                                      : AppColor.blackColor,
                                              child: Text(
                                                DateFormat('dd').format(
                                                    MethodReused.getWeek(
                                                        dateTime)[index]),
                                                style:
                                                    AppAnother.textStyleDefault(
                                                        AppDimens.dimens_20,
                                                        AppFont.semiBold,
                                                        state.index !=
                                                                index.toDouble()
                                                            ? AppColor
                                                                .blackColor
                                                            : AppColor
                                                                .whiteColor),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        Container(
                          width: double.infinity,
                          height: width * 0.5,
                          margin: const EdgeInsets.symmetric(
                              horizontal: AppDimens.dimens_10,
                              vertical: AppDimens.dimens_10),
                          child: PageView.builder(
                            controller: controller,
                            onPageChanged: (value) {
                              context
                                  .read<IndexCommonBloc>()
                                  .add(ScrollPageView(value));
                            },
                            itemCount: MethodReused.getWeek(dateTime).length,
                            itemBuilder: (context, index) {
                              String value = '';
                              if (state.currentData.isNotEmpty) {
                                value = state
                                    .currentData[DateFormat('E').format(
                                        MethodReused.getWeek(dateTime)[index])]
                                    .toString();
                              }

                              return state.currentData.isEmpty
                                  ? Center(
                                      child: Text(
                                      'Empty',
                                      style: AppAnother.textStyleDefault(
                                          AppDimens.dimens_35,
                                          AppFont.bold,
                                          AppColor.blackColor),
                                    ))
                                  : value == AppString.dayOff
                                      ? Center(
                                          child: Text(
                                          AppString.dayOff,
                                          style: AppAnother.textStyleDefault(
                                              AppDimens.dimens_35,
                                              AppFont.bold,
                                              AppColor.blackColor),
                                        ))
                                      : Container(
                                          height: width * 0.5,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: AppDimens.dimens_10),
                                          decoration: BoxDecoration(
                                              color: AppColor.pink1,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimens.dimens_20)),
                                          child: ListView.builder(
                                            itemCount:
                                                value.split(';').length - 1,
                                            itemBuilder: (context, index) {
                                              String methodExercise =
                                                  MethodReused
                                                      .getExerciseOrMethod(
                                                          state.currentData,
                                                          index,
                                                          AppString
                                                              .methodExercise,
                                                          dateTime,
                                                          value);
                                              String exercise = MethodReused
                                                  .getExerciseOrMethod(
                                                      state.currentData,
                                                      index,
                                                      AppString.exercise,
                                                      dateTime,
                                                      value);
                                              List<String> back =
                                                  MethodReused.getMuscleGroup(
                                                      state.currentData,
                                                      index,
                                                      AppString.back,
                                                      dateTime,
                                                      exercise);
                                              List<String> chest =
                                                  MethodReused.getMuscleGroup(
                                                      state.currentData,
                                                      index,
                                                      AppString.chest,
                                                      dateTime,
                                                      exercise);
                                              List<String> shoulder =
                                                  MethodReused.getMuscleGroup(
                                                      state.currentData,
                                                      index,
                                                      AppString.shoulder,
                                                      dateTime,
                                                      exercise);
                                              List<String> arm =
                                                  MethodReused.getMuscleGroup(
                                                      state.currentData,
                                                      index,
                                                      AppString.arm,
                                                      dateTime,
                                                      exercise);
                                              List<String> legAndGlutes =
                                                  MethodReused.getMuscleGroup(
                                                      state.currentData,
                                                      index,
                                                      AppString.legAndGlutes,
                                                      dateTime,
                                                      exercise);

                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal:
                                                      AppDimens.dimens_20,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        methodExercise,
                                                        style: AppAnother
                                                            .textStyleDefault(
                                                                AppDimens
                                                                    .dimens_20,
                                                                AppFont
                                                                    .semiBold,
                                                                AppColor
                                                                    .blackColor),
                                                      ),
                                                    ),
                                                    WidgetReused.exercise(
                                                        back, AppString.back),
                                                    WidgetReused.exercise(
                                                        chest, AppString.chest),
                                                    WidgetReused.exercise(
                                                        arm, AppString.arm),
                                                    WidgetReused.exercise(
                                                        legAndGlutes,
                                                        AppString.legAndGlutes),
                                                    WidgetReused.exercise(
                                                        shoulder,
                                                        AppString.shoulder),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.dimens_10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Shedule Replaceable',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.semiBold,
                                    AppColor.blackColor),
                              ),
                              TextButton(
                                onPressed: () async {
                                  var list = await DbHelper()
                                      .getData(AppString.informationTable);
                                  // ignore: use_build_context_synchronously
                                  getAddSchedule(context, list);
                                },
                                child: Text(
                                  '+ Add',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.medium,
                                      AppColor.blueColor1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (listReplaceable.isEmpty)
                          Text(
                            'Empty',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_25,
                                AppFont.semiBold,
                                AppColor.blackColor),
                          ),
                        if (listReplaceable.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.dimens_20,
                            ),
                            height:
                                AppDimens.dimens_65 * listReplaceable.length,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listReplaceable.length,
                              reverse: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            RouteGenerator
                                                .workoutScheduleDetail,
                                            arguments: listReplaceable[index]);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimens.dimens_15)),
                                          backgroundColor:
                                              listReplaceable[index]
                                                          [AppString.use] ==
                                                      0
                                                  ? AppColor.yellowColor1
                                                  : AppColor.colorGrey2,
                                          elevation: AppDimens.dimens_0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppDimens.dimens_10,
                                            vertical: AppDimens.dimens_5),
                                        height: AppDimens.dimens_60,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                        listReplaceable[index][
                                                                AppString
                                                                    .dateTime]
                                                            .toString()
                                                            .split(' ')[0],
                                                        style: AppAnother
                                                            .textStyleDefault(
                                                                AppDimens
                                                                    .dimens_15,
                                                                AppFont.normal,
                                                                AppColor
                                                                    .blackColor)),
                                                    Text(
                                                        listReplaceable[index][
                                                                AppString
                                                                    .dateTime]
                                                            .toString()
                                                            .split(' ')[1],
                                                        style: AppAnother
                                                            .textStyleDefault(
                                                                AppDimens
                                                                    .dimens_15,
                                                                AppFont.normal,
                                                                AppColor
                                                                    .blackColor))
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: AppDimens.dimens_40,
                                                ),
                                                Text(
                                                    'Activity: ${listReplaceable[index][AppString.activity]} days',
                                                    style: AppAnother
                                                        .textStyleDefault(
                                                            AppDimens.dimens_15,
                                                            AppFont.normal,
                                                            AppColor
                                                                .blackColor)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                if (listReplaceable[index]
                                                        [AppString.use] ==
                                                    0)
                                                  Text(
                                                    'Apply',
                                                    style: AppAnother
                                                        .textStyleDefault(
                                                            AppDimens.dimens_18,
                                                            AppFont.normal,
                                                            AppColor
                                                                .blackColor),
                                                  ),
                                                const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: AppDimens.dimens_20,
                                                  color: AppColor.blackColor,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: AppDimens.dimens_5,
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

bool getBool(List<Map<String, Object?>> list, Map<String, Object?> map) {
  bool result = false;
  for (var item in list) {
    if (item[AppString.id] == map[AppString.id]) {
      result = true;
    }
  }
  return result;
}

List<Map<String, Object?>> getListReplace(
    List<Map<String, Object?>> data, Map<String, Object?> currentInformation) {
  List<Map<String, Object?>> result = [];
  if (data.isNotEmpty) {
    for (int i = 0; i < data.length; i++) {
      switch (currentInformation[AppString.activity]) {
        case AppString.activity1:
          break;
        case AppString.activity2:
          if ((data[i][AppString.activity] as int) < 3 &&
              (data[i][AppString.activity] as int) >= 1) {
            result.add(data[i]);
          }
        case AppString.activity3:
          if ((data[i][AppString.activity] as int) < 6 &&
              (data[i][AppString.activity] as int) >= 3) {
            result.add(data[i]);
          }
        case AppString.activity4:
          if ((data[i][AppString.activity] as int) >= 6) {
            result.add(data[i]);
          }
        default:
          if ((data[i][AppString.activity] as int) == 7) {
            result.add(data[i]);
          }
      }
    }
  }
  return result;
}

void resetApplySchedule(Map<String, Object?> currentData,
    List<Map<String, Object?>> listReplaceable, BuildContext context) {
  if (currentData.isNotEmpty) {
    if (getBool(listReplaceable, currentData) == false) {
      context
          .read<AnalyticsBloc>()
          .add(UpdateUse(currentData[AppString.id] as int, 1));
    }
  }
}

void getAddSchedule(BuildContext context, List<Map<String, Object?>> list) {
  if (list.last[AppString.activity] == AppString.activity1) {
  } else if (list.last[AppString.activity] == AppString.activity2) {
    Navigator.of(context)
        .pushNamed(RouteGenerator.addWorkoutShedule, arguments: '1-2');
  } else if (list.last[AppString.activity] == AppString.activity3) {
    Navigator.of(context)
        .pushNamed(RouteGenerator.addWorkoutShedule, arguments: '3-5');
  } else if (list.last[AppString.activity] == AppString.activity4) {
    Navigator.of(context)
        .pushNamed(RouteGenerator.addWorkoutShedule, arguments: '6-7');
  } else {
    Navigator.of(context)
        .pushNamed(RouteGenerator.addWorkoutShedule, arguments: '7');
  }
}
