import 'package:fitness_app_bloc/common_app/common_widget.dart';

import 'package:fitness_app_bloc/config/config.dart';
import 'package:fitness_app_bloc/reused/widget_reused.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../../common_bloc/bloc_anlytics/analytics_bloc.dart';
import 'bloc/action_bloc/action_bloc.dart';

class SetupExerciseScreen extends StatelessWidget {
  SetupExerciseScreen({super.key});

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.now();
    final PageController controller = PageController(
      initialPage: context
              .select((AnalyticsBloc bloc) => bloc.state.currentData)
              .isEmpty
          ? 2
          : context
                      .select((AnalyticsBloc bloc) => bloc.state.currentData)[
                          DateFormat('E').format(dateTime)]
                      .toString() ==
                  AppString.dayOff
              ? 0
              : 1,
    );

    return PageView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      onPageChanged: (value) {
        context.read<ActionBloc>().add(IndexPage(value));
      },
      physics: const NeverScrollableScrollPhysics(),
      children: [
        dayOff(context),
        chooseScheduleExercise(
            context
                    .select((AnalyticsBloc bloc) => bloc.state.currentData)
                    .isEmpty
                ? ''
                : context.select((AnalyticsBloc bloc) => bloc.state
                    .currentData)[DateFormat('E').format(dateTime)] as String,
            controller,
            context),
        chooseExercise(controller, context),
        BlocBuilder<ActionBloc, ActionState>(
          builder: (context, state) {
            return chooseMuscleGroup(context, state, controller);
          },
        ),
        setUpSuperDropSet(
          context,
          controller,
        ),
        addSuperset(controller, context),
        addDropset(controller, context),
        setUpSetAndRestTime(_key, context, controller),
      ],
    );
  }
}

Widget addDropset(PageController controller, BuildContext context) {
  String value = context.select(
    (ActionBloc bloc) => bloc.state.temporaryDropset,
  );
  return WillPopScope(
    onWillPop: () async {
      controller.animateToPage(4,
          duration: const Duration(milliseconds: 1), curve: Curves.linear);
      return false;
    },
    child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: AppDimens.dimens_0,
          backgroundColor: AppColor.whiteColor,
          leading: IconButton(
              onPressed: () {
                controller.animateToPage(4,
                    duration: const Duration(milliseconds: 1),
                    curve: Curves.linear);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.blackColor,
              )),
          title: Text(
            'Setup Exercise',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppDimens.dimens_20),
                  child: BlocBuilder<ActionBloc, ActionState>(
                      builder: (context, state) {
                    List<String> newList = [];
                    for (int i = 0;
                        i < state.exercise.split(',').length - 1;
                        i++) {
                      if (!state.exercise.split(',')[i].contains(':')) {
                        newList.add(state.exercise.split(',')[i]);
                      }
                    }

                    return newList.isEmpty
                        ? Center(
                            child: Text(
                              'Empty',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_30,
                                  AppFont.semiBold,
                                  AppColor.blackColor),
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
                                            AddTemporaryDropSet(
                                                newList[index]));
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
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
                child: InkWell(
                  onTap: () {
                    if (value == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                          CommonWidget.errorSnackBar('Please choose exercise'));
                    } else {
                      controller.animateToPage(4,
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
                        borderRadius:
                            BorderRadius.circular(AppDimens.dimens_15)),
                    child: Text(
                      'Submit',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_22,
                          AppFont.medium, AppColor.whiteColor),
                    ),
                  ),
                )),
            const SizedBox(
              height: AppDimens.dimens_10,
            )
          ],
        )),
  );
}

Widget addSuperset(PageController controller, BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      controller.animateToPage(4,
          duration: const Duration(milliseconds: 1), curve: Curves.linear);
      return false;
    },
    child: Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: AppDimens.dimens_0,
        backgroundColor: AppColor.whiteColor,
        leading: IconButton(
            onPressed: () {
              controller.animateToPage(4,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.linear);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.blackColor,
            )),
        title: Text(
          'Setup Exercise',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ActionBloc, ActionState>(
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
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_30,
                                AppFont.semiBold,
                                AppColor.blackColor),
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
                              CommonWidget.errorSnackBar(
                                  'Please choose exercise'))
                          : ScaffoldMessenger.of(context).showSnackBar(
                              CommonWidget.errorSnackBar(
                                  'Please choose correct exercise'));
                    } else {
                      controller.animateToPage(4,
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
                        borderRadius:
                            BorderRadius.circular(AppDimens.dimens_15)),
                    child: Text(
                      'Submit',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_22,
                          AppFont.medium, AppColor.whiteColor),
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
      ),
    ),
  );
}

