import 'package:fitness_app_bloc/common_app/common_widget.dart';
import 'package:fitness_app_bloc/config/config.dart';
import 'package:fitness_app_bloc/reused/reused.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../common_bloc/bloc_anlytics/analytics_bloc.dart';
import 'bloc/action_bloc/action_bloc.dart';

class SetupExerciseScreen extends StatefulWidget {
  const SetupExerciseScreen(this.currentData, {super.key});
  final Map<String, Object?> currentData;

  @override
  State<SetupExerciseScreen> createState() => _SetupExerciseScreenState();
}

class _SetupExerciseScreenState extends State<SetupExerciseScreen> {
  final _key = GlobalKey<FormState>();

  late PageController controller;

  final TextEditingController textController = TextEditingController();
  @override
  void initState() {
    controller = PageController(
      initialPage: widget.currentData.isEmpty
          ? 2
          : widget.currentData[DateFormat('E').format(DateTime.now())]
                      .toString() ==
                  AppString.dayOff
              ? 0
              : 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.now();

    final height = MediaQuery.of(context).size.height;
    //   final width = MediaQuery.of(context).size.width;
    return PageView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      onPageChanged: (value) {
        context.read<ActionBloc>().add(IndexPage(value));
      },
      physics: const NeverScrollableScrollPhysics(),
      children: [
        dayOff(
          context,
          controller,
        ),
        chooseScheduleExercise(
          context.select((AnalyticsBloc bloc) => bloc.state.currentData).isEmpty
              ? ''
              : context.select((AnalyticsBloc bloc) => bloc.state.currentData)[
                  DateFormat('E').format(dateTime)] as String,
          controller,
          context,
        ),
        chooseExerciseMethod(
          controller,
          context,
        ),
        cardio(controller, context, height, textController, _key),
        setCardioExecises(
          controller,
          height,
          context,
        ),
        BlocBuilder<ActionBloc, ActionState>(
          builder: (context, state) {
            return chooseExercise(
              context,
              state,
              controller,
            );
          },
        ),
        showAllExercises(
          context,
          controller,
        ),
        addSuperset(
          controller,
          context,
        ),
        addDropset(
          controller,
          context,
        ),
        setUpSetAndRestTime(_key, context, controller),
      ],
    );
  }
}

//// Day off
////
Widget dayOff(
  BuildContext context,
  PageController controller,
) {
  return normalWidget(
    true,
    0,
    'Day Off',
    dayyOffBody(context),
    controller,
    context,
  );
}

Widget dayyOffBody(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
            child: Text(
              'Day Off',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_30, AppFont.medium, AppColor.blackColor),
            )),
      ),
      Container(
        height: AppDimens.dimens_50,
        margin: const EdgeInsets.symmetric(vertical: AppDimens.dimens_5),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.dimens_20,
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.blueColor1,
                borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
            alignment: Alignment.center,
            child: Text(
              'Done',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_25, AppFont.semiBold, AppColor.whiteColor),
            ),
          ),
        ),
      )
    ],
  );
}

//
//
// Choose Schedule exercise
Widget chooseScheduleExercise(
  String value,
  PageController controller,
  BuildContext context,
) {
  return normalWidget(
    true,
    0,
    'Choose schedule exercise',
    chooseScheduleExerciseBody(controller, value),
    controller,
    context,
  );
}

Widget chooseScheduleExerciseBody(PageController controller, String value) {
  return Column(
    children: [
      Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
          child: Text(
            'Choose Schedule',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_18, AppFont.medium, AppColor.blackColor),
          )),
      Container(
        height: AppAnother.exerciseMethod.length * AppDimens.dimens_70,
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
        child: ListView.builder(
          itemCount: value.split(';').length - 1,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              context.read<ActionBloc>().add(SetExercise(value.split(':')[1]));
              context
                  .read<ActionBloc>()
                  .add(ChooseExerciseMethod(value.split(':')[0]));
              controller.animateToPage(4,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.linear);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: AppDimens.dimens_10),
              width: double.infinity,
              height: AppDimens.dimens_50,
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.dimens_10,
                  horizontal: AppDimens.dimens_20),
              decoration: BoxDecoration(
                  color: AppColor.blueColor1,
                  borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
              child: Text(
                value.split(';')[index].split(':')[0],
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.whiteColor),
              ),
            ),
          ),
        ),
      )
    ],
  );
}
/////
/////
////////////////
//////////////  Choose Exercise Method

Widget chooseExerciseMethod(
  PageController controller,
  BuildContext context,
) {
  return normalWidget(
    true,
    0,
    'Choose exercise method',
    chooseExerciseMethodBody(controller),
    controller,
    context,
  );
}

