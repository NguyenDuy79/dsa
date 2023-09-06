import 'package:fitness_app_bloc/common_bloc/bloc_activity/activity_bloc.dart';
import 'package:fitness_app_bloc/data/local/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../config/config.dart';
import '../../../../../data/model/chart.dart';
import '../../bloc/bloc/recipes_toggle_bloc.dart';

class WaterWidget extends StatelessWidget {
  const WaterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<RecipesToggleBloc, RecipesToggleState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: (width - AppDimens.dimens_20 * 3) * 0.75,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.dimens_20,
                    vertical: AppDimens.dimens_10),
                child: Row(children: [
                  SizedBox(
                      width: (width - AppDimens.dimens_20 * 3) / 2,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              color: AppColor.blueColor1.withOpacity(0.8),
                              borderRadius:
                                  BorderRadius.circular(AppDimens.dimens_15),
                            ),
                            child: Text(
                              LocalPref.getInt(AppString.water)! <
                                      (context.select((ActivityBloc bloc) =>
                                                  bloc.state.activityResponse
                                                          .last[
                                                      AppString.gender]) ==
                                              AppString.male
                                          ? 3700
                                          : 2700)
                                  ? '${(LocalPref.getInt(AppString.water)! * 100 / (context.select((ActivityBloc bloc) => bloc.state.activityResponse.last[AppString.gender]) == AppString.male ? 3700 : 2700)).toStringAsFixed(1)}%'
                                  : '100%',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_25,
                                  AppFont.semiBold,
                                  AppColor.whiteColor),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 1,
                            heightFactor: LocalPref.getInt(AppString.water)! <
                                    (context.select((ActivityBloc bloc) => bloc
                                                .state
                                                .activityResponse
                                                .last[AppString.gender]) ==
                                            AppString.male
                                        ? 3700
                                        : 2700)
                                ? 1 -
                                    (LocalPref.getInt(AppString.water)! /
                                        (context.select((ActivityBloc bloc) => bloc
                                                    .state
                                                    .activityResponse
                                                    .last[AppString.gender]) ==
                                                AppString.male
                                            ? 3700
                                            : 2700))
                                : 0,
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.colorGrey3,
                                  borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(
                                          AppDimens.dimens_15),
                                      bottomRight:
                                          LocalPref.getInt(AppString.water)! == 0
                                              ? const Radius.circular(
                                                  AppDimens.dimens_15)
                                              : const Radius.circular(
                                                  AppDimens.dimens_0),
                                      bottomLeft:
                                          LocalPref.getInt(AppString.water)! ==
                                                  0
                                              ? const Radius.circular(
                                                  AppDimens.dimens_15)
                                              : const Radius.circular(
                                                  AppDimens.dimens_0),
                                      topRight: const Radius.circular(
                                          AppDimens.dimens_15))),
                            ),
                          ),
                        ],
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
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_25,
                                AppFont.semiBold,
                                AppColor.blackColor),
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  LocalPref.getInt(AppString.water) != null
                                      ? (LocalPref.getInt(AppString.water)! /
                                              1000)
                                          .toString()
                                      : '0',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_35,
                                      AppFont.medium,
                                      AppColor.blackColor)),
                              Text(
                                context.select((ActivityBloc bloc) => bloc
                                            .state
                                            .activityResponse
                                            .last[AppString.gender]) ==
                                        AppString.male
                                    ? '/3.7 Liters'
                                    : '/2.7 Liters',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_20,
                                    AppFont.medium,
                                    AppColor.colorGrey4),
                              ),
                            ],
                          ),
                        ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<RecipesToggleBloc>()
                                            .add(AddEvent());
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
                                    Text(
                                      '${context.read<RecipesToggleBloc>().value}ml',
                                      style: AppAnother.textStyleDefault(
                                          AppDimens.dimens_20,
                                          AppFont.normal,
                                          AppColor.blackColor),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<RecipesToggleBloc>()
                                            .add(RemoveEvent());
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
                                  if ((LocalPref.getInt(
                                              dateTime.hour.toString())! +
                                          context
                                              .read<RecipesToggleBloc>()
                                              .value) <=
                                      1000) {
                                    context.read<RecipesToggleBloc>().add(
                                        AddWaterEvent(
                                            dateTime.hour.toString()));
                                  }
                                },
                                child: Container(
                                  height: AppDimens.dimens_120,
                                  width: AppDimens.dimens_40,
                                  decoration: BoxDecoration(
                                      color: AppColor.blackColor,
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.dimens_20)),
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
                ])),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.dimens_20,
                    vertical: AppDimens.dimens_10),
                child: Text(
                  'Water Intake In Day',
                  style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                      AppFont.semiBold, AppColor.blackColor),
                )),
            Container(
              height: AppDimens.dimens_200,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimens.dimens_20,
                  vertical: AppDimens.dimens_10),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                    NumericAxis(minimum: 0, maximum: 1000, interval: 100),
                series: <ChartSeries<ChartData, String>>[
                  ColumnSeries(
                      dataSource: [ChartData('1', 200), ChartData('2', 300)],
                      xValueMapper: (ChartData data, index) => data.hour,
                      yValueMapper: (ChartData data, index) => data.value,
                      color: AppColor.blue1.withOpacity(0.5))
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