Widget setUpSuperDropSet(
  BuildContext context,
  PageController controller,
) {
  bool empty =
      context.select((AnalyticsBloc bloc) => bloc.state.currentData).isEmpty;
  return WillPopScope(
    onWillPop: () async {
      controller.animateToPage((empty ? 3 : 1),
          duration: const Duration(microseconds: 1), curve: Curves.linear);

      return false;
    },
    child: Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: AppDimens.dimens_0,
        backgroundColor: AppColor.whiteColor,
        leading: IconButton(
            onPressed: () {
              controller.animateToPage((empty ? 3 : 1),
                  duration: const Duration(microseconds: 1),
                  curve: Curves.linear);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.blackColor,
            )),
        title: Text(
          'Setup Exercise',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_20),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDimens.dimens_70),
              child: InkWell(
                onTap: () {
                  controller.animateToPage(5,
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
                    style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                        AppFont.medium, AppColor.whiteColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppDimens.dimens_10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDimens.dimens_70),
              child: InkWell(
                onTap: () {
                  controller.animateToPage(6,
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
                    style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                        AppFont.medium, AppColor.whiteColor),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocConsumer<ActionBloc, ActionState>(
                listener: (context, state) {
                  if (state.exercise == '') {
                    controller.animateToPage((empty ? 3 : 1),
                        duration: const Duration(microseconds: 1),
                        curve: Curves.linear);
                  }
                },
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_20,
                        vertical: AppDimens.dimens_20),
                    child: ListView.builder(
                      itemCount: state.exercise.split(',').length - 1,
                      itemBuilder: (context, index) {
                        String newValue = '';
                        if (state.exercise
                            .split(',')[index]
                            .contains('Superset')) {
                          newValue = getSupersetName(state.exercise, index);
                        }

                        return !state.exercise.split(',')[index].contains(':')
                            ? Container(
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
                                                  UnChooseExercise(state
                                                      .exercise
                                                      .split(',')[index]));
                                            },
                                            backgroundColor:
                                                AppColor.whiteColor,
                                            foregroundColor: AppColor.redColor2,
                                            icon: Icons.delete,
                                          )
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          state.exercise.split(',')[index],
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
                                        color: AppColor.colorGrey4
                                            .withOpacity(0.5),
                                        thickness: AppDimens.dimens_1,
                                      ),
                                    )
                                  ],
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
                                              AppFont.semiBold,
                                              AppColor.blackColor),
                                        ),
                                        Slidable(
                                          key: ValueKey(index),
                                          endActionPane: ActionPane(
                                            extentRatio: 0.2,
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                onPressed:
                                                    (BuildContext context) {
                                                  context
                                                      .read<ActionBloc>()
                                                      .add(UnChooseExercise(
                                                          state.exercise.split(
                                                              ',')[index]));
                                                },
                                                backgroundColor:
                                                    AppColor.whiteColor,
                                                foregroundColor:
                                                    AppColor.redColor2,
                                                icon: Icons.delete,
                                              )
                                            ],
                                          ),
                                          child: Center(
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
                                        ),
                                        Center(
                                          child: SizedBox(
                                            width: AppDimens.dimens_100,
                                            child: Divider(
                                              height: AppDimens.dimens_2,
                                              color: AppColor.colorGrey4
                                                  .withOpacity(0.5),
                                              thickness: AppDimens.dimens_1,
                                            ),
                                          ),
                                        )
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
                                              AppFont.semiBold,
                                              AppColor.blackColor),
                                        ),
                                        Slidable(
                                          key: ValueKey(index),
                                          endActionPane: ActionPane(
                                            extentRatio: 0.2,
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                onPressed:
                                                    (BuildContext context) {
                                                  context
                                                      .read<ActionBloc>()
                                                      .add(UnChooseExercise(
                                                          state.exercise.split(
                                                              ',')[index]));
                                                },
                                                backgroundColor:
                                                    AppColor.whiteColor,
                                                foregroundColor:
                                                    AppColor.redColor2,
                                                icon: Icons.delete,
                                              )
                                            ],
                                          ),
                                          child: Center(
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
                                        ),
                                        Center(
                                          child: SizedBox(
                                            width: AppDimens.dimens_100,
                                            child: Divider(
                                              height: AppDimens.dimens_2,
                                              color: AppColor.colorGrey4
                                                  .withOpacity(0.5),
                                              thickness: AppDimens.dimens_1,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                      },
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                controller.animateToPage(7,
                    duration: const Duration(microseconds: 1),
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
      ),
    ),
  );
}

