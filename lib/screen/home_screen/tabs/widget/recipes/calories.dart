import 'package:fitness_app_bloc/common_app/common_widget.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_activity/activity_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_index/index_common_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_recipes/recipes_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_water/water_bloc.dart';
import 'package:fitness_app_bloc/reused/method_reused.dart';
import 'package:fitness_app_bloc/reused/widget_reused.dart';
import 'package:fitness_app_bloc/screen/into_screen/home_page_bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../config/config.dart';
import '../../../../../data/local/prefs.dart';
import '../../../../../data/model/chart.dart';
import '../../../../../respository/repository.dart';

class CaloriesWidget extends StatelessWidget {
  const CaloriesWidget(this.controller, this.dateTime, this.count,
      this.controllerProtein, this.controllerFat, this.keyForm,
      {super.key});
  final PageController controller;
  final DateTime dateTime;
  final int count;
  final TextEditingController controllerProtein;
  final TextEditingController controllerFat;
  final GlobalKey<FormState> keyForm;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String value = context.select((ActivityBloc bloc) =>
        bloc.state.activityResponse.last[AppString.gender]) as String;
    bool calories = context.select(
      (HomePageBloc bloc) => bloc.state.isMetric,
    );
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
                SizedBox(
                  height: (state.dataRecipes[AppString.protein] == '0' &&
                          calories == true &&
                          indexToday(dateTime) ==
                              context.select(
                                (IndexCommonBloc bloc) => bloc.state.index,
                              ))
                      ? AppDimens.dimens_550
                      : !calories
                          ? (width - AppDimens.dimens_20 * 3) * 0.75
                          : AppDimens.dimens_300,
                  child: PageView.builder(
                      itemCount: count,
                      controller: controller,
                      onPageChanged: (value) {
                        context
                            .read<IndexCommonBloc>()
                            .add(ScrollPageView(value));
                      },
                      itemBuilder: (context, index) {
                        return calories
                            ? (dateTime
                                        .difference(MethodReused.getWeek(
                                            dateTime)[index])
                                        .inDays ==
                                    0
                                ? SingleChildScrollView(
                                    child: caloriesWidgetToday(
                                        state,
                                        controllerFat,
                                        controllerProtein,
                                        width,
                                        keyForm,
                                        context),
                                  )
                                : caloriesWidget(
                                    width,
                                    state,
                                    DateFormat('dd-MM-yyyy').format(
                                        MethodReused.getWeek(dateTime)[index])))
                            : waterAdd(
                                context,
                                width,
                                value,
                                MethodReused.getWeek(dateTime)[index],
                                state,
                                dateTime,
                              );
                      }),
                ),
                calories
                    ? mealsWidget(
                        context,
                        state,
                        MethodReused.getWeek(dateTime)[context.select(
                          (IndexCommonBloc bloc) => bloc.state.index,
                        )],
                        dateTime)
                    : waterChart(
                        MethodReused.getWeek(dateTime)[context.select(
                          (IndexCommonBloc bloc) => bloc.state.index,
                        )],
                        state,
                        dateTime)
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

Widget waterAdd(BuildContext context, double width, String value, DateTime here,
    RecipesLoaded state, DateTime now) {
  int count = now.difference(here).inDays;
  Map<String, Object?> data = getData(state.dataWater, here);
  return Container(
      height: (width - AppDimens.dimens_20 * 3) * 0.75,
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
      child: Row(children: [
        SizedBox(
            width: (width - AppDimens.dimens_20 * 3) / 2,
            child: BlocBuilder<WaterBloc, WaterState>(
              builder: (context, state) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: AppColor.colorGrey2,
                        borderRadius:
                            BorderRadius.circular(AppDimens.dimens_15),
                      ),
                    ),
                    FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      widthFactor: 1,
                      heightFactor: count == 0
                          ? (LocalPref.getInt(AppString.water)! <
                                  (value == AppString.male ? 3700 : 2700)
                              ? (LocalPref.getInt(AppString.water)! /
                                  (value == AppString.male ? 3700 : 2700))
                              : 1)
                          : data.isNotEmpty
                              ? (data[AppString.water] as int <
                                      (value == AppString.male ? 3700 : 2700)
                                  ? ((data[AppString.water] as int) /
                                      (value == AppString.male ? 3700 : 2700))
                                  : 1)
                              : 0,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            color: AppColor.blueColor1.withOpacity(0.8),
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    const Radius.circular(AppDimens.dimens_15),
                                bottomRight:
                                    const Radius.circular(AppDimens.dimens_15),
                                topLeft: borderVisibility(
                                        width, value, data, count)
                                    ? const Radius.circular(AppDimens.dimens_15)
                                    : const Radius.circular(AppDimens.dimens_0),
                                topRight: borderVisibility(
                                        width, value, data, count)
                                    ? const Radius.circular(AppDimens.dimens_15)
                                    : const Radius.circular(
                                        AppDimens.dimens_0))),
                        child: Text(
                          count == 0
                              ? (LocalPref.getInt(AppString.water)! <
                                      (value == AppString.male ? 3700 : 2700)
                                  ? '${(LocalPref.getInt(AppString.water)! * 100 / (value == AppString.male ? 3700 : 2700)).toStringAsFixed(1)}%'
                                  : '100%')
                              : data.isNotEmpty
                                  ? ((data[AppString.water] as int) <
                                          (value == AppString.male
                                              ? 3700
                                              : 2700)
                                      ? '${((data[AppString.water] as int) * 100 / (value == AppString.male ? 3700 : 2700)).toStringAsFixed(1)}%'
                                      : '100%')
                                  : '0%',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_25,
                              AppFont.semiBold,
                              AppColor.whiteColor),
                        ),
                      ),
                    )
                  ],
                );
              },
            )),
        const SizedBox(
          width: AppDimens.dimens_20,
        ),
        SizedBox(
          width: (width - AppDimens.dimens_20 * 3) / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  'Liquid volume',
                  style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                      AppFont.semiBold, AppColor.blackColor),
                ),
              ),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<WaterBloc, WaterState>(
                      builder: (context, state) {
                        return Text(
                            count == 0
                                ? (LocalPref.getInt(AppString.water) != null
                                    ? (LocalPref.getInt(AppString.water)! /
                                            1000)
                                        .toString()
                                    : '0')
                                : data.isNotEmpty
                                    ? ((data[AppString.water] as int) / 1000)
                                        .toString()
                                    : '0',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_40,
                                AppFont.medium,
                                AppColor.blackColor));
                      },
                    ),
                    Text(
                      value == AppString.male ? '/3.7 Liters' : '/2.7 Liters',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                          AppFont.medium, AppColor.colorGrey4),
                    ),
                  ],
                ),
              ),
              if (count == 0)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: AppDimens.dimens_70,
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimens.dimens_10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<WaterBloc>().add(AddEvent());
                              },
                              child: const SizedBox(
                                height: AppDimens.dimens_40,
                                width: AppDimens.dimens_40,
                                child: CircleAvatar(
                                  backgroundColor: AppColor.blackColor,
                                  child: Icon(
                                    Icons.add,
                                    size: AppDimens.dimens_30,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                            BlocBuilder<WaterBloc, WaterState>(
                              builder: (context, state) {
                                return Text(
                                  '${context.read<WaterBloc>().value}ml',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.normal,
                                      AppColor.blackColor),
                                );
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<WaterBloc>().add(RemoveEvent());
                              },
                              child: const SizedBox(
                                height: AppDimens.dimens_40,
                                width: AppDimens.dimens_40,
                                child: CircleAvatar(
                                  backgroundColor: AppColor.blackColor,
                                  child: Icon(
                                    Icons.remove,
                                    size: AppDimens.dimens_30,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          DateTime dateTime = DateTime.now();
                          if ((LocalPref.getInt(dateTime.hour.toString())! +
                                  context.read<WaterBloc>().value) <=
                              1000) {
                            context
                                .read<WaterBloc>()
                                .add(AddWaterEvent(dateTime.hour.toString()));
                          }
                        },
                        child: Container(
                          height: AppDimens.dimens_120,
                          width: AppDimens.dimens_40,
                          decoration: BoxDecoration(
                              color: AppColor.blackColor,
                              borderRadius:
                                  BorderRadius.circular(AppDimens.dimens_20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                size: AppDimens.dimens_30,
                                color: AppColor.whiteColor,
                              ),
                              Text(
                                'Add',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.medium,
                                    AppColor.whiteColor),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        )
      ]));
}

Widget waterChart(DateTime here, RecipesLoaded state, DateTime now) {
  int count = now.difference(here).inDays;
  Map<String, Object?> data = getData(
    state.dataWater,
    here,
  );
  List<ChartData> listChart = getListWater(state.dataWater, data);

  return Column(
    children: [
      Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
          child: Text(
            'Water Intake In Day',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
          )),
      Container(
        height: AppDimens.dimens_200,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: AppDimens.dimens_10),
        decoration: BoxDecoration(
            border: Border.all(
                width: AppDimens.dimens_2, color: AppColor.colorGrey3),
            borderRadius: BorderRadius.circular(AppDimens.dimens_10)),
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.dimens_0, vertical: AppDimens.dimens_10),
        child: BlocBuilder<WaterBloc, WaterState>(
          builder: (context, state) {
            return SfCartesianChart(
              primaryXAxis: CategoryAxis(
                  autoScrollingDelta: 24,
                  interval: 2,
                  majorGridLines: const MajorGridLines(width: 0)),
              primaryYAxis:
                  NumericAxis(minimum: 0, maximum: 1000, interval: 200),
              series: <ChartSeries<ChartData, String>>[
                ColumnSeries(
                    dataSource: count == 0 ? MethodReused.getList() : listChart,
                    xValueMapper: (ChartData data, index) => data.hour,
                    yValueMapper: (ChartData data, index) => data.value,
                    color: AppColor.blue1.withOpacity(0.5))
              ],
            );
          },
        ),
      )
    ],
  );
}