Widget chooseExerciseMethodBody(PageController controller) {
  return Column(
    children: [
      Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
          child: Text(
            'Let`s choose your exercise method today',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_18, AppFont.medium, AppColor.blackColor),
          )),
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
          child: ListView.builder(
            itemCount: AppAnother.exerciseMethod.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (AppAnother.exerciseMethod[index] == AppString.cardio) {
                  BlocProvider.of<ActionBloc>(context).add(
                      ChooseExerciseMethod(AppAnother.exerciseMethod[index]));
                  controller.animateToPage(3,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.linear);
                } else {
                  BlocProvider.of<ActionBloc>(context).add(
                      ChooseExerciseMethod(AppAnother.exerciseMethod[index]));
                  controller.animateToPage(5,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.linear);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.dimens_5),
                child: Card(
                  color: AppColor.blue2,
                  elevation: AppDimens.dimens_5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                  child: SizedBox(
                    width: double.infinity,
                    height: AppDimens.dimens_60,
                    child: Center(
                      child: Text(
                        AppAnother.exerciseMethod[index],
                        style: AppAnother.textStyleDefault(AppDimens.dimens_22,
                            AppFont.medium, AppColor.blackColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}

////
////////
////////
/////// Cardio

Widget cardio(PageController controller, BuildContext context, double height,
    TextEditingController textEditingController, GlobalKey<FormState> key) {
  ActionState state = context.select((ActionBloc bloc) => bloc.state);
  return normalWidget(
    false,
    2,
    'Cardio set up',
    cardioBody(state, height, context, controller, key),
    controller,
    context,
  );
}

Widget cardioBody(ActionState state, double height, BuildContext context,
    PageController controller, GlobalKey<FormState> key) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
    child: state.cardioMethod == ''
        ? chooseCardioMethod(context, height)
        : state.cardioMethod == AppString.lissCardio
            ? chooseLissCardio(state, controller)
            : chooseHiitCardio(height, context, controller, key),
  );
}

Widget chooseHiitCardio(double height, BuildContext context,
    PageController controller, GlobalKey<FormState> key) {
  ActionState state = context.select(
    (ActionBloc bloc) => bloc.state,
  );

  return Container(
    height: height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top,
    padding: const EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
    child: state.hiitMethod == 'group'
        ? Container(
            height: height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            alignment: Alignment.center,
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: AppDimens.dimens_10),
                    child: Text(
                      'Set level',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                          AppFont.semiBold, AppColor.blackColor),
                    ),
                  ),
                  Expanded(
                      child: WidgetReused.textFormFieldWidget(
                          'level',
                          (value) =>
                              context.read<ActionBloc>().add(SetLevel(value)),
                          (value) {
                    return MethodReused.textError(value, 'level', 2);
                  })),
                  GestureDetector(
                    onTap: () {
                      bool validate = key.currentState!.validate();
                      if (validate) {
                        context
                            .read<ActionBloc>()
                            .add(UpdateExercise(int.parse(state.level)));
                        controller.animateToPage(4,
                            duration: const Duration(microseconds: 1),
                            curve: Curves.linear);
                        FocusScope.of(context).unfocus();
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        height: AppDimens.dimens_50,
                        margin:
                            const EdgeInsets.only(bottom: AppDimens.dimens_10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.dimens_20,
                            vertical: AppDimens.dimens_10),
                        decoration: BoxDecoration(
                            color: AppColor.yellowColor1.withGreen(225),
                            borderRadius:
                                BorderRadius.circular(AppDimens.dimens_15)),
                        child: Center(
                          child: Text(
                            'Sequentially',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )
        : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                context
                    .read<ActionBloc>()
                    .add(const ChooseHiitMethod('sequentially'));
                controller.animateToPage(4,
                    duration: const Duration(microseconds: 1),
                    curve: Curves.linear);
              },
              child: Container(
                  width: double.infinity,
                  height: AppDimens.dimens_50,
                  margin: const EdgeInsets.only(bottom: AppDimens.dimens_10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.dimens_20,
                      vertical: AppDimens.dimens_10),
                  decoration: BoxDecoration(
                      color: AppColor.yellowColor1.withGreen(225),
                      borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                  child: Center(
                    child: Text(
                      'Sequentially',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.medium, AppColor.blackColor),
                    ),
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDimens.dimens_10),
              child: Text(
                'Rest after each exercises',
                textAlign: TextAlign.center,
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_15, AppFont.medium, AppColor.blackColor),
              ),
            ),
            const SizedBox(
              height: AppDimens.dimens_15,
            ),
            GestureDetector(
              onTap: () {
                context.read<ActionBloc>().add(const ChooseHiitMethod('group'));
              },
              child: Container(
                  width: double.infinity,
                  height: AppDimens.dimens_50,
                  margin: const EdgeInsets.only(bottom: AppDimens.dimens_10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.dimens_20,
                      vertical: AppDimens.dimens_10),
                  decoration: BoxDecoration(
                      color: AppColor.yellowColor1.withGreen(225),
                      borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                  child: Center(
                    child: Text(
                      'Group',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.medium, AppColor.blackColor),
                    ),
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDimens.dimens_10),
              child: Text(
                'Rest after each group of exercises',
                textAlign: TextAlign.center,
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_15, AppFont.medium, AppColor.blackColor),
              ),
            ),
          ]),
  );
}

Widget chooseLissCardio(
  ActionState state,
  PageController controller,
) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.dimens_20),
      child: Column(children: [
        SizedBox(
          height: AppDimens.dimens_60 * AppAnother.lissCardioExercise.length,
          child: ListView.builder(
              itemCount: AppAnother.lissCardioExercise.length,
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      CommonWidget.showDialogConfirm(
                        context,
                        '',
                        'Confirm switch to action screen',
                        RouteGenerator.actionScreen,
                        {
                          'method': state.method,
                          'set': '',
                          'rest time': '',
                          'exercise': AppAnother.lissCardioExercise[index],
                          'muscle group': '',
                          'cardioMethod': state.cardioMethod,
                          'hiitMethod': '',
                          'time': '',
                        },
                        true,
                      );
                    },
                    child: Container(
                        width: double.infinity,
                        height: AppDimens.dimens_50,
                        margin:
                            const EdgeInsets.only(bottom: AppDimens.dimens_10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.dimens_20,
                            vertical: AppDimens.dimens_10),
                        decoration: BoxDecoration(
                            color: AppColor.blue3.withRed(175),
                            borderRadius:
                                BorderRadius.circular(AppDimens.dimens_15)),
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
              controller.animateToPage(4,
                  duration: const Duration(microseconds: 1),
                  curve: Curves.linear);
            },
            child: Container(
                width: double.infinity,
                height: AppDimens.dimens_50,
                margin: const EdgeInsets.only(bottom: AppDimens.dimens_10),
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.dimens_20,
                    vertical: AppDimens.dimens_10),
                decoration: BoxDecoration(
                    color: AppColor.blue3.withRed(175),
                    borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                child: Text(
                  AppString.onSiteExercises,
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
                )))
      ]));
}

