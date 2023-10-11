import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../common_bloc/bloc_anlytics/analytics_bloc.dart';
import '../../../config/config.dart';
import '../../../reused/reused.dart';
import '../bloc/bloc_analytics/analytics_toggle_bloc.dart';

class ChooseCardioWidet extends StatelessWidget {
  const ChooseCardioWidet(this.controller, {super.key});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<AnalyticsToggleBloc, AnalyticsToggleState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.read<AnalyticsBloc>().add(UpdateData());
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return state.caridoMethod == ''
            ? chooseCardioMethod(context)
            : state.caridoMethod == AppString.hittCardio
                ? (state.hiitMethod == ''
                    ? chooseHittMethod(context)
                    : state.hiitMethod == 'group'
                        ? (state.chooseExerciseCardio
                            ? chooseExerciseCardio(state, context, controller)
                            : addLevel(context, height))
                        : (state.chooseExerciseCardio
                            ? chooseExerciseCardio(state, context, controller)
                            : Container()))
                : state.chooseExerciseCardio
                    ? chooseExerciseCardio(state, context, controller)
                    : chooseLissMethod(context);
      },
    );
  }
}

Widget chooseCardioMethod(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: () {
          context
              .read<AnalyticsToggleBloc>()
              .add(const AddCardioMethod(AppString.hittCardio));
        },
        child: Container(
          height: AppDimens.dimens_45,
          width: double.infinity,
          color: AppColor.whiteColor,
          alignment: Alignment.center,
          child: Text(
            AppString.hittCardio,
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
          ),
        ),
      ),
      const SizedBox(
        height: AppDimens.dimens_10,
      ),
      InkWell(
        onTap: () {
          context
              .read<AnalyticsToggleBloc>()
              .add(const AddCardioMethod(AppString.lissCardio));
        },
        child: Container(
          height: AppDimens.dimens_45,
          width: double.infinity,
          color: AppColor.whiteColor,
          alignment: Alignment.center,
          child: Text(
            AppString.lissCardio,
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
          ),
        ),
      )
    ],
  );
}

Widget chooseHittMethod(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: () {
          context
              .read<AnalyticsToggleBloc>()
              .add(const ChooseHiitMethod('group'));
        },
        child: Container(
          height: AppDimens.dimens_45,
          width: double.infinity,
          color: AppColor.colorGrey0,
          alignment: Alignment.center,
          child: Text(
            'Group',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
          ),
        ),
      ),
      const SizedBox(
        height: AppDimens.dimens_10,
      ),
      InkWell(
        onTap: () {
          context
              .read<AnalyticsToggleBloc>()
              .add(const ChooseHiitMethod('sequentially'));
          context
              .read<AnalyticsToggleBloc>()
              .add(const ChooseExerciseCardio(true));
        },
        child: Container(
          height: AppDimens.dimens_45,
          width: double.infinity,
          color: AppColor.whiteColor,
          alignment: Alignment.center,
          child: Text(
            'Sequentially',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
          ),
        ),
      )
    ],
  );
}

Widget chooseLissMethod(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.dimens_20),
      child: Column(children: [
        SizedBox(
          height: AppDimens.dimens_60 * AppAnother.lissCardioExercise.length,
          child: ListView.builder(
              itemCount: AppAnother.lissCardioExercise.length,
              itemBuilder: (context, index) => InkWell(
                    onTap: () {},
                    child: Container(
                        width: double.infinity,
                        height: AppDimens.dimens_50,
                        margin:
                            const EdgeInsets.only(bottom: AppDimens.dimens_10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.dimens_20,
                            vertical: AppDimens.dimens_10),
                        color: AppColor.whiteColor,
                        child: Text(
                          AppAnother.lissCardioExercise[index],
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.blackColor),
                        )),
                  )),
        ),
        InkWell(
            onTap: () {
              context
                  .read<AnalyticsToggleBloc>()
                  .add(const ChooseExerciseCardio(true));
            },
            child: Container(
                width: double.infinity,
                height: AppDimens.dimens_50,
                margin: const EdgeInsets.only(bottom: AppDimens.dimens_10),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.dimens_20,
                    vertical: AppDimens.dimens_10),
                color: AppColor.whiteColor,
                child: Text(
                  AppString.onSiteExercises,
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
                )))
      ]));
}

