import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../common_app/common_widget.dart';
import '../../../config/config.dart';
import '../../../reused/reused.dart';
import '../bloc/bloc_analytics/analytics_toggle_bloc.dart';

class ChooseDayOffWidget extends StatelessWidget {
  const ChooseDayOffWidget(this.day, this.controller, {super.key});
  final String day;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            color: AppColor.colorGrey2,
            padding: const EdgeInsets.symmetric(vertical: AppDimens.dimens_10),
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
                              DateFormat('E').format(MethodReused.getWeek(
                                  DateTime.now())[index])));
                        } else if (day == AppString.day2) {
                          context.read<AnalyticsToggleBloc>().add(AddDayOff(
                              1,
                              DateFormat('E').format(MethodReused.getWeek(
                                  DateTime.now())[index])));
                        } else if (day == AppString.day3) {
                          context.read<AnalyticsToggleBloc>().add(AddDayOff(
                              3,
                              DateFormat('E').format(MethodReused.getWeek(
                                  DateTime.now())[index])));
                        } else if (day == AppString.day4) {
                          context.read<AnalyticsToggleBloc>().add(AddDayOff(
                              6,
                              DateFormat('E').format(MethodReused.getWeek(
                                  DateTime.now())[index])));
                        } else {
                          context.read<AnalyticsToggleBloc>().add(AddDayOff(
                              7,
                              DateFormat('E').format(MethodReused.getWeek(
                                  DateTime.now())[index])));
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
                              ? AppColor.whiteColor
                              : AppColor.blue2,
                        ),
                        child: Text(
                          DateFormat('EEEE').format(
                              MethodReused.getWeek(DateTime.now())[index]),
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_22,
                              AppFont.semiBold,
                              AppColor.blackColor),
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
          padding: const EdgeInsets.symmetric(vertical: AppDimens.dimens_10),
          child: BlocBuilder<AnalyticsToggleBloc, AnalyticsToggleState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: AppDimens.dimens_5,
                  backgroundColor: AppColor.whiteColor,
                ),
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
                        AppFont.semiBold, AppColor.blackColor),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