Widget chooseCardioMethod(BuildContext context, double height) {
  return SizedBox(
    height: height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            context
                .read<ActionBloc>()
                .add(const ChooseCardioMethod(AppString.lissCardio));
          },
          child: Container(
              width: double.infinity,
              height: AppDimens.dimens_50,
              margin: const EdgeInsets.only(bottom: AppDimens.dimens_10),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.dimens_20,
                  vertical: AppDimens.dimens_10),
              decoration: BoxDecoration(
                  color: AppColor.blueGreen,
                  borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
              child: Text(
                AppString.lissCardio,
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              )),
        ),
        GestureDetector(
          onTap: () {
            context
                .read<ActionBloc>()
                .add(const ChooseCardioMethod(AppString.hittCardio));
          },
          child: Container(
              width: double.infinity,
              height: AppDimens.dimens_50,
              margin: const EdgeInsets.only(bottom: AppDimens.dimens_10),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.dimens_20,
                  vertical: AppDimens.dimens_10),
              decoration: BoxDecoration(
                  color: AppColor.blueGreen,
                  borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
              child: Text(
                AppString.hittCardio,
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              )),
        ),
      ],
    ),
  );
}
///// Set Cardio exercise

Widget setCardioExecises(
  PageController controller,
  double height,
  BuildContext context,
) {
  return normalWidget(
    false,
    3,
    'Set cardio exercises',
    setCardioExecisesBody(controller),
    controller,
    context,
  );
}

Widget setCardioExecisesBody(PageController controller) {
  return BlocBuilder<ActionBloc, ActionState>(
    builder: (context, state) {
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
            child: ListView.builder(
                itemCount: AppAnother.cardioExerciseShare.length,
                itemBuilder: (context, indexExercise) {
                  int curentExcercise = state.hiitMethod == 'group'
                      ? state.exercise
                          .split(':')[state.countLevel]
                          .split(',')
                          .indexWhere((element) =>
                              element ==
                              AppAnother.cardioExerciseShare[indexExercise])
                      : state.exercise.split(',').indexWhere(
                            (element) =>
                                element ==
                                AppAnother.cardioExerciseShare[indexExercise],
                          );
                  return GestureDetector(
                      onTap: () {
                        if (state.hiitMethod == 'group') {
                          BlocProvider.of<ActionBloc>(context).add(
                              ChooseExerciseHiitGroup(
                                  AppAnother.cardioExerciseShare[indexExercise],
                                  state.countLevel));
                        } else {
                          if (state.exercise.contains(
                              AppAnother.cardioExerciseShare[indexExercise])) {
                            BlocProvider.of<ActionBloc>(context).add(
                                UnChooseExercise(AppAnother
                                    .cardioExerciseShare[indexExercise]));
                          } else {
                            BlocProvider.of<ActionBloc>(context).add(
                                ChooseExercise(AppAnother
                                    .cardioExerciseShare[indexExercise]));
                          }
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
                                backgroundColor: AppColor.whiteColor,
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
                                backgroundColor: AppColor.whiteColor,
                                child: Text(
                                  (curentExcercise + 1).toString(),
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.semiBold,
                                      AppColor.whiteColor),
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
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
            child: InkWell(
              onTap: () {
                if (state.hiitMethod == 'group') {
                  if (state.countLevel == int.parse(state.level) - 1) {
                    if (state.exercise
                                .split(':')[state.countLevel]
                                .split(',')
                                .length -
                            1 <
                        2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CommonWidget.errorSnackBar('Add more exercise'));
                    } else {
                      controller.animateToPage(6,
                          duration: const Duration(microseconds: 1),
                          curve: Curves.linear);
                    }
                  } else {
                    if (state.exercise
                                .split(':')[state.countLevel]
                                .split(',')
                                .length -
                            1 <
                        2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CommonWidget.errorSnackBar('Add more exercise'));
                    } else {
                      context.read<ActionBloc>().add(UpdateCountLevel());
                    }
                  }
                } else {
                  if (state.exercise.split(',').length - 1 < 2) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        CommonWidget.errorSnackBar('Add more exercise'));
                  } else {
                    controller.animateToPage(6,
                        duration: const Duration(microseconds: 1),
                        curve: Curves.linear);
                  }
                }
              },
              child: Container(
                  width: double.infinity,
                  height: AppDimens.dimens_50,
                  margin: const EdgeInsets.only(bottom: AppDimens.dimens_10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.dimens_20,
                      vertical: AppDimens.dimens_10),
                  decoration: BoxDecoration(
                      color: AppColor.yellowColor1,
                      borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                  child: Center(
                    child: Text(
                      'Next',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.medium, AppColor.blackColor),
                    ),
                  )),
            ),
          )
        ],
      );
    },
  );
}

////////////
//////////
////////////
////////////  Choose Exercise
Widget chooseExercise(
  BuildContext context,
  ActionState state,
  PageController controller,
) {
  return normalWidget(
    false,
    2,
    'Choose exercises',
    chooseExerciseBody(context, controller),
    controller,
    context,
  );
}