Widget chooseExerciseCardio(AnalyticsToggleState state, BuildContext context,
    PageController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const SizedBox(
            width: AppDimens.dimens_20,
          ),
          Text(
            'Choose cardio exercise',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
          ),
        ],
      ),
      if (state.hiitMethod == 'group')
        Padding(
          padding: const EdgeInsets.only(left: AppDimens.dimens_20),
          child: Text(
            'Level: ${state.countLevel + 1}',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_20, AppFont.semiBold, AppColor.blackColor),
          ),
        ),
      Expanded(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView.builder(
                itemCount: AppAnother.cardioExerciseShare.length,
                itemBuilder: (context, indexExercise) {
                  int curentExcercise = state.hiitMethod == 'group'
                      ? MethodReused.value(state, state.count)
                          .split(
                              ';')[MethodReused.getIndexExerciseMethod(state)]
                          .split(':')[1]
                          .split('.')[state.countLevel]
                          .split(',')
                          .indexWhere((element) =>
                              element ==
                              AppAnother.cardioExerciseShare[indexExercise])
                      : MethodReused.value(state, state.count)
                          .split(
                              ';')[MethodReused.getIndexExerciseMethod(state)]
                          .split(':')[1]
                          .split(',')
                          .indexWhere(
                            (element) =>
                                element ==
                                AppAnother.cardioExerciseShare[indexExercise],
                          );

                  return GestureDetector(
                      onTap: () {
                        if (curentExcercise >= 0) {
                          context.read<AnalyticsToggleBloc>().add(
                              UnChooseExercise(AppAnother
                                  .cardioExerciseShare[indexExercise]));
                        } else {
                          context.read<AnalyticsToggleBloc>().add(
                              ChooseExercise(AppAnother
                                  .cardioExerciseShare[indexExercise]));
                        }
                      },
                      child: Container(
                        height: AppDimens.dimens_35,
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            left: AppDimens.dimens_2,
                            right: AppDimens.dimens_10,
                            bottom: AppDimens.dimens_2,
                            top: AppDimens.dimens_2),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: AppDimens.dimens_5,
                            ),
                            if (curentExcercise >= 0)
                              CircleAvatar(
                                backgroundColor: AppColor.colorGrey2,
                                child: Text(
                                  (curentExcercise + 1).toString(),
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.semiBold,
                                      AppColor.blackColor),
                                ),
                              ),
                            if (curentExcercise < 0)
                              CircleAvatar(
                                backgroundColor: AppColor.colorGrey2,
                                child: Text(
                                  (curentExcercise + 1).toString(),
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.semiBold,
                                      AppColor.colorGrey2),
                                ),
                              ),
                            const SizedBox(
                              height: AppDimens.dimens_8,
                            ),
                            Flexible(
                              child: Text(
                                AppAnother.cardioExerciseShare[indexExercise],
                                style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_18,
                                  AppFont.medium,
                                  AppColor.blackColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ));
                }),
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.dimens_10),
              child: InkWell(
                onTap: () {
                  if (state.hiitMethod == 'group') {
                    if (state.countLevel == int.parse(state.level) - 1) {
                      MethodReused.nextCountSate(state, context, controller);
                    } else {
                      context
                          .read<AnalyticsToggleBloc>()
                          .add(const UpdateCountLevel(true));
                    }
                  } else {
                    MethodReused.nextCountSate(state, context, controller);
                  }
                },
                child: Card(
                  elevation: AppDimens.dimens_5,
                  child: Container(
                      width: double.infinity,
                      height: AppDimens.dimens_50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.dimens_20,
                          vertical: AppDimens.dimens_10),
                      color: AppColor.whiteColor,
                      child: Center(
                        child: Text(
                          'Next',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.blackColor),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget addLevel(BuildContext context, double height) {
  return Container(
    height: height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top,
    alignment: Alignment.center,
    child: Form(
      key: AppAnother.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppDimens.dimens_10),
            child: Text(
              'Set level',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
            ),
          ),
          Expanded(
              child: WidgetReused.textFormFieldWidget(
                  'level',
                  (value) =>
                      context.read<AnalyticsToggleBloc>().add(AddLevel(value)),
                  (value) {
            return MethodReused.textError(value, 'level', 2);
          })),
          GestureDetector(
            onTap: () {
              bool validate = AppAnother.key.currentState!.validate();
              if (validate) {
                context.read<AnalyticsToggleBloc>().add(UpdateExericse());
                context
                    .read<AnalyticsToggleBloc>()
                    .add(const ChooseExerciseCardio(true));
                FocusScope.of(context).unfocus();
              }
            },
            child: Container(
                width: double.infinity,
                height: AppDimens.dimens_50,
                margin: const EdgeInsets.only(bottom: AppDimens.dimens_10),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.dimens_20,
                    vertical: AppDimens.dimens_10),
                color: AppColor.whiteColor,
                child: Center(
                  child: Text(
                    'Sequentially',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                        AppFont.medium, AppColor.blackColor),
                  ),
                )),
          ),
        ],
      ),
    ),
  );
}