Widget chooseScheduleExercise(
    String value, PageController controller, BuildContext context) {
  return Scaffold(
    backgroundColor: AppColor.whiteColor,
    appBar: AppBar(
      automaticallyImplyLeading: false,
      elevation: AppDimens.dimens_0,
      backgroundColor: AppColor.whiteColor,
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.blackColor,
          )),
      title: Text(
        'Setup Exercise',
        style: AppAnother.textStyleDefault(
            AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
      ),
      centerTitle: true,
    ),
    body: Column(
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
                context
                    .read<ActionBloc>()
                    .add(SetExercise(value.split(':')[1]));
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
    ),
  );
}

Widget dayOff(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColor.whiteColor,
    appBar: AppBar(
      automaticallyImplyLeading: false,
      elevation: AppDimens.dimens_0,
      backgroundColor: AppColor.whiteColor,
      leading: (context.read<ActionBloc>().index == 5 ||
              context.read<ActionBloc>().index == 6)
          ? Container()
          : IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.blackColor,
              )),
      title: Text(
        'Setup Exercise',
        style: AppAnother.textStyleDefault(
            AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
      ),
      centerTitle: true,
    ),
    body: Column(
      children: [
        Expanded(
          child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.dimens_20,
                  vertical: AppDimens.dimens_10),
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
    ),
  );
}

Widget chooseExercise(PageController controller, BuildContext context) {
  return Scaffold(
    backgroundColor: AppColor.whiteColor,
    appBar: AppBar(
      automaticallyImplyLeading: false,
      elevation: AppDimens.dimens_0,
      backgroundColor: AppColor.whiteColor,
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.blackColor,
          )),
      title: Text(
        'Setup Exercise',
        style: AppAnother.textStyleDefault(
            AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
      ),
      centerTitle: true,
    ),
    body: Column(
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
                  BlocProvider.of<ActionBloc>(context).add(
                      ChooseExerciseMethod(AppAnother.exerciseMethod[index]));
                  controller.animateToPage(3,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.linear);
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.dimens_5),
                  child: Card(
                    color: AppColor.blue2,
                    elevation: AppDimens.dimens_5,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.dimens_15)),
                    child: SizedBox(
                      width: double.infinity,
                      height: AppDimens.dimens_60,
                      child: Center(
                        child: Text(
                          AppAnother.exerciseMethod[index],
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_22,
                              AppFont.medium,
                              AppColor.blackColor),
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
    ),
  );
}

Widget chooseMuscleGroup(
    BuildContext context, ActionState state, PageController controller) {
  return WillPopScope(
    onWillPop: () async {
      controller.animateToPage(2,
          duration: const Duration(microseconds: 1), curve: Curves.linear);
      return false;
    },
    child: Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: AppDimens.dimens_0,
        backgroundColor: AppColor.whiteColor,
        leading: IconButton(
            onPressed: () {
              controller.animateToPage(2,
                  duration: const Duration(microseconds: 1),
                  curve: Curves.linear);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.blackColor,
            )),
        title: Text(
          'Setup Exercise',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_20),
        child: Column(
          children: [
            Text(
              'Choose exercise',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_18, AppFont.medium, AppColor.blackColor),
            ),
            Expanded(
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
                              bottom: AppDimens.dimens_10),
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
                                    padding: const EdgeInsets.only(
                                        left: AppDimens.dimens_2,
                                        bottom: AppDimens.dimens_2,
                                        top: AppDimens.dimens_2),
                                    child: Row(
                                      children: [
                                        if (curentExcercise >= 0)
                                          CircleAvatar(
                                            backgroundColor:
                                                AppColor.whiteColor,
                                            child: Text(
                                              (curentExcercise + 1).toString(),
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_20,
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
                                                      AppDimens.dimens_20,
                                                      AppFont.semiBold,
                                                      AppColor.whiteColor),
                                            ),
                                          ),
                                        const SizedBox(
                                          height: AppDimens.dimens_10,
                                        ),
                                        Text(
                                            AppAnother.exercise[
                                                AppAnother.muscleGroup[
                                                    index]]![indexExercise],
                                            style: AppAnother.textStyleDefault(
                                              AppDimens.dimens_20,
                                              AppFont.normal,
                                              AppColor.blackColor,
                                            )),
                                      ],
                                    ),
                                  ));
                            }),
                      )
                  ],
                ),
                itemCount: AppAnother.muscleGroup.length,
              ),
            ),
            InkWell(
              onTap: () {
                if (state.exercise == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please choose exercise',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                            AppFont.normal, AppColor.redColor1),
                      ),
                    ),
                  );
                } else {
                  controller.animateToPage(4,
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.linear);
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
            )
          ],
        ),
      ),
    ),
  );
}