Widget caloriesWidget(double width, RecipesLoaded state, String dateTime) {
  int index = state.dataRecipesPerday.indexWhere(
    (element) => element[AppString.dateTime] == dateTime,
  );
  String protein = '';
  String calories = '';
  String fats = '';
  String carbs = '';
  if (index >= 0) {
    protein = state.dataRecipesPerday[index][AppString.protein] as String;
    calories = state.dataRecipesPerday[index][AppString.calories] as String;
    fats = state.dataRecipesPerday[index][AppString.fats] as String;
    carbs = state.dataRecipesPerday[index][AppString.carbs] as String;
  }

  return Padding(
    padding: const EdgeInsets.only(top: AppDimens.dimens_20),
    child: Column(
      children: [
        Stack(
          children: <Widget>[
            Center(
              child: SizedBox(
                height: width * 0.5,
                width: width * 0.5,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(180 / 360),
                  child: CircularProgressIndicator(
                    backgroundColor: AppColor.greenColor.withOpacity(0.4),
                    color: AppColor.greenColor,
                    value: index < 0
                        ? 0
                        : double.parse(calories.split('/')[0]) /
                            int.parse(calories.split('/')[1]),
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
                          index < 0
                              ? '0'
                              : MethodReused.filterDouble(
                                  double.parse(calories.split('/')[0])
                                      .toStringAsFixed(1)),
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_32,
                              AppFont.medium,
                              AppColor.greenColor),
                        ),
                        Text(
                          index < 0
                              ? '/--'
                              : '/${double.parse(calories.split('/')[1]).toInt()}',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.colorGrey4),
                        ),
                      ],
                    ),
                    Text(
                      'kcal',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.light, AppColor.colorGrey4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.dimens_10, vertical: AppDimens.dimens_10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  WidgetReused.progress(
                      index < 0
                          ? 0
                          : (protein.split('/')[1] == '0'
                              ? 0
                              : (double.parse(protein.split('/')[0]) /
                                  int.parse(protein.split('/')[1]))),
                      index < 0
                          ? '0'
                          : MethodReused.filterDouble(
                              double.parse(protein.split('/')[0])
                                  .toStringAsFixed(1)),
                      AppColor.orangeColor1),
                  const SizedBox(
                    width: AppDimens.dimens_15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Protein',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                            AppFont.medium, AppColor.blackColor),
                      ),
                      Text(
                        index < 0
                            ? '--g'
                            : (protein.split('/')[1] == '0'
                                ? '--g'
                                : '${protein.split('/')[1]}g'),
                        style: AppAnother.textStyleDefault(AppDimens.dimens_15,
                            AppFont.light, AppColor.colorGrey4),
                      )
                    ],
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  WidgetReused.progress(
                      index < 0
                          ? 0
                          : (fats.split('/')[1] == '0'
                              ? 0
                              : (double.parse(fats.split('/')[0]) /
                                  int.parse(fats.split('/')[1]))),
                      index < 0
                          ? '0'
                          : MethodReused.filterDouble(
                              double.parse(fats.split('/')[0])
                                  .toStringAsFixed(1)),
                      AppColor.orangeColor1),
                  const SizedBox(
                    width: AppDimens.dimens_15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Fats',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                            AppFont.medium, AppColor.blackColor),
                      ),
                      Text(
                        index < 0
                            ? '--g'
                            : (fats.split('/')[1] == '0'
                                ? '--g'
                                : '${fats.split('/')[1]}g'),
                        style: AppAnother.textStyleDefault(AppDimens.dimens_15,
                            AppFont.light, AppColor.colorGrey4),
                      )
                    ],
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  WidgetReused.progress(
                      index < 0
                          ? 0
                          : (carbs.split('/')[1] == '0'
                              ? 0
                              : (double.parse(carbs.split('/')[0]) /
                                  int.parse(carbs.split('/')[1]))),
                      index < 0
                          ? '0'
                          : MethodReused.filterDouble(
                              double.parse(carbs.split('/')[0])
                                  .toStringAsFixed(1)),
                      AppColor.orangeColor1),
                  const SizedBox(
                    width: AppDimens.dimens_15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Carbs',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                            AppFont.medium, AppColor.blackColor),
                      ),
                      Text(
                        index < 0
                            ? '--g'
                            : (carbs.split('/')[1] == '0'
                                ? '--g'
                                : '${carbs.split('/')[1]}g'),
                        style: AppAnother.textStyleDefault(AppDimens.dimens_15,
                            AppFont.light, AppColor.colorGrey4),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget caloriesWidgetToday(
    RecipesLoaded state,
    TextEditingController controllerFat,
    TextEditingController controllerProtein,
    double width,
    GlobalKey<FormState> keyForm,
    BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(top: AppDimens.dimens_20),
    child: Column(
      children: [
        Stack(
          children: <Widget>[
            Center(
              child: SizedBox(
                height: width * 0.5,
                width: width * 0.5,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(180 / 360),
                  child: CircularProgressIndicator(
                    backgroundColor: AppColor.greenColor.withOpacity(0.4),
                    color: AppColor.greenColor,
                    value: LocalPref.getDouble(AppString.calories)! /
                        int.parse(
                            state.dataRecipes[AppString.calories] as String),
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
                          MethodReused.filterDouble(
                              LocalPref.getDouble(AppString.calories)!
                                  .toStringAsFixed(1)),
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
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.light, AppColor.colorGrey4),
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
                vertical: AppDimens.dimens_10, horizontal: AppDimens.dimens_20),
            child: Text(
              'Please enter nutrition facts',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
            ),
          ),
        if (state.dataRecipes[AppString.protein] == '0')
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
            child: Form(
              key: keyForm,
              child: Column(
                children: [
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
                              controller: controllerProtein,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter value'
                                  : (value.contains('.') ||
                                          value.contains('-') ||
                                          value.contains(' ') ||
                                          value.contains(','))
                                      ? 'Please enter the number '
                                      : (int.parse(value) < 10 ||
                                              int.parse(value) > 40)
                                          ? 'Please enter the fats range from 20 to 75 percent'
                                          : null,
                              cursorColor: AppColor.blackColor,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(AppDimens.dimens_10)),
                                      borderSide: BorderSide(
                                          color: AppColor.colorGrey3)),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: AppDimens.dimens_20),
                                  filled: true,
                                  hintText: 'protein %',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.colorGrey3),
                                      borderRadius: BorderRadius.all(Radius.circular(
                                          AppDimens.dimens_10))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_10)),
                                      borderSide: BorderSide(color: AppColor.blackColor)))),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppDimens.dimens_10,
                  ),
                  Text('There are 4 calories per gram of protein',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                          AppFont.medium, AppColor.blackColor)),
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
                                controller: controllerFat,
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter value'
                                    : (value.contains('.') ||
                                            value.contains('-') ||
                                            value.contains(' ') ||
                                            value.contains(','))
                                        ? 'Please enter the number '
                                        : (int.parse(value) < 20 ||
                                                int.parse(value) > 75)
                                            ? 'Please enter the fats range from 20 to 75 percent'
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
                                    hintText: 'fats %',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.colorGrey3),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(AppDimens.dimens_10))),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_10)), borderSide: BorderSide(color: AppColor.blackColor)))))
                      ])),
                  const SizedBox(
                    height: AppDimens.dimens_10,
                  ),
                  const SizedBox(
                    height: AppDimens.dimens_10,
                  ),
                  Text('There are 9 calories per gram of fats',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                          AppFont.medium, AppColor.blackColor)),
                  Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.greenColor1),
                          onPressed: () async {
                            if (keyForm.currentState!.validate()) {
                              submitRecipes(controllerFat, controllerProtein,
                                  context, state.dataRecipes);
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
                horizontal: AppDimens.dimens_10, vertical: AppDimens.dimens_10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    WidgetReused.progress(
                        LocalPref.getDouble(AppString.protein)! /
                            double.parse(
                                state.dataRecipes[AppString.protein] as String),
                        MethodReused.filterDouble(
                            LocalPref.getDouble(AppString.protein)!
                                .toStringAsFixed(1)),
                        AppColor.orangeColor1),
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
                    WidgetReused.progress(
                        LocalPref.getDouble(AppString.fats)! /
                            double.parse(
                                state.dataRecipes[AppString.fats] as String),
                        MethodReused.filterDouble(
                            LocalPref.getDouble(AppString.fats)!
                                .toStringAsFixed(1)),
                        AppColor.redColor1),
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
                    WidgetReused.progress(
                        LocalPref.getDouble(AppString.carbs)! /
                            double.parse(
                                state.dataRecipes[AppString.carbs] as String),
                        MethodReused.filterDouble(
                            LocalPref.getDouble(AppString.carbs)!
                                .toStringAsFixed(1)),
                        AppColor.yellowColor1),
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
          ),
      ],
    ),
  );
}

