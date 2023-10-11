import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../common_bloc/bloc_anlytics/analytics_bloc.dart';
import '../../../config/config.dart';
import '../bloc/bloc_analytics/analytics_toggle_bloc.dart';

class DayOffWidget extends StatelessWidget {
  const DayOffWidget( {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: Text(
              'Day Off',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_30, AppFont.semiBold, AppColor.blackColor),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimens.dimens_10),
          child: BlocConsumer<AnalyticsToggleBloc, AnalyticsToggleState>(
            listener: (context, state) {
               if (state.status.isSuccess) {
          context.read<AnalyticsBloc>().add(UpdateData());
          Navigator.of(context).pop();
        }
            },
            builder: (context, state) {
              return InkWell(
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
                  width: double.infinity,
                  height: AppDimens.dimens_50,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.dimens_10,
                  ),
                  color: AppColor.colorGrey0,
                  child: state.status.isInProgress
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Center(
                          child: Text(
                            'Next',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor),
                          ),
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
