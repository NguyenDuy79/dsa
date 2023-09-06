import 'package:fitness_app_bloc/common_bloc/bloc_recipes/recipes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/config.dart';
import '../../../../../data/local/prefs.dart';
import '../../../../../respository/repository.dart';

class CaloriesWidget extends StatefulWidget {
  const CaloriesWidget({super.key});

  @override
  State<CaloriesWidget> createState() => _CaloriesWidgetState();
}

class _CaloriesWidgetState extends State<CaloriesWidget> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _controllerProtein = TextEditingController();
  final TextEditingController _controllerFat = TextEditingController();
  @override
  void dispose() {
    _controllerProtein.dispose();
    _controllerFat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(top: AppDimens.dimens_30),
      child: BlocConsumer<RecipesBloc, RecipesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is RecipesInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RecipesLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        height: width * 0.5,
                        width: width * 0.5,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(180 / 360),
                          child: CircularProgressIndicator(
                            backgroundColor:
                                AppColor.greenColor.withOpacity(0.4),
                            color: AppColor.greenColor,
                            value: LocalPref.getInt(AppString.calories)! /
                                int.parse(state.dataRecipes[AppString.calories]
                                    as String),
                            strokeWidth: AppDimens.dimens_12,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: width * 0.5,
                        width: width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${LocalPref.getInt(AppString.calories)}',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_32,
                                      AppFont.medium,
                                      AppColor.greenColor),
                                ),
                                Text(
                                  '/${state.dataRecipes[AppString.calories]}',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.medium,
                                      AppColor.colorGrey4),
                                ),
                              ],
                            ),
                            Text(
                              'kcal',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.light,
                                  AppColor.colorGrey4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.dataRecipes[AppString.protein] == '0')
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimens.dimens_10,
                        horizontal: AppDimens.dimens_20),
                    child: Text(
                      'Please enter nutrition facts',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.medium, AppColor.blackColor),
                    ),
                  ),
                if (state.dataRecipes[AppString.protein] == '0')
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_20,
                        vertical: AppDimens.dimens_10),
                    child: Form(
                      key: _key,
                      child: Column(
                        children: [
                          Text(
                            '',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_15,
                                AppFont.normal,
                                AppColor.blackColor),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  'Protein',
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
                                      onChanged: (value) {},
                                      controller: _controllerProtein,
                                      validator: (value) => value!.isEmpty
                                          ? 'Please enter value'
                                          : (value.contains('.') ||
                                                  value.contains('-') ||
                                                  value.contains(' ') ||
                                                  value.contains(','))
                                              ? 'Please enter the number '
                                              : (int.parse(value) < 10 ||
                                                      int.parse(value) > 35)
                                                  ? 'Please enter the fats range from 10 to 35 percent'
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
                                          hintText: 'protein %',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColor.colorGrey3),
                                              borderRadius:
                                                  BorderRadius.all(Radius.circular(AppDimens.dimens_10))),
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
                              child: Row(children: [
                                Text(
                                  'Fats',
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
                                        onChanged: (value) {},
                                        controller: _controllerFat,
                                        validator: (value) => value!.isEmpty
                                            ? 'Please enter value'
                                            : (value.contains('.') ||
                                                    value.contains('-') ||
                                                    value.contains(' ') ||
                                                    value.contains(','))
                                                ? 'Please enter the number '
                                                : (int.parse(value) < 20 ||
                                                        int.parse(value) > 35)
                                                    ? 'Please enter the fats range from 20 to 35 percent'
                                                    : null,
                                        cursorColor: AppColor.blackColor,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        AppDimens.dimens_10)),
                                                borderSide: BorderSide(
                                                    color:
                                                        AppColor.colorGrey3)),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal:
                                                    AppDimens.dimens_20),
                                            filled: true,
                                            hintText: 'fats %',
                                            enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: AppColor.colorGrey3),
                                                borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_10))),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_10)), borderSide: BorderSide(color: AppColor.blackColor)))))
                              ])),
                          const SizedBox(
                            height: AppDimens.dimens_10,
                          ),
                          Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.greenColor1),
                                  onPressed: () async {
                                    if (_key.currentState!.validate()) {
                                      await DbRecipesRepository().update(
                                          state.dataRecipes[AppString.id]
                                              as int,
                                          (int.parse(_controllerProtein.text) *
                                                  (int.parse(state.dataRecipes[AppString.calories]
                                                      as String)) /
                                                  100 ~/
                                                  4)
                                              .toString(),
                                          (int.parse(_controllerFat.text) *
                                                  (int.parse(
                                                      state.dataRecipes[AppString.calories]
                                                          as String)) /
                                                  100 ~/
                                                  9)
                                              .toString(),
                                          (((int.parse(state.dataRecipes[AppString.calories] as String)) -
                                                      (int.parse(_controllerProtein.text) *
                                                          (int.parse(state.dataRecipes[AppString.calories] as String)) /
                                                          100) -
                                                      (int.parse(_controllerFat.text) * (int.parse(state.dataRecipes[AppString.calories] as String)) / 100)) ~/
                                                  4)
                                              .toString());
                                      // ignore: use_build_context_synchronously
                                      context
                                          .read<RecipesBloc>()
                                          .add(UpdateData());
                                    }
                                  },
                                  child: Text(
                                    'Submit',
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_20,
                                        AppFont.normal,
                                        AppColor.blackColor),
                                  )))
                        ],
                      ),
                    ),
                  ),
                if (state.dataRecipes[AppString.protein] != '0')
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_10,
                        vertical: AppDimens.dimens_10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: AppDimens.dimens_35,
                                    width: AppDimens.dimens_35,
                                    child: RotationTransition(
                                      turns: const AlwaysStoppedAnimation(
                                          180 / 360),
                                      child: CircularProgressIndicator(
                                        backgroundColor: AppColor.orangeColor1
                                            .withOpacity(0.2),
                                        color: AppColor.orangeColor1,
                                        value: LocalPref.getInt(
                                                AppString.protein)! /
                                            double.parse(state.dataRecipes[
                                                AppString.protein] as String),
                                        strokeWidth: AppDimens.dimens_5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimens.dimens_35,
                                  width: AppDimens.dimens_35,
                                  child: Center(
                                    child: Text(
                                      LocalPref.getInt(AppString.protein)
                                          .toString(),
                                      style: AppAnother.textStyleDefault(
                                          AppDimens.dimens_15,
                                          AppFont.medium,
                                          AppColor.blackColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: AppDimens.dimens_15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Protein',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.medium,
                                      AppColor.blackColor),
                                ),
                                Text(
                                  '${state.dataRecipes[AppString.protein]}g',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_15,
                                      AppFont.light,
                                      AppColor.colorGrey4),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: AppDimens.dimens_35,
                                    width: AppDimens.dimens_35,
                                    child: RotationTransition(
                                      turns: const AlwaysStoppedAnimation(
                                          180 / 360),
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            AppColor.redColor1.withOpacity(0.2),
                                        color: AppColor.redColor1,
                                        value:
                                            LocalPref.getInt(AppString.fats)! /
                                                double.parse(state.dataRecipes[
                                                    AppString.fats] as String),
                                        strokeWidth: AppDimens.dimens_5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimens.dimens_35,
                                  width: AppDimens.dimens_35,
                                  child: Center(
                                    child: Text(
                                      LocalPref.getInt(AppString.fats)
                                          .toString(),
                                      style: AppAnother.textStyleDefault(
                                          AppDimens.dimens_15,
                                          AppFont.medium,
                                          AppColor.blackColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: AppDimens.dimens_15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Fats',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.medium,
                                      AppColor.blackColor),
                                ),
                                Text(
                                  '${state.dataRecipes[AppString.fats]}g',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_15,
                                      AppFont.light,
                                      AppColor.colorGrey4),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: AppDimens.dimens_35,
                                    width: AppDimens.dimens_35,
                                    child: RotationTransition(
                                      turns: const AlwaysStoppedAnimation(
                                          180 / 360),
                                      child: CircularProgressIndicator(
                                        backgroundColor: AppColor.yellowColor1
                                            .withOpacity(0.2),
                                        color: AppColor.yellowColor1,
                                        value:
                                            LocalPref.getInt(AppString.carbs)! /
                                                double.parse(state.dataRecipes[
                                                    AppString.carbs] as String),
                                        strokeWidth: AppDimens.dimens_5,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppDimens.dimens_35,
                                  width: AppDimens.dimens_35,
                                  child: Center(
                                    child: Text(
                                      LocalPref.getInt(AppString.carbs)
                                          .toString(),
                                      style: AppAnother.textStyleDefault(
                                          AppDimens.dimens_15,
                                          AppFont.medium,
                                          AppColor.blackColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: AppDimens.dimens_15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Carbs',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.medium,
                                      AppColor.blackColor),
                                ),
                                Text(
                                  '${state.dataRecipes[AppString.carbs]}g',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_15,
                                      AppFont.light,
                                      AppColor.colorGrey4),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
