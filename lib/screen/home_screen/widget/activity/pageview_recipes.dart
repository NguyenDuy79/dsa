import 'package:fitness_app_bloc/common_bloc/bloc_recipes/recipes_bloc.dart';
import 'package:fitness_app_bloc/config/app_another.dart';
import 'package:fitness_app_bloc/config/app_color.dart';
import 'package:fitness_app_bloc/config/app_dimens.dart';
import 'package:fitness_app_bloc/config/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../config/app_string.dart';
import '../../../../data/local/prefs.dart';

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
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is RecipesLoaded) {
                        return Container(
                            padding: const EdgeInsets.only(
                                top: AppDimens.dimens_15,
                                bottom: AppDimens.dimens_15,
                                left: AppDimens.dimens_15,
                                right: AppDimens.dimens_10),
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_15)),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Stack(
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              height: AppDimens.dimens_35,
                                              width: AppDimens.dimens_35,
                                              child: RotationTransition(
                                                turns:
                                                    const AlwaysStoppedAnimation(
                                                        180 / 360),
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: AppColor
                                                      .orangeColor1
                                                      .withOpacity(0.2),
                                                  color: AppColor.orangeColor1,
                                                  value: LocalPref.getInt(
                                                              AppString
                                                                  .protein) ==
                                                          null
                                                      ? 0
                                                      : double.parse(state
                                                                      .dataRecipes[AppString.protein]
                                                                  as String) ==
                                                              0.0
                                                          ? 0
                                                          : LocalPref.getInt(
                                                                  AppString
                                                                      .protein)! /
                                                              double.parse(
                                                                  state.dataRecipes[AppString.protein]
                                                                      as String),
                                                  strokeWidth:
                                                      AppDimens.dimens_5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: AppDimens.dimens_35,
                                            width: AppDimens.dimens_35,
                                            child: Center(
                                              child: Text(
                                                LocalPref.getInt(AppString
                                                            .protein) !=
                                                        null
                                                    ? LocalPref.getInt(
                                                            AppString.protein)
                                                        .toString()
                                                    : '0',
                                                style:
                                                    AppAnother.textStyleDefault(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Stack(
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              height: AppDimens.dimens_35,
                                              width: AppDimens.dimens_35,
                                              child: RotationTransition(
                                                turns:
                                                    const AlwaysStoppedAnimation(
                                                        180 / 360),
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: AppColor
                                                      .redColor1
                                                      .withOpacity(0.2),
                                                  color: AppColor.redColor1,
                                                  value: LocalPref.getInt(
                                                              AppString.fats) ==
                                                          null
                                                      ? 0
                                                      : double.parse(state.dataRecipes[
                                                                      AppString.protein]
                                                                  as String) ==
                                                              0.0
                                                          ? 0
                                                          : LocalPref.getInt(
                                                                  AppString
                                                                      .fats)! /
                                                              double.parse(state
                                                                      .dataRecipes[AppString.fats]
                                                                  as String),
                                                  strokeWidth:
                                                      AppDimens.dimens_5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: AppDimens.dimens_35,
                                            width: AppDimens.dimens_35,
                                            child: Center(
                                              child: Text(
                                                LocalPref.getInt(
                                                            AppString.fats) !=
                                                        null
                                                    ? LocalPref.getInt(
                                                            AppString.fats)
                                                        .toString()
                                                    : '0',
                                                style:
                                                    AppAnother.textStyleDefault(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Stack(
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              height: AppDimens.dimens_35,
                                              width: AppDimens.dimens_35,
                                              child: RotationTransition(
                                                turns:
                                                    const AlwaysStoppedAnimation(
                                                        180 / 360),
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: AppColor
                                                      .yellowColor1
                                                      .withOpacity(0.2),
                                                  color: AppColor.yellowColor1,
                                                  value: LocalPref.getInt(
                                                              AppString
                                                                  .carbs) ==
                                                          null
                                                      ? 0
                                                      : double.parse(state
                                                                      .dataRecipes[AppString.protein]
                                                                  as String) ==
                                                              0.0
                                                          ? 0
                                                          : LocalPref.getInt(
                                                                  AppString
                                                                      .carbs)! /
                                                              double.parse(state
                                                                      .dataRecipes[AppString.carbs]
                                                                  as String),
                                                  strokeWidth:
                                                      AppDimens.dimens_5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: AppDimens.dimens_35,
                                            width: AppDimens.dimens_35,
                                            child: Center(
                                              child: Text(
                                                LocalPref.getInt(
                                                            AppString.carbs) !=
                                                        null
                                                    ? LocalPref.getInt(
                                                            AppString.carbs)
                                                        .toString()
                                                    : '0',
                                                style:
                                                    AppAnother.textStyleDefault(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                ]));
                      } else if (state is RecipesInitial) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Container(
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
                          backgroundColor: AppColor.whiteColor.withOpacity(0.2),
                          color: AppColor.whiteColor,
                          value: 0.5,
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
                                  '2.0',
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
                                  '2.5',
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
