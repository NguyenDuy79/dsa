import 'package:fitness_app_bloc/common_bloc/bloc_activity/activity_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_recipes/recipes_bloc.dart';
import 'package:fitness_app_bloc/config/app_another.dart';
import 'package:fitness_app_bloc/config/app_color.dart';
import 'package:fitness_app_bloc/config/app_dimens.dart';
import 'package:fitness_app_bloc/config/app_font.dart';
import 'package:fitness_app_bloc/reused/method_reused.dart';
import 'package:fitness_app_bloc/reused/widget_reused.dart';
import 'package:fitness_app_bloc/screen/into_screen/home_page_bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../config/app_string.dart';
import '../../../../../data/local/prefs.dart';
import '../../bloc/bloc_home_index/home_index_bloc.dart';

class PageViewRecipesWidget extends StatelessWidget {
  const PageViewRecipesWidget(this.width, {super.key});
  final double width;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
            width: (width - AppDimens.dimens_30) / 2,
            child: PageView(
                controller: controller,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  BlocConsumer<RecipesBloc, RecipesState>(
                    buildWhen: (previous, current) =>
                        previous.dataRecipes != current.dataRecipes ||
                        previous.dataMeals != current.dataMeals,
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is RecipesLoaded) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<HomeIndexBloc>()
                                .add(const TabIndex(2));
                          },
                          child: Container(
                              padding: const EdgeInsets.only(
                                  top: AppDimens.dimens_15,
                                  bottom: AppDimens.dimens_15,
                                  left: AppDimens.dimens_15,
                                  right: AppDimens.dimens_10),
                              decoration: BoxDecoration(
                                  color: AppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(
                                      AppDimens.dimens_15)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        WidgetReused.progress(
                                            state.dataRecipes.isEmpty
                                                ? 0
                                                : (double.parse(state.dataRecipes[
                                                                AppString
                                                                    .protein]
                                                            as String) ==
                                                        0.0)
                                                    ? 0
                                                    : LocalPref.getDouble(AppString.protein)! /
                                                        double.parse(
                                                            state.dataRecipes[AppString.protein]
                                                                as String),
                                            state.dataRecipes.isEmpty
                                                ? '0'
                                                : MethodReused.filterDouble(
                                                    LocalPref.getDouble(
                                                            AppString.protein)!
                                                        .toStringAsFixed(1)),
                                            AppColor.orangeColor1),
                                        const SizedBox(
                                          width: AppDimens.dimens_15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Protein',
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_18,
                                                      AppFont.medium,
                                                      AppColor.blackColor),
                                            ),
                                            Text(
                                              '${state.dataRecipes.isEmpty ? '0' : state.dataRecipes[AppString.protein]}g',
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_15,
                                                      AppFont.light,
                                                      AppColor.colorGrey4),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        WidgetReused.progress(
                                            state.dataRecipes.isEmpty
                                                ? 0
                                                : double.parse(state.dataRecipes[
                                                                AppString.protein]
                                                            as String) ==
                                                        0.0
                                                    ? 0
                                                    : LocalPref.getDouble(AppString.fats)! /
                                                        double.parse(state
                                                                .dataRecipes[AppString.fats]
                                                            as String),
                                            state.dataRecipes.isEmpty
                                                ? '0'
                                                : MethodReused.filterDouble(
                                                    LocalPref.getDouble(
                                                            AppString.fats)!
                                                        .toStringAsFixed(1)),
                                            AppColor.redColor1),
                                        const SizedBox(
                                          width: AppDimens.dimens_15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Fats',
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_18,
                                                      AppFont.medium,
                                                      AppColor.blackColor),
                                            ),
                                            Text(
                                              '${state.dataRecipes.isEmpty ? '0' : state.dataRecipes[AppString.fats]}g',
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_15,
                                                      AppFont.light,
                                                      AppColor.colorGrey4),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        WidgetReused.progress(
                                            state.dataRecipes.isEmpty
                                                ? 0
                                                : double.parse(state.dataRecipes[
                                                                AppString.protein]
                                                            as String) ==
                                                        0.0
                                                    ? 0
                                                    : LocalPref.getDouble(
                                                            AppString.carbs)! /
                                                        double.parse(state
                                                                .dataRecipes[AppString.carbs]
                                                            as String),
                                            state.dataRecipes.isEmpty
                                                ? '0'
                                                : MethodReused.filterDouble(
                                                    LocalPref.getDouble(AppString.carbs)!
                                                        .toStringAsFixed(1)),
                                            AppColor.yellowColor1),
                                        const SizedBox(
                                          width: AppDimens.dimens_15,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Carbs',
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_18,
                                                      AppFont.medium,
                                                      AppColor.blackColor),
                                            ),
                                            Text(
                                              '${state.dataRecipes.isEmpty ? '0' : state.dataRecipes[AppString.carbs]}g',
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_15,
                                                      AppFont.light,
                                                      AppColor.colorGrey4),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ])),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<HomeIndexBloc>().add(const TabIndex(2));
                      context.read<HomePageBloc>().add(UntiChange(false));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(AppDimens.dimens_15),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppDimens.dimens_15),
                          color: AppColor.blue1.withOpacity(0.6)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Water',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_25,
                                    AppFont.semiBold,
                                    AppColor.whiteColor),
                              ),
                              const Icon(
                                Icons.water_drop_outlined,
                                size: AppDimens.dimens_30,
                                color: AppColor.whiteColor,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: AppDimens.dimens_10,
                          ),
                          LinearProgressIndicator(
                            backgroundColor:
                                AppColor.whiteColor.withOpacity(0.2),
                            color: AppColor.whiteColor,
                            value: LocalPref.getInt(AppString.water) == null
                                ? 0
                                : (context.select((ActivityBloc bloc) =>
                                        bloc.state.activityResponse)).isNotEmpty
                                    ? LocalPref.getInt(AppString.water)! /
                                        (context
                                                    .select((ActivityBloc
                                                            bloc) =>
                                                        bloc.state
                                                            .activityResponse)
                                                    .first[AppString.gender] ==
                                                AppString.male
                                            ? 3700
                                            : 2700)
                                    : 0,
                            minHeight: AppDimens.dimens_5,
                          ),
                          const SizedBox(
                            height: AppDimens.dimens_10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Now',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.medium,
                                    AppColor.whiteColor),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    LocalPref.getInt(AppString.water) != null
                                        ? LocalPref.getInt(AppString.water)
                                            .toString()
                                        : '0',
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_18,
                                        AppFont.medium,
                                        AppColor.whiteColor),
                                  ),
                                  Text(
                                    ' liters',
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_15,
                                        AppFont.normal,
                                        AppColor.colorGrey0),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Target',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.medium,
                                    AppColor.whiteColor),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    context
                                            .select((ActivityBloc bloc) =>
                                                bloc.state.activityResponse)
                                            .isNotEmpty
                                        ? (context
                                                        .select((ActivityBloc
                                                                bloc) =>
                                                            bloc.state
                                                                .activityResponse)
                                                        .first[AppString.gender] ==
                                                    AppString.male
                                                ? 3700
                                                : 2700)
                                            .toString()
                                        : '0',
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_18,
                                        AppFont.medium,
                                        AppColor.whiteColor),
                                  ),
                                  Text(
                                    ' liters',
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_15,
                                        AppFont.normal,
                                        AppColor.colorGrey0),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ])),
        const SizedBox(
          width: AppDimens.dimens_2_5,
        ),
        SizedBox(
          width: AppDimens.dimens_5,
          height: AppDimens.dimens_50,
          child: Center(
            child: SmoothPageIndicator(
              axisDirection: Axis.vertical,
              controller: controller,
              count: 2,
              effect: WormEffect(
                  strokeWidth: AppDimens.dimens_0,
                  dotColor: AppColor.blueColor1.withOpacity(0.5),
                  dotHeight: AppDimens.dimens_5,
                  dotWidth: AppDimens.dimens_10,
                  activeDotColor: AppColor.pink1,
                  spacing: AppDimens.dimens_10,
                  paintStyle: PaintingStyle.fill),
            ),
          ),
        )
      ],
    );
  }
}
