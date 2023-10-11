import 'package:fitness_app_bloc/config/config.dart';
import 'package:fitness_app_bloc/screen/schedule_screen/bloc/bloc_analytics/analytics_toggle_bloc.dart';
import 'package:fitness_app_bloc/screen/schedule_screen/widget/choose_calisthenics_widget.dart';
import 'package:fitness_app_bloc/screen/schedule_screen/widget/choose_cardio_widget.dart';

import 'package:fitness_app_bloc/screen/schedule_screen/widget/choose_day_off_widget.dart';
import 'package:fitness_app_bloc/screen/schedule_screen/widget/choose_exercise_method.dart';
import 'package:fitness_app_bloc/screen/schedule_screen/widget/choose_gym_widget.dart';
import 'package:fitness_app_bloc/screen/schedule_screen/widget/choose_yoga_widget.dart';
import 'package:fitness_app_bloc/screen/schedule_screen/widget/day_off_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddWorkoutSheduleScreen extends StatelessWidget {
  const AddWorkoutSheduleScreen(this.day, {super.key});
  final String day;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      backgroundColor: AppColor.colorGrey2,
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
        backgroundColor: AppColor.colorGrey2,
        automaticallyImplyLeading: false,
        title: Text(
            context.select((AnalyticsToggleBloc bloc) => bloc.state).index == 0
                ? 'Choose day off'
                : context
                            .select((AnalyticsToggleBloc bloc) => bloc.state)
                            .count ==
                        AppString.mon
                    ? 'Monday'
                    : context.select((AnalyticsToggleBloc bloc) => bloc.state).count ==
                            AppString.tue
                        ? 'Tuesday'
                        : context.select((AnalyticsToggleBloc bloc) => bloc.state).count ==
                                AppString.wed
                            ? 'Wednesday'
                            : context
                                        .select((AnalyticsToggleBloc bloc) =>
                                            bloc.state)
                                        .count ==
                                    AppString.thu
                                ? 'Thursday'
                                : context
                                            .select(
                                                (AnalyticsToggleBloc bloc) =>
                                                    bloc.state)
                                            .count ==
                                        AppString.fri
                                    ? 'Friday'
                                    : context
                                                .select(
                                                    (AnalyticsToggleBloc bloc) =>
                                                        bloc.state)
                                                .count ==
                                            AppString.sat
                                        ? 'Saturday'
                                        : 'Sunday',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor)),
        centerTitle: true,
      ),
      body: PageView(
        onPageChanged: (value) {
          context.read<AnalyticsToggleBloc>().add(ChangePage(value));
        },
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ChooseDayOffWidget(day, controller),
          BlocBuilder<AnalyticsToggleBloc, AnalyticsToggleState>(
              builder: (context, state) {
            return state.allDay.contains(state.count)
                ? ChooseExerciseMethod(state, controller)
                : const DayOffWidget();
          }),
          ChooseGymWidget(controller),
          const ChooseYogaWidget(),
          const ChooseCalisthenicsWidget(),
          ChooseCardioWidet(controller)
        ],
      ),
    );
  }
}