Widget chooseExerciseBody(BuildContext context, PageController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: AppDimens.dimens_20),
    child: Column(
      children: [
        Text(
          'Choose exercise',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_18, AppFont.medium, AppColor.blackColor),
        ),
        BlocBuilder<ActionBloc, ActionState>(
          builder: (context, state) {
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (state.muscleGroup
                            .contains(AppAnother.muscleGroup[index])) {
                          BlocProvider.of<ActionBloc>(context).add(
                              UnChooseMuscleGroupSelection(
                                  AppAnother.muscleGroup[index]));
                        } else {
                          BlocProvider.of<ActionBloc>(context).add(
                              ChooseMuscleGroupSelection(
                                  AppAnother.muscleGroup[index]));
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          height: AppDimens.dimens_50,
                          margin: const EdgeInsets.only(
                              bottom: AppDimens.dimens_10,
                              left: AppDimens.dimens_20,
                              right: AppDimens.dimens_20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.dimens_20,
                              vertical: AppDimens.dimens_10),
                          decoration: BoxDecoration(
                              color: AppColor.yellowColor1,
                              borderRadius:
                                  BorderRadius.circular(AppDimens.dimens_15)),
                          child: Text(
                            AppAnother.muscleGroup[index],
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor),
                          )),
                    ),
                    if (state.muscleGroup
                        .contains(AppAnother.muscleGroup[index]))
                      SizedBox(
                        height: AppDimens.dimens_36 *
                            AppAnother.exercise[AppAnother.muscleGroup[index]]!
                                .length,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: AppAnother
                                .exercise[AppAnother.muscleGroup[index]]!
                                .length,
                            itemBuilder: (context, indexExercise) {
                              int curentExcercise =
                                  state.exercise.split(',').indexWhere(
                                        (element) =>
                                            element ==
                                            AppAnother.exercise[
                                                AppAnother.muscleGroup[
                                                    index]]![indexExercise],
                                      );
                              return GestureDetector(
                                  onTap: () {
                                    if (state.exercise.contains(
                                        AppAnother.exercise[
                                                AppAnother.muscleGroup[index]]![
                                            indexExercise])) {
                                      BlocProvider.of<ActionBloc>(context).add(
                                          UnChooseExercise(AppAnother.exercise[
                                              AppAnother.muscleGroup[
                                                  index]]![indexExercise]));
                                    } else {
                                      BlocProvider.of<ActionBloc>(context).add(
                                          ChooseExercise(AppAnother.exercise[
                                              AppAnother.muscleGroup[
                                                  index]]![indexExercise]));
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
                                          width: AppDimens.dimens_10,
                                        ),
                                        if (curentExcercise >= 0)
                                          CircleAvatar(
                                            backgroundColor:
                                                AppColor.whiteColor,
                                            child: Text(
                                              (curentExcercise + 1).toString(),
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
                                                AppColor.whiteColor,
                                            child: Text(
                                              (curentExcercise + 1).toString(),
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_17,
                                                      AppFont.semiBold,
                                                      AppColor.whiteColor),
                                            ),
                                          ),
                                        const SizedBox(
                                          height: AppDimens.dimens_10,
                                        ),
                                        Flexible(
                                          child: Text(
                                            AppAnother.exercise[
                                                AppAnother.muscleGroup[
                                                    index]]![indexExercise],
                                            style: AppAnother.textStyleDefault(
                                              AppDimens.dimens_17,
                                              AppFont.normal,
                                              AppColor.blackColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                      )
                  ],
                ),
                itemCount: AppAnother.muscleGroup.length,
              ),
            );
          },
        ),
        BlocBuilder<ActionBloc, ActionState>(
          builder: (context, state) {
            return InkWell(
              onTap: () {
                if (state.hiitMethod == 'group') {
                  if (int.parse(state.level) == state.countLevel) {
                    if (state.exercise.split(':')[state.countLevel - 1] == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please choose exercise',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.normal,
                                AppColor.redColor1),
                          ),
                        ),
                      );
                    } else {
                      controller.animateToPage(6,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.linear);
                    }
                  } else {
                    context.read<ActionBloc>().add(UpdateCountLevel());
                  }
                } else {
                  if (state.exercise == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please choose exercise',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.normal,
                              AppColor.redColor1),
                        ),
                      ),
                    );
                  } else {
                    controller.animateToPage(6,
                        duration: const Duration(milliseconds: 1),
                        curve: Curves.linear);
                  }
                }
              },
              child: Container(
                height: AppDimens.dimens_50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.purple1,
                    borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                child: Center(
                  child: Text(
                    'Next',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                        AppFont.semiBold, AppColor.whiteColor),
                  ),
                ),
              ),
            );
          },
        )
      ],
    ),
  );
}
///////////////
//////////////
///////////// Show All Exercise

Widget showAllExercises(
  BuildContext context,
  PageController controller,
) {
  bool empty =
      context.select((AnalyticsBloc bloc) => bloc.state.currentData).isEmpty;
  String method = context.select((ActionBloc bloc) => bloc.state.method);
  return normalWidget(
    false,
    empty
        ? method == AppString.cardio
            ? 4
            : 5
        : 1,
    'All exercise',
    showAllExerciseBody(controller, empty, context),
    controller,
    context,
  );
}