Widget setUpSetAndRestTime(
    GlobalKey<FormState> key, BuildContext context, PageController controller) {
  return WillPopScope(
    onWillPop: () async {
      controller.animateToPage(4,
          duration: const Duration(milliseconds: 1), curve: Curves.linear);
      return false;
    },
    child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: AppDimens.dimens_0,
          backgroundColor: AppColor.whiteColor,
          leading: IconButton(
              onPressed: () {
                controller.animateToPage(4,
                    duration: const Duration(milliseconds: 1),
                    curve: Curves.linear);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.blackColor,
              )),
          title: Text(
            'Setup Exercise',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  newValue =
                                      getSupersetName(state.exercise, index);
                                }
                                String exercise =
                                    state.exercise.split(',')[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    !state.exercise
                                            .split(',')[index]
                                            .contains(':')
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: AppDimens.dimens_5),
                                            child: Text(
                                              state.exercise.split(',')[index],
                                              style:
                                                  AppAnother.textStyleDefault(
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical:
                                                            AppDimens.dimens_5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${state.exercise.split(',')[index].split(':')[0]}:',
                                                      style: AppAnother
                                                          .textStyleDefault(
                                                              AppDimens
                                                                  .dimens_20,
                                                              AppFont.medium,
                                                              AppColor
                                                                  .blackColor),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        newValue,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppAnother
                                                            .textStyleDefault(
                                                                AppDimens
                                                                    .dimens_20,
                                                                AppFont.medium,
                                                                AppColor
                                                                    .blackColor),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical:
                                                            AppDimens.dimens_5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${state.exercise.split(',')[index].split(':')[0]}:',
                                                      style: AppAnother
                                                          .textStyleDefault(
                                                              AppDimens
                                                                  .dimens_20,
                                                              AppFont.medium,
                                                              AppColor
                                                                  .blackColor),
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        state.exercise
                                                            .split(',')[index]
                                                            .split(':')[1],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppAnother
                                                            .textStyleDefault(
                                                                AppDimens
                                                                    .dimens_20,
                                                                AppFont.medium,
                                                                AppColor
                                                                    .blackColor),
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
                                            child: WidgetReused.textFieldWidget(
                                                'set', (value) {
                                              BlocProvider.of<ActionBloc>(
                                                      context)
                                                  .add(ChooseSet(
                                                      value,
                                                      index,
                                                      state.exercise
                                                              .split(',')
                                                              .length -
                                                          1,
                                                      exercise));
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
                                            child: WidgetReused.textFieldWidget(
                                                'rest time', (value) {
                                              BlocProvider.of<ActionBloc>(
                                                      context)
                                                  .add(ChooseRestTime(
                                                      value,
                                                      index,
                                                      state.exercise
                                                              .split(',')
                                                              .length -
                                                          1,
                                                      exercise));
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
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_20,
                                                      AppFont.medium,
                                                      AppColor.blackColor),
                                            ),
                                            const SizedBox(
                                              width: AppDimens.dimens_20,
                                            ),
                                            Expanded(
                                              child:
                                                  WidgetReused.textFieldWidget(
                                                      'set drop', (value) {
                                                BlocProvider.of<ActionBloc>(
                                                        context)
                                                    .add(ChooseSetDrop(
                                                        value,
                                                        index,
                                                        state.exercise
                                                                .split(',')
                                                                .length -
                                                            1,
                                                        exercise));
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
                                              'Rest drop',
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_20,
                                                      AppFont.medium,
                                                      AppColor.blackColor),
                                            ),
                                            const SizedBox(
                                              width: AppDimens.dimens_20,
                                            ),
                                            Expanded(
                                                child: WidgetReused
                                                    .textFieldWidget('set drop',
                                                        (value) {
                                              BlocProvider.of<ActionBloc>(
                                                      context)
                                                  .add(ChooseRestTimeDrop(
                                                      value,
                                                      index,
                                                      state.exercise
                                                              .split(',')
                                                              .length -
                                                          1,
                                                      exercise));
                                            })),
                                          ],
                                        ),
                                      )
                                  ],
                                );
                              },
                              itemCount: state.exercise.split(',').length - 1,
                            );
                          }))),
              BlocBuilder<ActionBloc, ActionState>(builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    if (state.set == '' && state.restTime == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please setup set and rest time',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.normal,
                                AppColor.redColor1),
                          ),
                        ),
                      );
                    } else {
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
                              'muscle group': state.muscleGroup
                            },
                            true);
                      }
                    }
                  },
                  child: Container(
                    height: AppDimens.dimens_50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.orangeColor1,
                        borderRadius:
                            BorderRadius.circular(AppDimens.dimens_15)),
                    child: Center(
                      child: Text(
                        'Next',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                            AppFont.semiBold, AppColor.whiteColor),
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        )),
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
