import 'package:fitness_app_bloc/common_app/common_widget.dart';

import 'package:fitness_app_bloc/common_bloc/bloc_recipes/recipes_bloc.dart';

import 'package:fitness_app_bloc/config/config.dart';
import 'package:fitness_app_bloc/data/local/prefs.dart';
import 'package:fitness_app_bloc/reused/method_reused.dart';
import 'package:fitness_app_bloc/reused/widget_reused.dart';
import 'package:fitness_app_bloc/screen/home_screen/page/bloc/bloc_add_meals/add_meals_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:formz/formz.dart';

class AddMealsScreen extends StatelessWidget {
  const AddMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMealsBloc, AddMealsState>(
      listener: (context, state) {
        if (state.statusSubmit.isSuccess) {
          context.read<RecipesBloc>().add(UpdateData());
          Navigator.of(context).pop();
        } else if (state.statusSubmit.isFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(CommonWidget.errorSnackBar('Something went wrong'));
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColor.whiteColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColor.whiteColor,
              elevation: AppDimens.dimens_0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.blackColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text('Add Meals',
                  style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                      AppFont.semiBold, AppColor.blackColor)),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: AppDimens.dimens_20,
                    vertical: AppDimens.dimens_10),
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimens.dimens_5,
                    horizontal: AppDimens.dimens_20),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColor.colorGrey3, width: AppDimens.dimens_2),
                    borderRadius: BorderRadius.circular(AppDimens.dimens_10)),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Calories: ',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_15,
                                AppFont.normal,
                                AppColor.blackColor),
                          ),
                          const SizedBox(
                            width: AppDimens.dimens_5,
                          ),
                          WidgetReused.progress(
                              (context.read<AddMealsBloc>().calories +
                                      context
                                          .read<AddMealsBloc>()
                                          .currentCalories +
                                      LocalPref.getDouble(AppString.calories)!
                                          .toDouble()) /
                                  int.parse(context.select((RecipesBloc bloc) =>
                                      bloc.state.dataRecipes[AppString.calories] == null
                                          ? '1'
                                          : (bloc.state.dataRecipes[AppString.calories]
                                              as String))),
                              ((context.read<AddMealsBloc>().calories +
                                          context
                                              .read<AddMealsBloc>()
                                              .currentCalories +
                                          LocalPref.getDouble(AppString.calories)!.toDouble()) /
                                      int.parse(context.select((RecipesBloc bloc) => bloc.state.dataRecipes[AppString.calories] == null ? '1' : bloc.state.dataRecipes[AppString.calories] as String)) *
                                      100)
                                  .toStringAsFixed(0),
                              AppColor.greenColor),
                          const SizedBox(
                            width: AppDimens.dimens_5,
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                Text(MethodReused.filterDouble(
                                    (context.read<AddMealsBloc>().calories +
                                            context
                                                .read<AddMealsBloc>()
                                                .currentCalories +
                                            LocalPref.getDouble(
                                                AppString.calories)!)
                                        .toStringAsFixed(1))),
                                const SizedBox(
                                  width: AppDimens.dimens_30,
                                  child: Divider(
                                    color: AppColor.blackColor,
                                    height: AppDimens.dimens_0,
                                    thickness: AppDimens.dimens_1,
                                  ),
                                ),
                                Text(context.select((RecipesBloc bloc) => bloc
                                            .state
                                            .dataRecipes[AppString.calories] ==
                                        null
                                    ? '1'
                                    : bloc.state.dataRecipes[AppString.calories]
                                        as String)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Protein: ',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_15,
                                AppFont.normal,
                                AppColor.blackColor),
                          ),
                          const SizedBox(
                            width: AppDimens.dimens_5,
                          ),
                          WidgetReused.progress(
                              (context.read<AddMealsBloc>().protein +
                                      context
                                          .read<AddMealsBloc>()
                                          .currentProtein +
                                      LocalPref.getDouble(AppString.protein)!) /
                                  int.parse(context.select((RecipesBloc bloc) =>
                                      bloc.state.dataRecipes[AppString.protein] == null
                                          ? '1'
                                          : bloc.state.dataRecipes[AppString.protein]
                                              as String)),
                              ((context.read<AddMealsBloc>().protein +
                                          context
                                              .read<AddMealsBloc>()
                                              .currentProtein +
                                          LocalPref.getDouble(AppString.protein)!
                                              .toDouble()) /
                                      int.parse(context.select((RecipesBloc bloc) => bloc.state.dataRecipes[AppString.calories] == null ? '1' : bloc.state.dataRecipes[AppString.protein] as String)) *
                                      100)
                                  .toStringAsFixed(0),
                              AppColor.orangeColor1),
                          const SizedBox(
                            width: AppDimens.dimens_5,
                          ),
                          Column(
                            children: [
                              Text(MethodReused.filterDouble((context
                                          .read<AddMealsBloc>()
                                          .protein +
                                      context
                                          .read<AddMealsBloc>()
                                          .currentProtein +
                                      LocalPref.getDouble(AppString.protein)!)
                                  .toStringAsFixed(1))),
                              const SizedBox(
                                width: AppDimens.dimens_30,
                                child: Divider(
                                  color: AppColor.blackColor,
                                  height: AppDimens.dimens_0,
                                  thickness: AppDimens.dimens_1,
                                ),
                              ),
                              Text(context.select((RecipesBloc bloc) => bloc
                                          .state
                                          .dataRecipes[AppString.calories] ==
                                      null
                                  ? '1'
                                  : bloc.state.dataRecipes[AppString.protein]
                                      as String)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: AppDimens.dimens_15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Fats: ',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_15,
                                AppFont.normal,
                                AppColor.blackColor),
                          ),
                          const SizedBox(
                            width: AppDimens.dimens_5,
                          ),
                          WidgetReused.progress(
                              (context.read<AddMealsBloc>().fats +
                                      context.read<AddMealsBloc>().currentFats +
                                      LocalPref.getDouble(AppString.fats)!) /
                                  int.parse(context.select((RecipesBloc bloc) =>
                                      bloc.state.dataRecipes[AppString.calories] ==
                                              null
                                          ? '1'
                                          : bloc.state
                                                  .dataRecipes[AppString.fats]
                                              as String)),
                              ((context.read<AddMealsBloc>().fats +
                                          context
                                              .read<AddMealsBloc>()
                                              .currentFats +
                                          LocalPref.getDouble(AppString.fats)!) /
                                      int.parse(context.select((RecipesBloc bloc) => bloc.state.dataRecipes[AppString.calories] == null ? '1' : bloc.state.dataRecipes[AppString.fats] as String)) *
                                      100)
                                  .toStringAsFixed(0),
                              AppColor.redColor1),
                          const SizedBox(
                            width: AppDimens.dimens_5,
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                Text(MethodReused.filterDouble((context
                                            .read<AddMealsBloc>()
                                            .fats +
                                        context
                                            .read<AddMealsBloc>()
                                            .currentFats +
                                        LocalPref.getDouble(AppString.fats)!)
                                    .toStringAsFixed(1))),
                                const SizedBox(
                                  width: AppDimens.dimens_30,
                                  child: Divider(
                                    color: AppColor.blackColor,
                                    height: AppDimens.dimens_0,
                                    thickness: AppDimens.dimens_1,
                                  ),
                                ),
                                Text(context.select((RecipesBloc bloc) => bloc
                                            .state
                                            .dataRecipes[AppString.calories] ==
                                        null
                                    ? '1'
                                    : bloc.state.dataRecipes[AppString.fats]
                                        as String)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Carbs: ',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_15,
                                AppFont.normal,
                                AppColor.blackColor),
                          ),
                          const SizedBox(
                            width: AppDimens.dimens_5,
                          ),
                          WidgetReused.progress(
                              (context.read<AddMealsBloc>().carbs +
                                      context
                                          .read<AddMealsBloc>()
                                          .currentCarbs +
                                      LocalPref.getDouble(AppString.carbs)!) /
                                  int.parse(context.select((RecipesBloc bloc) =>
                                      bloc.state.dataRecipes[AppString.calories] ==
                                              null
                                          ? '1'
                                          : bloc.state.dataRecipes[AppString.carbs]
                                              as String)),
                              ((context.read<AddMealsBloc>().carbs +
                                          context
                                              .read<AddMealsBloc>()
                                              .currentCarbs +
                                          LocalPref.getDouble(AppString.carbs)!) /
                                      int.parse(context.select((RecipesBloc bloc) => bloc.state.dataRecipes[AppString.calories] == null ? '1' : bloc.state.dataRecipes[AppString.carbs] as String)) *
                                      100)
                                  .toStringAsFixed(0),
                              AppColor.yellowColor1),
                          const SizedBox(
                            width: AppDimens.dimens_5,
                          ),
                          Column(
                            children: [
                              Text(MethodReused.filterDouble(
                                  (context.read<AddMealsBloc>().carbs +
                                          context
                                              .read<AddMealsBloc>()
                                              .currentCarbs +
                                          LocalPref.getDouble(AppString.carbs)!)
                                      .toStringAsFixed(1))),
                              const SizedBox(
                                width: AppDimens.dimens_30,
                                child: Divider(
                                  color: AppColor.blackColor,
                                  height: AppDimens.dimens_0,
                                  thickness: AppDimens.dimens_1,
                                ),
                              ),
                              Text(context.select((RecipesBloc bloc) =>
                                  bloc.state.dataRecipes[AppString.calories] ==
                                          null
                                      ? '1'
                                      : bloc.state.dataRecipes[AppString.carbs]
                                          as String)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
                width: double.infinity,
                height:
                    (state.food.split(',').length - 1) * AppDimens.dimens_50,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.food.split(',').length - 1,
                  itemBuilder: (context, index) {
                    var indexFood = AppAnother.listFood.indexWhere((element) =>
                        (element[AppString.name] as String) ==
                        state.food.split(',')[index]);

                    return Container(
                      height: AppDimens.dimens_40,
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: AppDimens.dimens_10),
                      child: Slidable(
                        key: ValueKey(index),
                        endActionPane: ActionPane(
                          extentRatio: 0.2,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (BuildContext context) {
                                context.read<AddMealsBloc>().add(
                                    DeleteFoodEvent(
                                        state.food.split(',')[index]));
                              },
                              backgroundColor: AppColor.whiteColor,
                              foregroundColor: AppColor.redColor2,
                              icon: Icons.delete,
                            )
                          ],
                        ),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Name: ${state.food.split(',')[index]} ',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_16,
                                    AppFont.medium,
                                    AppColor.blackColor),
                              ),
                              const SizedBox(
                                width: AppDimens.dimens_15,
                              ),
                              Text('Weight: ${state.weight.split(',')[index]}g',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_16,
                                      AppFont.medium,
                                      AppColor.blackColor)),
                              const SizedBox(
                                width: AppDimens.dimens_15,
                              ),
                              Text(
                                  'Calories: ${AppAnother.listFood[indexFood][AppString.calories] * int.parse(state.weight.split(',')[index]) / 100}kcal',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_16,
                                      AppFont.medium,
                                      AppColor.blackColor)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (context.read<AddMealsBloc>().isAddVibility) addField(context),
              if (!context.read<AddMealsBloc>().isAddVibility)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.dimens_20),
                  child: TextButton(
                      onPressed: () {
                        context.read<AddMealsBloc>().add(AddFieldVisilibity());
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(AppDimens.dimens_0),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: AppColor.blueColor1,
                          ),
                          Text(
                            'Add Food',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blueColor1),
                          )
                        ],
                      )),
                ),
            ])),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimens.dimens_20,
                  vertical: AppDimens.dimens_10),
              height: AppDimens.dimens_50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.greenColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.dimens_10))),
                onPressed: () async {
                  context.read<AddMealsBloc>().add(SubmitMeals());
                },
                child: state.statusSubmit.isInProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        'Submit',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                            AppFont.semiBold, AppColor.whiteColor),
                      ),
              ),
            ));
      },
    );
  }
}