Widget showAllExerciseBody(
    PageController controller, bool empty, BuildContext context) {
  String exerciseMethod =
      context.select((ActionBloc bloc) => bloc.state.method);
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_20),
    child: Column(
      children: [
        if (exerciseMethod == AppString.calisthenics ||
            exerciseMethod == AppString.inTheGym)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.dimens_70),
            child: InkWell(
              onTap: () {
                controller.animateToPage(7,
                    duration: const Duration(milliseconds: 1),
                    curve: Curves.linear);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: AppDimens.dimens_50,
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.dimens_10,
                    horizontal: AppDimens.dimens_20),
                decoration: BoxDecoration(
                    color: AppColor.blue3,
                    borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                child: Text(
                  'Superset',
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_20, AppFont.medium, AppColor.whiteColor),
                ),
              ),
            ),
          ),
        if (exerciseMethod == AppString.calisthenics ||
            exerciseMethod == AppString.inTheGym)
          const SizedBox(
            height: AppDimens.dimens_10,
          ),
        if (exerciseMethod == AppString.calisthenics ||
            exerciseMethod == AppString.inTheGym)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.dimens_70),
            child: InkWell(
              onTap: () {
                controller.animateToPage(8,
                    duration: const Duration(milliseconds: 1),
                    curve: Curves.linear);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: AppDimens.dimens_50,
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.dimens_10,
                    horizontal: AppDimens.dimens_20),
                decoration: BoxDecoration(
                    color: AppColor.blue3,
                    borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                child: Text(
                  'Dropset',
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_20, AppFont.medium, AppColor.whiteColor),
                ),
              ),
            ),
          ),
        Expanded(
          child: BlocConsumer<ActionBloc, ActionState>(
            listener: (context, state) {
              if (state.exercise == '') {
                controller.animateToPage(
                    (empty
                        ? state.method == AppString.cardio
                            ? 4
                            : 5
                        : 1),
                    duration: const Duration(microseconds: 1),
                    curve: Curves.linear);
              }
            },
            builder: (context, state) {
              return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.dimens_20,
                      vertical: AppDimens.dimens_20),
                  child: state.hiitMethod == 'group'
                      ? hiitListViewExercise(state)
                      : normalListViewExercise(state));
            },
          ),
        ),
        InkWell(
          onTap: () {
            controller.animateToPage(9,
                duration: const Duration(microseconds: 1),
                curve: Curves.linear);
          },
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: AppDimens.dimens_50,
            padding: const EdgeInsets.symmetric(
                vertical: AppDimens.dimens_10, horizontal: AppDimens.dimens_20),
            decoration: BoxDecoration(
                color: AppColor.purple1.withOpacity(0.5),
                borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
            child: Text(
              'Submit',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_20, AppFont.medium, AppColor.whiteColor),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget hiitListViewExercise(ActionState state) {
  return ListView.builder(
    itemCount: int.parse(state.level),
    itemBuilder: (context, indexLevel) => Column(
      children: [
        Text(
          'Level ${indexLevel + 1}:',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
        ),
        SizedBox(
          height:
              (state.exercise.split(':')[indexLevel].split(',').length - 1) *
                  AppDimens.dimens_42,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  (state.exercise.split(':')[indexLevel].split(',').length - 1),
              itemBuilder: (context, index) => Container(
                    height: AppDimens.dimens_42,
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimens.dimens_5),
                    child: Column(
                      children: [
                        Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext context) {
                                  context.read<ActionBloc>().add(
                                      ChooseExerciseHiitGroup(
                                          state.exercise
                                              .split(':')[indexLevel]
                                              .split(',')[index],
                                          indexLevel));
                                },
                                backgroundColor: AppColor.whiteColor,
                                foregroundColor: AppColor.redColor2,
                                icon: Icons.delete,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              state.exercise
                                  .split(':')[indexLevel]
                                  .split(',')[index],
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.medium,
                                  AppColor.blackColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppDimens.dimens_100,
                          child: Divider(
                            height: AppDimens.dimens_2,
                            color: AppColor.colorGrey4.withOpacity(0.5),
                            thickness: AppDimens.dimens_1,
                          ),
                        )
                      ],
                    ),
                  )),
        )
      ],
    ),
  );
}

Widget normalListViewExercise(ActionState state) {
  return ListView.builder(
    itemCount: state.exercise.split(',').length - 1,
    itemBuilder: (context, index) {
      String newValue = '';
      if (state.exercise.split(',')[index].contains('Superset')) {
        newValue = getSupersetName(state.exercise, index);
      }

      return !state.exercise.split(',')[index].contains(':')
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.dimens_5),
              child: Column(
                children: [
                  Slidable(
                    key: ValueKey(index),
                    endActionPane: ActionPane(
                      extentRatio: 0.2,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            context.read<ActionBloc>().add(UnChooseExercise(
                                state.exercise.split(',')[index]));
                          },
                          backgroundColor: AppColor.whiteColor,
                          foregroundColor: AppColor.redColor2,
                          icon: Icons.delete,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        state.exercise.split(',')[index],
                        style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                            AppFont.medium, AppColor.blackColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppDimens.dimens_100,
                    child: Divider(
                      height: AppDimens.dimens_2,
                      color: AppColor.colorGrey4.withOpacity(0.5),
                      thickness: AppDimens.dimens_1,
                    ),
                  )
                ],
              ),
            )
          : state.exercise.split(',')[index].contains('Superset')
              ? Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: AppDimens.dimens_5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.exercise.split(',')[index].split(':')[0]}:',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                            AppFont.semiBold, AppColor.blackColor),
                      ),
                      Slidable(
                        key: ValueKey(index),
                        endActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                context.read<ActionBloc>().add(UnChooseExercise(
                                    state.exercise.split(',')[index]));
                              },
                              backgroundColor: AppColor.whiteColor,
                              foregroundColor: AppColor.redColor2,
                              icon: Icons.delete,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            newValue,
                            textAlign: TextAlign.center,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: AppDimens.dimens_100,
                          child: Divider(
                            height: AppDimens.dimens_2,
                            color: AppColor.colorGrey4.withOpacity(0.5),
                            thickness: AppDimens.dimens_1,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppDimens.dimens_5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.exercise.split(',')[index].split(':')[0]}:',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                            AppFont.semiBold, AppColor.blackColor),
                      ),
                      Slidable(
                        key: ValueKey(index),
                        endActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                context.read<ActionBloc>().add(UnChooseExercise(
                                    state.exercise.split(',')[index]));
                              },
                              backgroundColor: AppColor.whiteColor,
                              foregroundColor: AppColor.redColor2,
                              icon: Icons.delete,
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            state.exercise.split(',')[index].split(':')[1],
                            textAlign: TextAlign.center,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: AppDimens.dimens_100,
                          child: Divider(
                            height: AppDimens.dimens_2,
                            color: AppColor.colorGrey4.withOpacity(0.5),
                            thickness: AppDimens.dimens_1,
                          ),
                        ),
                      )
                    ],
                  ),
                );
    },
  );
}

///////////// Add Super Set
Widget addSuperset(
  PageController controller,
  BuildContext context,
) {
  return normalWidget(
    false,
    6,
    'Add superset',
    addSuperSetBody(controller),
    controller,
    context,
  );
}