Widget mealsWidget(BuildContext context, RecipesLoaded state, DateTime dateTime,
    DateTime dateTime1) {
  int count = dateTime1.difference(dateTime).inDays;
  List<Map<String, Object?>> listMealsToday =
      getListMeals(state.dataMeals, dateTime);

  return Column(
    children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (count == 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Meals Today',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.semiBold, AppColor.blackColor),
                    ),
                    TextButton(
                        onPressed: () {
                          if (state.dataRecipes[AppString.carbs] == '0') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                CommonWidget.errorSnackBar(
                                    'Please add protein and fats first'));
                          } else {
                            Navigator.of(context)
                                .pushNamed(RouteGenerator.addMealsScreen);
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColor.blue1.withOpacity(0.7),
                            ),
                            Text(
                              'Add meals',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.semiBold,
                                  AppColor.blue1.withOpacity(0.7)),
                            )
                          ],
                        ))
                  ],
                ),
              if (count != 0)
                Text(
                  'Meals',
                  style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                      AppFont.semiBold, AppColor.blackColor),
                ),
            ],
          )),
      if (listMealsToday.isEmpty)
        Text('Empty',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor)),
      if (listMealsToday.isNotEmpty)
        SizedBox(
          height: listMealsToday.length * AppDimens.dimens_50,
          width: double.infinity,
          child: ListView.builder(
            itemCount: listMealsToday.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.dimens_20,
                    vertical: AppDimens.dimens_5),
                child: FittedBox(
                  child: Row(children: [
                    SizedBox(
                      width: AppDimens.dimens_70,
                      child: Text(
                        '${AppString.meals}: ${index + 1}',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_15,
                            AppFont.medium, AppColor.blackColor),
                      ),
                    ),
                    const SizedBox(
                      width: AppDimens.dimens_20,
                    ),
                    SizedBox(
                      width: AppDimens.dimens_120,
                      child: Text(
                        '${AppString.hour}: ${listMealsToday[index][AppString.hour]}',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_15,
                            AppFont.medium, AppColor.blackColor),
                      ),
                    ),
                    const SizedBox(
                      width: AppDimens.dimens_20,
                    ),
                    SizedBox(
                      width: AppDimens.dimens_120,
                      child: Text(
                        '${AppString.calories}: ${double.parse(listMealsToday[index][AppString.calories] as String).toStringAsFixed(1)}',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_15,
                            AppFont.medium, AppColor.blackColor),
                      ),
                    ),
                  ]),
                ),
              );
            },
          ),
        )
    ],
  );
}

