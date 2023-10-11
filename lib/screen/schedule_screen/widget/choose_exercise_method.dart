import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../common_app/common_widget.dart';
import '../../../config/config.dart';
import '../../../reused/reused.dart';
import '../bloc/bloc_analytics/analytics_toggle_bloc.dart';

class ChooseExerciseMethod extends StatelessWidget {
  const ChooseExerciseMethod(this.state, this.controller, {super.key});
  final AnalyticsToggleState state;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorGrey2,
      padding: const EdgeInsets.symmetric(vertical: AppDimens.dimens_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.dimens_10,
                  horizontal: AppDimens.dimens_30),
              child: Text(
                'Let`s choose your exercise method today',
                textAlign: TextAlign.center,
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              )),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: AppDimens.dimens_10),
              child: ListView.builder(
                  itemCount: AppAnother.exerciseMethod.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.read<AnalyticsToggleBloc>().add(
                            AddExerciseMethod(
                                AppAnother.exerciseMethod[index], state.count));
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
                          color: MethodReused.checkMethod(state,
                                  AppAnother.exerciseMethod[index], state.count)
                              ? AppColor.colorGrey4.withOpacity(0.6)
                              : AppColor.whiteColor,
                        ),
                        child: Center(
                          child: Text(
                            AppAnother.exerciseMethod[index],
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          InkWell(
            onTap: () {
              if (MethodReused.checkEmpty(
                state,
              )) {
                if (MethodReused.value(state, state.count)
                        .split(';')[0]
                        .split(':')[0] ==
                    AppString.yoga) {
                  controller.animateToPage(3,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.linear);
                  MethodReused.nextAddExercise(state, context);
                } else if (MethodReused.value(state, state.count)
                        .split(';')[0]
                        .split(':')[0] ==
                    AppString.calisthenics) {
                  controller.animateToPage(4,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.linear);
                  MethodReused.nextAddExercise(state, context);
                } else if (MethodReused.value(state, state.count)
                        .split(';')[0]
                        .split(':')[0] ==
                    AppString.inTheGym) {
                  MethodReused.nextAddExercise(state, context);
                  controller.animateToPage(2,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.linear);
                } else {
                  MethodReused.nextAddExercise(state, context);
                  controller.animateToPage(5,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.linear);
                }
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
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
              child: Center(
                child: state.status.isInProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        'Next',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                            AppFont.semiBold, AppColor.blackColor),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