Widget addSuperSetBody(PageController controller) {
  return BlocBuilder<ActionBloc, ActionState>(
    builder: (context, state) {
      List<String> newList = [];
      for (int i = 0; i < state.exercise.split(',').length - 1; i++) {
        if (!state.exercise.split(',')[i].contains(':')) {
          newList.add(state.exercise.split(',')[i]);
        }
      }

      return Column(
        children: [
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: AppDimens.dimens_20),
              child: newList.isEmpty
                  ? Center(
                      child: Text(
                        'Empty',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_30,
                            AppFont.semiBold, AppColor.blackColor),
                      ),
                    )
                  : ListView.builder(
                      itemCount: newList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimens.dimens_60),
                              child: InkWell(
                                onTap: () {
                                  context.read<ActionBloc>().add(
                                      AddTemporarySuperSet(newList[index]));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: AppDimens.dimens_50,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppDimens.dimens_10,
                                      horizontal: AppDimens.dimens_20),
                                  decoration: BoxDecoration(
                                      color: state.temporarySuperset
                                              .contains(newList[index])
                                          ? AppColor.yellowColor1
                                          : AppColor.blueColor1,
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.dimens_15)),
                                  child: Text(
                                    newList[index],
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_18,
                                        AppFont.medium,
                                        AppColor.whiteColor),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: AppDimens.dimens_15,
                            )
                          ],
                        );
                      },
                    ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
            child: InkWell(
              onTap: () {
                if (state.temporarySuperset == '' ||
                    state.temporarySuperset.split(';').length - 1 < 2 ||
                    state.temporarySuperset.split(';').length - 1 > 3) {
                  (state.temporarySuperset == '' ||
                          state.temporarySuperset.split(';').length - 1 < 2)
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          CommonWidget.errorSnackBar('Please choose exercise'))
                      : ScaffoldMessenger.of(context).showSnackBar(
                          CommonWidget.errorSnackBar(
                              'Please choose correct exercise'));
                } else {
                  controller.animateToPage(6,
                      duration: const Duration(microseconds: 1),
                      curve: Curves.linear);

                  context.read<ActionBloc>().add(UpdateSuperSet());
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: AppDimens.dimens_50,
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.dimens_10,
                    horizontal: AppDimens.dimens_20),
                decoration: BoxDecoration(
                    color: AppColor.greenColor,
                    borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                child: Text(
                  'Submit',
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_22, AppFont.medium, AppColor.whiteColor),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppDimens.dimens_10,
          )
        ],
      );
    },
  );
}

/////////
////////
////////
/////// Add Drop Set
Widget addDropset(
  PageController controller,
  BuildContext context,
) {
  String value = context.select(
    (ActionBloc bloc) => bloc.state.temporaryDropset,
  );
  return normalWidget(
    false,
    6,
    'Add dropset',
    addDropsetBody(value, controller, context),
    controller,
    context,
  );
}

Widget addDropsetBody(
    String value, PageController controller, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.dimens_20),
            child:
                BlocBuilder<ActionBloc, ActionState>(builder: (context, state) {
              List<String> newList = [];
              for (int i = 0; i < state.exercise.split(',').length - 1; i++) {
                if (!state.exercise.split(',')[i].contains(':')) {
                  newList.add(state.exercise.split(',')[i]);
                }
              }

              return newList.isEmpty
                  ? Center(
                      child: Text(
                        'Empty',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_30,
                            AppFont.semiBold, AppColor.blackColor),
                      ),
                    )
                  : ListView.builder(
                      itemCount: newList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimens.dimens_60),
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<ActionBloc>()
                                      .add(AddTemporaryDropSet(newList[index]));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: AppDimens.dimens_50,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppDimens.dimens_10,
                                      horizontal: AppDimens.dimens_20),
                                  decoration: BoxDecoration(
                                      color: state.temporaryDropset
                                              .contains(newList[index])
                                          ? AppColor.yellowColor1
                                          : AppColor.blueColor1,
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.dimens_15)),
                                  child: Text(
                                    newList[index],
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_18,
                                        AppFont.medium,
                                        AppColor.whiteColor),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: AppDimens.dimens_15,
                            )
                          ],
                        );
                      },
                    );
            })),
      ),
      Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
          child: InkWell(
            onTap: () {
              if (value == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                    CommonWidget.errorSnackBar('Please choose exercise'));
              } else {
                controller.animateToPage(6,
                    duration: const Duration(microseconds: 1),
                    curve: Curves.linear);
                context.read<ActionBloc>().add(UpdateDropSet());
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: AppDimens.dimens_50,
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.dimens_10,
                  horizontal: AppDimens.dimens_20),
              decoration: BoxDecoration(
                  color: AppColor.greenColor,
                  borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
              child: Text(
                'Submit',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_22, AppFont.medium, AppColor.whiteColor),
              ),
            ),
          )),
      const SizedBox(
        height: AppDimens.dimens_10,
      )
    ],
  );
}

/////////
///
/// Set Up Set And Rest Time
Widget setUpSetAndRestTime(
  GlobalKey<FormState> key,
  BuildContext context,
  PageController controller,
) {
  return normalWidget(
    false,
    6,
    'Set up set and rest time',
    setUpSetAndRestTimeBody(key, context, controller),
    controller,
    context,
  );
}

Widget setUpSetAndRestTimeBody(
    GlobalKey<FormState> key, BuildContext context, PageController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_20),
    child: BlocBuilder<ActionBloc, ActionState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.method != AppString.cardio)
              Expanded(child: fieldAnotherMethod(key)),
            if (state.method == AppString.cardio)
              Expanded(child: fieldCardioMethod(state, context, key)),
            GestureDetector(
              onTap: () {
                final isValid = key.currentState!.validate();

                if (isValid) {
                  CommonWidget.showDialogConfirm(
                    context,
                    '',
                    'Confirm switch to action screen',
                    RouteGenerator.actionScreen,
                    {
                      'method': state.method,
                      'set': state.set,
                      'rest time': state.restTime,
                      'exercise': state.exercise,
                      'muscle group': state.muscleGroup,
                      'cardioMethod': state.cardioMethod,
                      'hiitMethod': state.hiitMethod,
                      'time': state.time,
                    },
                    true,
                  );
                }
              },
              child: Container(
                height: AppDimens.dimens_50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.orangeColor1,
                    borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                child: Center(
                  child: Text(
                    'Next',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                        AppFont.semiBold, AppColor.whiteColor),
                  ),
                ),
              ),
            )
          ],
        );
      },
    ),
  );
}

