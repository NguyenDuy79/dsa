import 'package:fitness_app_bloc/config/app_another.dart';
import 'package:fitness_app_bloc/config/app_color.dart';
import 'package:fitness_app_bloc/config/app_dimens.dart';
import 'package:fitness_app_bloc/config/app_font.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/config/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../common_bloc/bloc_activity/activity_bloc.dart';

class InfomationScreen extends StatelessWidget {
  const InfomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        elevation: AppDimens.dimens_0,
        backgroundColor: AppColor.whiteColor,
        title: Text(
          'Informaion',
          style: AppAnother.textStyleDefault(
            AppDimens.dimens_25,
            AppFont.semiBold,
            AppColor.blackColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.blackColor,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimens.dimens_20,
        ),
        child: BlocConsumer<ActivityBloc, ActivityState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ActivityLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ActivityLoaded) {
              final List<Map<String, Object?>> listState =
                  state.activityResponse.reversed.toList();

              final List<String> timeForMonth = [];
              for (int i = 0; i < listState.length; i++) {
                timeForMonth.add(listState[i][AppString.dateTime] as String);
                for (int j = i + 1; j < listState.length; j++) {
                  if (DateFormat('M-yyyy').format(DateTime.parse(
                          listState[i][AppString.dateTime] as String)) !=
                      DateFormat('M-yyyy').format(DateTime.parse(
                          listState[j][AppString.dateTime] as String))) {
                    i = j;
                    j = listState.length;
                  } else if (j == listState.length - 1) {
                    i = j + 1;
                  }
                }
              }

              return ListView.builder(
                  itemCount: timeForMonth.length,
                  itemBuilder: (context, index) {
                    var newList = listOfMonth(
                        DateFormat('M-yyyy')
                            .format(DateTime.parse(timeForMonth[index])),
                        listState);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.dimens_10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('M-yyyy')
                                .format(DateTime.parse(timeForMonth[index])),
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.semiBold,
                                AppColor.blackColor),
                          ),
                          SizedBox(
                            height: newList.length * AppDimens.dimens_100,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: newList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        RouteGenerator.detailInformation,
                                        arguments: newList[index]);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                        AppDimens.dimens_5),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.notes_rounded,
                                          color: AppColor.blackColor,
                                        ),
                                        const SizedBox(
                                          width: AppDimens.dimens_20,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Activity: ${newList[index][AppString.activity].toString().split('(')[1].split(')')[0]}'),
                                                  Text(
                                                      'Body Fat: ${newList[index][AppString.bodyFat]}%'),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(DateFormat('dd/M')
                                                      .format(DateTime.parse(
                                                          newList[index]
                                                                  [
                                                                  AppString
                                                                      .dateTime]
                                                              as String))),
                                                  const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: AppColor.blackColor,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
          elevation: AppDimens.dimens_0,
          child: const Icon(
            size: AppDimens.dimens_35,
            Icons.format_list_bulleted_add,
            color: AppColor.blackColor,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(RouteGenerator.addInformationScreen);
          }),
    );
  }
}

listOfMonth(String format, List<Map<String, Object?>> value) {
  List<Map<String, Object?>> newList = [];

  for (var item in value) {
    if (format ==
        DateFormat('M-yyyy')
            .format(DateTime.parse(item[AppString.dateTime] as String))) {
      newList.add(item);
    }
  }
  return newList;
}
