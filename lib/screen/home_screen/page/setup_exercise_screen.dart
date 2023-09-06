import 'package:fitness_app_bloc/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/action_bloc/action_bloc.dart';

class SetupExerciseScreen extends StatelessWidget {
  SetupExerciseScreen({super.key});

  final PageController controller = PageController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
      body: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          chooseExercise(controller, context),
          BlocBuilder<ActionBloc, ActionState>(
            builder: (context, state) {
              return chooseMuscleGroup(context, state, controller);
            },
          ),
          setUpSetAndRestTime(_key)
        ],
      ),
    );
  }
}

Widget chooseExercise(PageController controller, BuildContext context) {
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
      Container(
        height: AppAnother.exerciseMethod.length * AppDimens.dimens_70,
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
        child: ListView.builder(
          itemCount: AppAnother.exerciseMethod.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              BlocProvider.of<ActionBloc>(context)
                  .add(ChooseExerciseMethod(AppAnother.exerciseMethod[index]));
              controller.animateToPage(1,
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
                AppAnother.exerciseMethod[index],
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

Widget chooseMuscleGroup(
    BuildContext context, ActionState state, PageController controller) {
  return Container(
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
                      margin:
                          const EdgeInsets.only(bottom: AppDimens.dimens_10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.dimens_20,
                          vertical: AppDimens.dimens_10),
                      decoration: BoxDecoration(
                          color: AppColor.greenColor,
                          borderRadius:
                              BorderRadius.circular(AppDimens.dimens_15)),
                      child: Text(
                        AppAnother.muscleGroup[index],
                        style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                            AppFont.medium, AppColor.blackColor),
                      )),
                ),
                if (state.muscleGroup.contains(AppAnother.muscleGroup[index]))
                  SizedBox(
                    height: AppDimens.dimens_30 *
                        AppAnother
                            .exercise[AppAnother.muscleGroup[index]]!.length,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: AppAnother
                            .exercise[AppAnother.muscleGroup[index]]!.length,
                        itemBuilder: (context, indexExercise) {
                          int curentExcercise = state.exercise
                              .split(',')
                              .indexWhere(
                                (element) =>
                                    element ==
                                    AppAnother.exercise[AppAnother
                                        .muscleGroup[index]]![indexExercise],
                              );
                          return GestureDetector(
                              onTap: () {
                                if (state.exercise.contains(AppAnother.exercise[
                                    AppAnother
                                        .muscleGroup[index]]![indexExercise])) {
                                  BlocProvider.of<ActionBloc>(context).add(
                                      UnChooseExercise(AppAnother.exercise[
                                              AppAnother.muscleGroup[index]]![
                                          indexExercise]));
                                } else {
                                  BlocProvider.of<ActionBloc>(context).add(
                                      ChooseExercise(AppAnother.exercise[
                                              AppAnother.muscleGroup[index]]![
                                          indexExercise]));
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
                                        backgroundColor: AppColor.blue1,
                                        child: Text(
                                          (curentExcercise + 1).toString(),
                                          style: AppAnother.textStyleDefault(
                                              AppDimens.dimens_20,
                                              AppFont.semiBold,
                                              AppColor.whiteColor),
                                        ),
                                      ),
                                    if (curentExcercise < 0)
                                      CircleAvatar(
                                        backgroundColor: AppColor.whiteColor,
                                        child: Text(
                                          (curentExcercise + 1).toString(),
                                          style: AppAnother.textStyleDefault(
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
                                                AppAnother.muscleGroup[index]]![
                                            indexExercise],
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
              controller.animateToPage(2,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.linear);
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

Widget setUpSetAndRestTime(GlobalKey<FormState> key) {
  return BlocConsumer<ActionBloc, ActionState>(
    listener: (context, state) {},
    builder: (context, state) {
      return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Import set and rest time',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor)),
            const SizedBox(
              height: AppDimens.dimens_10,
            ),
            Expanded(
              child: Form(
                key: key,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${state.exercise.split(',')[index]}:',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.blackColor),
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
                                child: TextFormField(
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_20,
                                        AppFont.normal,
                                        AppColor.blackColor),
                                    key: ValueKey('${index}set'),
                                    onChanged: (value) {
                                      BlocProvider.of<ActionBloc>(context).add(
                                          ChooseSet(
                                              value,
                                              index,
                                              state.exercise.split(',').length -
                                                  1));
                                    },
                                    validator: (value) => value!.isEmpty
                                        ? 'Please enter value'
                                        : (value.contains('.') ||
                                                value.contains('-') ||
                                                value.contains(' ') ||
                                                value.contains(','))
                                            ? 'Please enter the number '
                                            : int.parse(value) == 0
                                                ? 'Please enter the set'
                                                : null,
                                    cursorColor: AppColor.blackColor,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    AppDimens.dimens_10)),
                                            borderSide: BorderSide(
                                                color: AppColor.colorGrey3)),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: AppDimens.dimens_20),
                                        filled: true,
                                        hintText: 'set',
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.colorGrey3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(AppDimens.dimens_10))),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_10)), borderSide: BorderSide(color: AppColor.blackColor)))),
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
                                child: TextFormField(
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_20,
                                        AppFont.normal,
                                        AppColor.blackColor),
                                    key: ValueKey('${index}resttime'),
                                    onChanged: (value) {
                                      context.read<ActionBloc>().add(
                                          ChooseRestTime(
                                              value,
                                              index,
                                              state.exercise.split(',').length -
                                                  1));
                                    },
                                    validator: (value) => value!.isEmpty
                                        ? 'Please enter value'
                                        : (value.contains('.') ||
                                                value.contains('-') ||
                                                value.contains(' ') ||
                                                value.contains(','))
                                            ? 'Please enter the number '
                                            : int.parse(value) < 1
                                                ? 'Please increase the rest time'
                                                : null,
                                    cursorColor: AppColor.blackColor,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    AppDimens.dimens_10)),
                                            borderSide: BorderSide(
                                                color: AppColor.colorGrey3)),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: AppDimens.dimens_20),
                                        filled: true,
                                        hintText: 'rest time',
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColor.colorGrey3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(AppDimens.dimens_10))),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_10)), borderSide: BorderSide(color: AppColor.blackColor)))),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: state.exercise.split(',').length - 1,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (state.set == '' && state.restTime == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please setup set and rest time',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                            AppFont.normal, AppColor.redColor1),
                      ),
                    ),
                  );
                } else {
                  final isValid = key.currentState!.validate();

                  if (isValid) {
                    Navigator.of(context).pushReplacementNamed(
                        RouteGenerator.actionScreen,
                        arguments: {
                          'method': state.method,
                          'set': state.set,
                          'rest time': state.restTime,
                          'exercise': state.exercise,
                          'muscle group': state.muscleGroup
                        });
                  }
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
            ),
          ],
        ),
      );
    },
  );
}
