import 'package:fitness_app_bloc/common_bloc/bloc_anlytics/analytics_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../config/config.dart';
import '../../../reused/reused.dart';
import '../bloc/bloc_analytics/analytics_toggle_bloc.dart';

class ChooseGymWidget extends StatelessWidget {
  const ChooseGymWidget(this.controller, {super.key});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnalyticsToggleBloc, AnalyticsToggleState>(
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
            Center(
              child: Text(
                'Choose exercise',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
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
                            color: AppColor.whiteColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppAnother.muscleGroup[index],
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.medium,
                                      AppColor.blackColor),
                                ),
                                Icon(
                                  state.muscleGroup.contains(
                                          AppAnother.muscleGroup[index])
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  color: AppColor.blackColor,
                                )
                              ],
                            )),
                      ),
                      if (state.muscleGroup
                          .contains(AppAnother.muscleGroup[index]))
                        SizedBox(
                          height: AppDimens.dimens_36 *
                              AppAnother
                                  .exercise[AppAnother.muscleGroup[index]]!
                                  .length,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: AppAnother
                                  .exercise[AppAnother.muscleGroup[index]]!
                                  .length,
                              itemBuilder: (context, indexExercise) {
                                int curentExcercise = MethodReused.getIndex(
                                    state, index, indexExercise);
                                return GestureDetector(
                                    onTap: () {
                                      MethodReused.addOrRemoveExercise(
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
                                              backgroundColor:
                                                  AppColor.colorGrey2,
                                              child: Text(
                                                (curentExcercise + 1)
                                                    .toString(),
                                                style:
                                                    AppAnother.textStyleDefault(
                                                        AppDimens.dimens_17,
                                                        AppFont.semiBold,
                                                        AppColor.blackColor),
                                              ),
                                            ),
                                          if (curentExcercise < 0)
                                            CircleAvatar(
                                              backgroundColor:
                                                  AppColor.colorGrey2,
                                              child: Text(
                                                (curentExcercise + 1)
                                                    .toString(),
                                                style:
                                                    AppAnother.textStyleDefault(
                                                        AppDimens.dimens_17,
                                                        AppFont.semiBold,
                                                        AppColor.colorGrey2),
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
                                                AppDimens.dimens_17,
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: AppDimens.dimens_10),
              child: InkWell(
                onTap: () {
                  MethodReused.nextCountSate(state, context, controller);
                },
                child: Container(
                  height: AppDimens.dimens_50,
                  width: double.infinity,
                  color: AppColor.whiteColor,
                  child: Center(
                    child: state.status.isInProgress
                        ? const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: AppColor.blackColor,
                            ),
                          )
                        : Text(
                            'Next',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_25,
                                AppFont.semiBold,
                                AppColor.blackColor),
                          ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
