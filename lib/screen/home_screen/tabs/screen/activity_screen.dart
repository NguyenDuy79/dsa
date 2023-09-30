import 'package:fitness_app_bloc/common_bloc/bloc_anlytics/analytics_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_history/history_bloc.dart';
import 'package:fitness_app_bloc/config/app_another.dart';
import 'package:fitness_app_bloc/config/app_color.dart';
import 'package:fitness_app_bloc/config/app_dimens.dart';
import 'package:fitness_app_bloc/config/app_font.dart';
import 'package:fitness_app_bloc/config/app_path.dart';
import 'package:fitness_app_bloc/config/route_generator.dart';
import 'package:fitness_app_bloc/screen/home_screen/tabs/widget/activity/gridview_activity_screen.dart';
import 'package:fitness_app_bloc/screen/home_screen/tabs/widget/activity/pageview_action.dart';
import 'package:fitness_app_bloc/screen/home_screen/tabs/widget/activity/pageview_recipes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/app_string.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final DateTime dateTime = DateTime.now();
    final List<Map<String, Object?>> allHistory =
        context.select((HistoryBloc bloc) => bloc.state.dataHistory);
    int minute = getSecondOrExercise(allHistory, dateTime, true);
    int exercise = getSecondOrExercise(allHistory, dateTime, false);
    Map<String,Object?> currentData = context.select((AnalyticsBloc bloc) => bloc.state.currentData);
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.colorGrey1,
          appBar: AppBar(
            backgroundColor: AppColor.colorGrey1,
            elevation: 0,
            leading: GestureDetector(
              child: const CircleAvatar(
                backgroundImage: AssetImage(AppPath.userImage),
              ),
            ),
            title: Text(
              'Activity',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: AppColor.blackColor,
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: AppDimens.dimens_20,
                    horizontal: AppDimens.dimens_10),
                padding: const EdgeInsets.all(AppDimens.dimens_10),
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(AppDimens.dimens_20)),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Tap to start',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                            AppFont.medium, AppColor.darkgrey),
                      ),
                    ),
                    const SizedBox(
                      height: AppDimens.dimens_3,
                    ),
                    Center(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: AppColor.greenColor1),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RouteGenerator.setupExerciseScreen,arguments: currentData);
                      },
                      child: SizedBox(
                          height: AppDimens.dimens_90,
                          width: AppDimens.dimens_90,
                          child: CircleAvatar(
                            child: ClipOval(
                              child: Image.asset(AppPath.practiceImage,
                                  fit: BoxFit.cover),
                            ),
                          )),
                    )),
                    const SizedBox(
                      height: AppDimens.dimens_10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              FittedBox(
                                child: Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.timer_outlined,
                                      color: AppColor.yellowColor1,
                                    ),
                                    Text(
                                      ' Time Today',
                                      style: AppAnother.textStyleDefault(
                                          AppDimens.dimens_12,
                                          AppFont.normal,
                                          AppColor.blackColor),
                                    ),
                                  ],
                                ),
                              ),
                              Text('$minute minute',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_14,
                                      AppFont.normal,
                                      AppColor.blackColor)),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: <Widget>[
                              FittedBox(
                                child: Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.run_circle_outlined,
                                      color: AppColor.orangeColor1,
                                    ),
                                    Text(
                                      ' Exercise Today',
                                      style: AppAnother.textStyleDefault(
                                          AppDimens.dimens_12,
                                          AppFont.normal,
                                          AppColor.blackColor),
                                    ),
                                  ],
                                ),
                              ),
                              Text('$exercise exercise',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_14,
                                      AppFont.normal,
                                      AppColor.blackColor)),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RouteGenerator.historyTodayScreen);
                          },
                          child: Row(children: <Widget>[
                            Text(
                              'Detail  ',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_15,
                                  AppFont.normal,
                                  AppColor.blackColor),
                            ),
                            const Icon(
                              size: AppDimens.dimens_15,
                              Icons.arrow_forward_ios,
                              color: AppColor.blackColor,
                            )
                          ]),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width:
                        (width - AppDimens.dimens_30) / 2 + AppDimens.dimens_10,
                    height:
                        (width - AppDimens.dimens_30) / 2 + AppDimens.dimens_40,
                    margin: const EdgeInsets.only(
                        left: AppDimens.dimens_10, bottom: AppDimens.dimens_20),
                    child: PageViewActionWidget(width),
                  ),
                  Container(
                    width:
                        (width - AppDimens.dimens_30) / 2 + AppDimens.dimens_10,
                    height:
                        (width - AppDimens.dimens_30) / 2 + AppDimens.dimens_40,
                    margin: const EdgeInsets.only(bottom: AppDimens.dimens_20),
                    child: PageViewRecipesWidget(width),
                  )
                ],
              ),
              const GridViewActivity()
            ]),
          )),
    );
  }
}

int getSecondOrExercise(
    List<Map<String, Object?>> allHistory, DateTime dateTime, bool isSecond) {
  int exercise = 0;
  int minute = 0;
  if (allHistory.isNotEmpty) {
    int second = 0;
    for (int i = 0; i < allHistory.length; i++) {
      if (DateFormat('dd/M/yyyy').format(
              DateTime.parse(allHistory[i][AppString.dateTime] as String)) ==
          DateFormat('dd/M/yyyy').format(dateTime)) {
        second = (second +
            DateTime.parse(allHistory[i]['DateTimeEnd'] as String)
                .difference(
                    DateTime.parse(allHistory[i][AppString.dateTime] as String))
                .inSeconds);

        exercise = exercise +
            allHistory[i][AppString.exercise].toString().split(',').length -
            1;
      }
    }
    minute = second ~/ 60;
  }

  return isSecond ? minute : exercise;
}