// /////
//////
Widget addField(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.dimens_10, vertical: AppDimens.dimens_15),
    child: Column(children: [
      SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: AppDimens.dimens_80,
              child: Text(
                'Food',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
            ),
            const SizedBox(
              width: AppDimens.dimens_20,
            ),
            Expanded(
                child: DropdownMenu<String>(
              hintText: 'dish',
              textStyle: AppAnother.textStyleDefault(
                  AppDimens.dimens_20, AppFont.normal, AppColor.blackColor),
              inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppDimens.dimens_10)),
                      borderSide: BorderSide(
                          color: AppColor.blackColor,
                          width: AppDimens.dimens_1)),
                  enabledBorder: OutlineInputBorder(
                      gapPadding: AppDimens.dimens_0,
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppDimens.dimens_10)),
                      borderSide: BorderSide(
                          color: AppColor.colorGrey3,
                          width: AppDimens.dimens_0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppDimens.dimens_10)),
                      borderSide: BorderSide(
                        color: AppColor.colorGrey3,
                      )),
                  constraints: BoxConstraints(maxHeight: AppDimens.dimens_50),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: AppDimens.dimens_15,
                      vertical: AppDimens.dimens_0)),
              initialSelection: null,
              menuHeight: AppDimens.dimens_200,
              onSelected: (value) {
                context.read<AddMealsBloc>().add(SetFood(value!));
              },
              dropdownMenuEntries: AppAnother.listFood.map((element) {
                return DropdownMenuEntry(
                    value: element[AppString.name] as String,
                    label: element[AppString.name]);
              }).toList(),
            )),
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
            SizedBox(
              width: AppDimens.dimens_80,
              child: Text(
                'Weight',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
            ),
            const SizedBox(
              width: AppDimens.dimens_20,
            ),
            Expanded(
                child: WidgetReused.textFieldWidget('gram', (value) {
              context.read<AddMealsBloc>().add(OnChangeWeightMeals(value));
            }, null))
          ],
        ),
      ),
      const SizedBox(
        height: AppDimens.dimens_10,
      ),
      Center(
          child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.greenColor1),
        onPressed: () {
          context.read<AddMealsBloc>().add(SubmitDish());
        },
        child: Text(
          'Submit',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_20, AppFont.normal, AppColor.blackColor),
        ),
      ))
    ]),
  );
}