Widget fieldCardioMethod(
    ActionState state, BuildContext context, GlobalKey<FormState> key) {
  return Form(
    key: key,
    child: Column(
      children: [
        Text(
          'Import time${state.cardioMethod == AppString.hittCardio ? ',rest time' : ''} and set',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
        ),
        const SizedBox(
          height: AppDimens.dimens_10,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Text(
                'Time',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
              const SizedBox(
                width: AppDimens.dimens_20,
              ),
              Expanded(
                child: WidgetReused.textFormFieldWidget('time', (value) {
                  context.read<ActionBloc>().add(ChooseTime(value));
                }, (value) {
                  return MethodReused.textError(state.time, 'time', 0);
                }),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: AppDimens.dimens_10,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Text(
                state.hiitMethod == 'group' ? 'Set of level' : 'Set',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
              const SizedBox(
                width: AppDimens.dimens_20,
              ),
              Expanded(
                child: WidgetReused.textFormFieldWidget('Set', (value) {
                  context.read<ActionBloc>().add(ChooseSetCardio(value));
                }, (value) {
                  return MethodReused.textError(
                    state.set,
                    'set',
                    0,
                  );
                }),
              ),
            ],
          ),
        ),
        if (state.cardioMethod == AppString.hittCardio)
          const SizedBox(
            height: AppDimens.dimens_10,
          ),
        state.cardioMethod == AppString.hittCardio
            ? SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Text(
                      'Rest time',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.medium, AppColor.blackColor),
                    ),
                    const SizedBox(
                      width: AppDimens.dimens_20,
                    ),
                    Expanded(
                      child: WidgetReused.textFormFieldWidget('Rest time',
                          (value) {
                        context
                            .read<ActionBloc>()
                            .add(ChooseRestTimeCardio(value));
                      }, (value) {
                        return state.cardioMethod == AppString.hittCardio
                            ? MethodReused.textError(
                                state.restTime,
                                'rest time',
                                0,
                              )
                            : null;
                      }),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}

Widget fieldAnotherMethod(GlobalKey<FormState> key) {
  return Column(
    children: [
      Text(
        'Import set and rest time',
        style: AppAnother.textStyleDefault(
            AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
      ),
      const SizedBox(
        height: AppDimens.dimens_10,
      ),
      Expanded(
        child: Form(
            key: key,
            child: BlocConsumer<ActionBloc, ActionState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      String newValue = '';
                      if (state.exercise
                          .split(',')[index]
                          .contains('Superset')) {
                        newValue = getSupersetName(state.exercise, index);
                      }
                      String exercise = state.exercise.split(',')[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          !state.exercise.split(',')[index].contains(':')
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppDimens.dimens_5),
                                  child: Text(
                                    state.exercise.split(',')[index],
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_20,
                                        AppFont.medium,
                                        AppColor.blackColor),
                                  ),
                                )
                              : state.exercise
                                      .split(',')[index]
                                      .contains('Superset')
                                  ? Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: AppDimens.dimens_5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${state.exercise.split(',')[index].split(':')[0]}:',
                                            style: AppAnother.textStyleDefault(
                                                AppDimens.dimens_20,
                                                AppFont.medium,
                                                AppColor.blackColor),
                                          ),
                                          Center(
                                            child: Text(
                                              newValue,
                                              textAlign: TextAlign.center,
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_20,
                                                      AppFont.medium,
                                                      AppColor.blackColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: AppDimens.dimens_5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${state.exercise.split(',')[index].split(':')[0]}:',
                                            style: AppAnother.textStyleDefault(
                                                AppDimens.dimens_20,
                                                AppFont.medium,
                                                AppColor.blackColor),
                                          ),
                                          Center(
                                            child: Text(
                                              state.exercise
                                                  .split(',')[index]
                                                  .split(':')[1],
                                              textAlign: TextAlign.center,
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_20,
                                                      AppFont.medium,
                                                      AppColor.blackColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                          const SizedBox(
                            height: AppDimens.dimens_5,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  'Set',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.medium,
                                      AppColor.blackColor),
                                ),
                                const SizedBox(
                                  width: AppDimens.dimens_20,
                                ),
                                Expanded(
                                  child: WidgetReused.textFormFieldWidget('set',
                                      (value) {
                                    BlocProvider.of<ActionBloc>(context).add(
                                        ChooseSet(
                                            value,
                                            index,
                                            state.exercise.split(',').length -
                                                1,
                                            exercise));
                                  }, (value) {
                                    return MethodReused.textError(
                                        value, 'set', 1);
                                  }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppDimens.dimens_10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  'Rest time',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.medium,
                                      AppColor.blackColor),
                                ),
                                const SizedBox(
                                  width: AppDimens.dimens_20,
                                ),
                                Expanded(
                                  child: WidgetReused.textFormFieldWidget(
                                      'rest time', (value) {
                                    BlocProvider.of<ActionBloc>(context).add(
                                        ChooseRestTime(
                                            value,
                                            index,
                                            state.exercise.split(',').length -
                                                1,
                                            exercise));
                                  }, (value) {
                                    return MethodReused.textError(
                                        value, 'rest time', 1);
                                  }),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: AppDimens.dimens_10,
                          ),
                          if (exercise.contains('Dropset'))
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text(
                                    'Set drop',
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_20,
                                        AppFont.medium,
                                        AppColor.blackColor),
                                  ),
                                  const SizedBox(
                                    width: AppDimens.dimens_20,
                                  ),
                                  Expanded(
                                      child: WidgetReused.textFormFieldWidget(
                                          'set drop', (value) {
                                    BlocProvider.of<ActionBloc>(context).add(
                                        ChooseSetDrop(
                                            value,
                                            index,
                                            state.exercise.split(',').length -
                                                1,
                                            exercise));
                                  }, (value) {
                                    return MethodReused.textError(
                                        value, 'set drop', 1);
                                  })),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: AppDimens.dimens_10,
                          ),
                          if (exercise.contains('Dropset'))
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Text(
                                    'Rest drop',
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_20,
                                        AppFont.medium,
                                        AppColor.blackColor),
                                  ),
                                  const SizedBox(
                                    width: AppDimens.dimens_20,
                                  ),
                                  Expanded(
                                      child: WidgetReused.textFormFieldWidget(
                                          'rest drop', (value) {
                                    BlocProvider.of<ActionBloc>(context).add(
                                        ChooseRestTimeDrop(
                                            value,
                                            index,
                                            state.exercise.split(',').length -
                                                1,
                                            exercise));
                                  }, (value) {
                                    return MethodReused.textError(
                                        value, 'rest drop', 1);
                                  })),
                                ],
                              ),
                            )
                        ],
                      );
                    },
                    itemCount: state.exercise.split(',').length - 1,
                  );
                })),
      ),
    ],
  );
}