int indexToday(DateTime dateTime) {
  return MethodReused.getWeek(dateTime).indexWhere(
    (element) => element == dateTime,
  );
}

List<Map<String, Object?>> getListMeals(
    List<Map<String, Object?>> allList, DateTime dateTime) {
  List<Map<String, Object?>> result = [];
  if (allList.isNotEmpty) {
    for (int i = 0; i < allList.length; i++) {
      if (allList[i][AppString.day] ==
          DateFormat('dd-M-yyyy').format(dateTime)) {
        result.add(allList[i]);
      }
    }
  }
  return result;
}

Map<String, Object?> getData(
  List<Map<String, Object?>> dataWater,
  DateTime here,
) {
  Map<String, Object?> data = {};
  for (int i = 0; i < dataWater.length; i++) {
    if (DateFormat('dd-MM-yyyy').format(here) ==
        dataWater[i][AppString.dateTime]) {
      data = dataWater[i];
    }
  }
  return data;
}

List<ChartData> getListWater(
    List<Map<String, Object?>> dataWater, Map<String, Object?> data) {
  List<ChartData> listChart = [
    ChartData('zero', 0),
    ChartData('1', 0),
    ChartData('2', 0),
    ChartData('3', 0),
    ChartData('4', 0),
    ChartData('5', 0),
    ChartData('6', 0),
    ChartData('7', 0),
    ChartData('8', 0),
    ChartData('9', 0),
    ChartData('10', 0),
    ChartData('11', 0),
    ChartData('12', 0),
    ChartData('13', 0),
    ChartData('14', 0),
    ChartData('15', 0),
    ChartData('16', 0),
    ChartData('17', 0),
    ChartData('18', 0),
    ChartData('19', 0),
    ChartData('20', 0),
    ChartData('21', 0),
    ChartData('22', 0),
    ChartData('23', 0),
  ];

  if (data.isNotEmpty) {
    listChart = [
      ChartData('zero', data['one'] as int),
      ChartData('1', data['one'] as int),
      ChartData('2', data['two'] as int),
      ChartData('3', data['three'] as int),
      ChartData('4', data['four'] as int),
      ChartData('5', data['five'] as int),
      ChartData('6', data['six'] as int),
      ChartData('7', data['seven'] as int),
      ChartData('8', data['eight'] as int),
      ChartData('9', data['nine'] as int),
      ChartData('10', data['ten'] as int),
      ChartData('11', data['eleven'] as int),
      ChartData('12', data['twelve'] as int),
      ChartData('13', data['thirteen'] as int),
      ChartData('14', data['fourteen'] as int),
      ChartData('15', data['fifteen'] as int),
      ChartData('16', data['sixteen'] as int),
      ChartData('17', data['seventeen'] as int),
      ChartData('18', data['eighteen'] as int),
      ChartData('19', data['nineteen'] as int),
      ChartData('20', data['twenty'] as int),
      ChartData('21', data['twenty_one'] as int),
      ChartData('22', data['twenty_two'] as int),
      ChartData('23', data['twenty_three'] as int),
    ];
  }
  return listChart;
}