///// Normal Widget
////
////
////
////
////
////
///
Widget normalWidget(
  bool result,
  int page,
  String appBarTitle,
  Widget widget,
  PageController controller,
  BuildContext context,
) {
  ActionState state = context.select((ActionBloc bloc) => bloc.state);
  return WillPopScope(
    onWillPop: () async {
      if (page == 2) {
        if (state.hiitMethod != '') {
          context.read<ActionBloc>().add(const ChooseHiitMethod(''));
        } else {
          state.cardioMethod != ''
              ? context.read<ActionBloc>().add(const ChooseCardioMethod(''))
              : controller.animateToPage(2,
                  duration: const Duration(microseconds: 1),
                  curve: Curves.linear);
        }

        context.read<ActionBloc>().add(ResetRemaining());
      } else if (page == 6) {
        if (state.time != '' || state.restTime != '' || state.set != '') {
          context.read<ActionBloc>().add(ResetField());
        }
      } else if (page == 3) {
        if (state.hiitMethod == 'group') {
          if (state.countLevel == 0) {
            controller.animateToPage(page,
                duration: const Duration(microseconds: 1),
                curve: Curves.linear);
          } else {
            context.read<ActionBloc>().add(ReturnCountLevel());
          }
        } else {
          controller.animateToPage(page,
              duration: const Duration(microseconds: 1), curve: Curves.linear);
        }
      } else if (page == 5) {
        if (state.method == AppString.inTheGym ||
            state.method == AppString.calisthenics) {
          context.read<ActionBloc>().add(ResetExerciseToNormal());
          controller.animateToPage(page,
              duration: const Duration(microseconds: 1), curve: Curves.linear);
        }
      } else {
        result
            ? Navigator.of(context).pop()
            : controller.animateToPage(page,
                duration: const Duration(microseconds: 1),
                curve: Curves.linear);
      }
      return result;
    },
    child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: AppDimens.dimens_0,
          backgroundColor: AppColor.whiteColor,
          leading: IconButton(
              onPressed: () {
                if (page == 2) {
                  if (state.hiitMethod != '') {
                    context.read<ActionBloc>().add(const ChooseHiitMethod(''));
                  } else {
                    state.cardioMethod != ''
                        ? context
                            .read<ActionBloc>()
                            .add(const ChooseCardioMethod(''))
                        : controller.animateToPage(2,
                            duration: const Duration(microseconds: 1),
                            curve: Curves.linear);
                  }

                  context.read<ActionBloc>().add(ResetRemaining());
                } else if (page == 6) {
                  if (state.time != '' ||
                      state.restTime != '' ||
                      state.set != '') {
                    context.read<ActionBloc>().add(ResetField());
                  }
                  controller.animateToPage(page,
                      duration: const Duration(microseconds: 1),
                      curve: Curves.linear);
                } else if (page == 3) {
                  if (state.hiitMethod == 'group') {
                    if (state.countLevel == 0) {
                      controller.animateToPage(page,
                          duration: const Duration(microseconds: 1),
                          curve: Curves.linear);
                    } else {
                      context.read<ActionBloc>().add(ReturnCountLevel());
                    }
                  } else {
                    controller.animateToPage(page,
                        duration: const Duration(microseconds: 1),
                        curve: Curves.linear);
                  }
                } else if (page == 5) {
                  if (state.method == AppString.inTheGym ||
                      state.method == AppString.calisthenics) {
                    context.read<ActionBloc>().add(ResetExerciseToNormal());
                    controller.animateToPage(page,
                        duration: const Duration(microseconds: 1),
                        curve: Curves.linear);
                  }
                } else {
                  result
                      ? Navigator.of(context).pop()
                      : controller.animateToPage(page,
                          duration: const Duration(microseconds: 1),
                          curve: Curves.linear);
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.blackColor,
              )),
          title: Text(
            appBarTitle,
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
          ),
          centerTitle: true,
        ),
        body: widget),
  );
}

String getSupersetName(String value, int index) {
  String newValue = '';
  for (int i = 0;
      i < value.split(',')[index].split(':')[1].split(';').length - 1;
      i++) {
    if (i == value.split(',')[index].split(':')[1].split(';').length - 2) {
      newValue = newValue + value.split(',')[index].split(':')[1].split(';')[i];
    } else {
      newValue =
          '$newValue${value.split(',')[index].split(':')[1].split(';')[i]}+';
    }
  }
  return newValue;
}