bool borderVisibility(
    double width, String value, Map<String, Object?> data, int count) {
  return (width - AppDimens.dimens_20 * 3) *
          0.75 *
          (count == 0
              ? (LocalPref.getInt(AppString.water)! /
                  (value == AppString.male ? 3700 : 2700))
              : data.isNotEmpty
                  ? ((data[AppString.water] as int) /
                      (value == AppString.male ? 3700 : 2700))
                  : 0) >=
      ((width - AppDimens.dimens_20 * 3) * 0.75 - AppDimens.dimens_15);
}

void submitRecipes(
    TextEditingController controllerFat,
    TextEditingController controllerProtein,
    BuildContext context,
    Map<String, Object?> dataRecipes) async {
  if ((int.parse(controllerFat.text) * 9 +
          int.parse(controllerProtein.text) * 4) >
      (int.parse(dataRecipes[AppString.calories].toString()) - 20)) {
    ScaffoldMessenger.of(context).showSnackBar(CommonWidget.errorSnackBar(
        'The total value has exceeded the allowable value'));
  } else {
    await DbRecipesRepository().update(
        dataRecipes[AppString.id] as int,
        (int.parse(controllerProtein.text) *
                (int.parse(dataRecipes[AppString.calories] as String)) /
                100 ~/
                4)
            .toString(),
        (int.parse(controllerFat.text) *
                (int.parse(dataRecipes[AppString.calories] as String)) /
                100 ~/
                9)
            .toString(),
        (((int.parse(dataRecipes[AppString.calories] as String)) -
                    (int.parse(controllerProtein.text) *
                        (int.parse(dataRecipes[AppString.calories] as String)) /
                        100) -
                    (int.parse(controllerFat.text) *
                        (int.parse(dataRecipes[AppString.calories] as String)) /
                        100)) ~/
                4)
            .toString());
    // ignore: use_build_context_synchronously
    context.read<RecipesBloc>().add(UpdateData());
  }
}
