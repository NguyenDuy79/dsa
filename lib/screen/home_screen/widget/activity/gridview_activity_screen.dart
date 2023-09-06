import 'package:fitness_app_bloc/config/config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common_bloc/bloc_activity/activity_bloc.dart';

class GridViewActivity extends StatelessWidget {
  const GridViewActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: ((width - AppDimens.dimens_30) / 2) * 3 + AppDimens.dimens_50,
      margin: const EdgeInsets.symmetric(horizontal: AppDimens.dimens_10),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimens.dimens_10,
        childAspectRatio: 1,
        mainAxisSpacing: AppDimens.dimens_10,
        physics: const NeverScrollableScrollPhysics(),
        semanticChildCount: 6,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RouteGenerator.historyScreen);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.dimens_15),
                  color: AppColor.whiteColor),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.dimens_15,
                  vertical: AppDimens.dimens_10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('History',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.semiBold, AppColor.blackColor)),
                  Text('Strength',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.medium, AppColor.darkgrey)),
                  Expanded(
                      child: Center(
                          child: Image.asset(
                    AppPath.fitnessImage,
                  ))),
                  Text(
                    '5/12',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_15,
                        AppFont.normal, AppColor.blackColor),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RouteGenerator.informationScreen);
            },
            child: BlocConsumer<ActivityBloc, ActivityState>(
                listener: (context, state) async {},
                builder: (context, state) {
                  if (state is ActivityLoaded) {
                    Map<String, Object?> value = state
                        .activityResponse[state.activityResponse.length - 1];

                    return Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppDimens.dimens_15),
                          color: AppColor.whiteColor),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.dimens_15,
                          vertical: AppDimens.dimens_10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Information',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.semiBold,
                                  AppColor.blackColor)),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.circle,
                                color: AppColor.blue1,
                                size: AppDimens.dimens_10,
                              ),
                              const SizedBox(
                                width: AppDimens.dimens_5,
                              ),
                              Text(
                                'Age: ${DateTime.now().difference(DateTime.parse(value[AppString.age] as String)).inDays ~/ 365.25}',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.medium,
                                    Colors.black),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.circle,
                                color: AppColor.yellowColor1,
                                size: AppDimens.dimens_10,
                              ),
                              const SizedBox(
                                width: AppDimens.dimens_5,
                              ),
                              Text(
                                '${AppString.height}: ${value[AppString.height]}',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.medium,
                                    Colors.black),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.circle,
                                color: AppColor.orangeColor1,
                                size: AppDimens.dimens_10,
                              ),
                              const SizedBox(
                                width: AppDimens.dimens_5,
                              ),
                              Text(
                                '${AppString.weight}: ${value[AppString.weight]}',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.medium,
                                    Colors.black),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.circle,
                                color: AppColor.redColor1,
                                size: AppDimens.dimens_10,
                              ),
                              const SizedBox(
                                width: AppDimens.dimens_5,
                              ),
                              Text(
                                'Body Fat: ${value[AppString.bodyFat]}%',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.medium,
                                    Colors.black),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }
                  if (state is ActivityLoading) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppDimens.dimens_15),
                          color: AppColor.whiteColor),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.dimens_15,
                          vertical: AppDimens.dimens_10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Information',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.semiBold,
                                  AppColor.blackColor)),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.circle,
                                color: AppColor.blue1,
                                size: AppDimens.dimens_10,
                              ),
                              const SizedBox(
                                width: AppDimens.dimens_5,
                              ),
                              Text(
                                'Age: 23',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.medium,
                                    Colors.black),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.circle,
                                color: AppColor.yellowColor1,
                                size: AppDimens.dimens_10,
                              ),
                              const SizedBox(
                                width: AppDimens.dimens_5,
                              ),
                              Text(
                                'Height: 176 cm',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.medium,
                                    Colors.black),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.circle,
                                color: AppColor.orangeColor1,
                                size: AppDimens.dimens_10,
                              ),
                              const SizedBox(
                                width: AppDimens.dimens_5,
                              ),
                              Text(
                                'Weight: 76 kg',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.medium,
                                    Colors.black),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.circle,
                                color: AppColor.redColor1,
                                size: AppDimens.dimens_10,
                              ),
                              const SizedBox(
                                width: AppDimens.dimens_5,
                              ),
                              Text(
                                'Body Fat: 20 %',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.medium,
                                    Colors.black),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.dimens_15),
                  color: AppColor.whiteColor),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.dimens_15,
                  vertical: AppDimens.dimens_10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Sleep',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.semiBold, AppColor.blackColor)),
                  Row(
                    children: <Widget>[
                      Text('20',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_25,
                              AppFont.semiBold,
                              AppColor.blackColor)),
                      const SizedBox(
                        width: AppDimens.dimens_5,
                      ),
                      Text('minute',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_16,
                              AppFont.normal,
                              AppColor.darkgrey)),
                    ],
                  ),
                  Expanded(
                    child: Center(
                        child: SizedBox(
                      height: AppDimens.dimens_7,
                      width: (width - AppDimens.dimens_30) / 2 -
                          AppDimens.dimens_30,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: AppDimens.dimens_7,
                            width: (width - AppDimens.dimens_30) / 2 -
                                AppDimens.dimens_30,
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_3)),
                          ),
                          Positioned(
                            left: AppDimens.dimens_0,
                            top: AppDimens.dimens_0,
                            child: Container(
                              width: ((width - AppDimens.dimens_30) / 2 -
                                      AppDimens.dimens_30) *
                                  0.2,
                              height: AppDimens.dimens_7,
                              decoration: BoxDecoration(
                                  color: AppColor.purple1,
                                  borderRadius: BorderRadius.circular(
                                      AppDimens.dimens_3)),
                            ),
                          ),
                          Positioned(
                            left: ((width - AppDimens.dimens_30) / 2 -
                                        AppDimens.dimens_30) *
                                    0.2 +
                                AppDimens.dimens_2,
                            top: AppDimens.dimens_0,
                            child: Container(
                              width: ((width - AppDimens.dimens_30) / 2 -
                                      AppDimens.dimens_30) *
                                  0.8,
                              height: AppDimens.dimens_7,
                              decoration: BoxDecoration(
                                  color: AppColor.orangeColor1,
                                  borderRadius: BorderRadius.circular(
                                      AppDimens.dimens_3)),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                  Text(
                    '5/12',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_15,
                        AppFont.normal, AppColor.blackColor),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.dimens_15),
                  color: AppColor.whiteColor),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.dimens_15,
                  vertical: AppDimens.dimens_10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Heartbeat',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.semiBold, AppColor.blackColor)),
                  Row(
                    children: <Widget>[
                      Text('87',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_25,
                              AppFont.semiBold,
                              AppColor.blackColor)),
                      const SizedBox(
                        width: AppDimens.dimens_5,
                      ),
                      Text('bmp',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_16,
                              AppFont.normal,
                              AppColor.darkgrey)),
                    ],
                  ),
                  Expanded(
                    child: Center(
                        child: SizedBox(
                      height: AppDimens.dimens_7,
                      width: (width - AppDimens.dimens_30) / 2 -
                          AppDimens.dimens_30,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: AppDimens.dimens_7,
                            width: (width - AppDimens.dimens_30) / 2 -
                                AppDimens.dimens_30,
                            decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_3)),
                          ),
                          Positioned(
                            left: AppDimens.dimens_0,
                            top: AppDimens.dimens_0,
                            child: Container(
                              width: ((width - AppDimens.dimens_30) / 2 -
                                      AppDimens.dimens_30) *
                                  0.2,
                              height: AppDimens.dimens_7,
                              decoration: BoxDecoration(
                                  color: AppColor.purple1,
                                  borderRadius: BorderRadius.circular(
                                      AppDimens.dimens_3)),
                            ),
                          ),
                          Positioned(
                            left: ((width - AppDimens.dimens_30) / 2 -
                                        AppDimens.dimens_30) *
                                    0.2 +
                                AppDimens.dimens_2,
                            top: AppDimens.dimens_0,
                            child: Container(
                              width: ((width - AppDimens.dimens_30) / 2 -
                                      AppDimens.dimens_30) *
                                  0.8,
                              height: AppDimens.dimens_7,
                              decoration: BoxDecoration(
                                  color: AppColor.orangeColor1,
                                  borderRadius: BorderRadius.circular(
                                      AppDimens.dimens_3)),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                  Text(
                    '5/12',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_15,
                        AppFont.normal, AppColor.blackColor),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.dimens_15),
                color: AppColor.whiteColor),
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.dimens_15, vertical: AppDimens.dimens_10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('SpO',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                            AppFont.semiBold, AppColor.blackColor)),
                    Text('2',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_13,
                            AppFont.semiBold, AppColor.blackColor)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('99',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                            AppFont.semiBold, AppColor.blackColor)),
                    Text('%',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_16,
                            AppFont.semiBold, AppColor.darkgrey)),
                  ],
                ),
                Expanded(
                  child: Center(
                      child: SizedBox(
                    height: AppDimens.dimens_7,
                    width:
                        (width - AppDimens.dimens_30) / 2 - AppDimens.dimens_30,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: AppDimens.dimens_7,
                          width: (width - AppDimens.dimens_30) / 2 -
                              AppDimens.dimens_30,
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius:
                                  BorderRadius.circular(AppDimens.dimens_3)),
                        ),
                        Positioned(
                          left: AppDimens.dimens_0,
                          top: AppDimens.dimens_0,
                          child: Container(
                            width: ((width - AppDimens.dimens_30) / 2 -
                                    AppDimens.dimens_30) *
                                0.2,
                            height: AppDimens.dimens_7,
                            decoration: BoxDecoration(
                                color: AppColor.purple1,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_3)),
                          ),
                        ),
                        Positioned(
                          left: ((width - AppDimens.dimens_30) / 2 -
                                      AppDimens.dimens_30) *
                                  0.2 +
                              AppDimens.dimens_2,
                          top: AppDimens.dimens_0,
                          child: Container(
                            width: ((width - AppDimens.dimens_30) / 2 -
                                    AppDimens.dimens_30) *
                                0.8,
                            height: AppDimens.dimens_7,
                            decoration: BoxDecoration(
                                color: AppColor.orangeColor1,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_3)),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                Text(
                  '5/12',
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_15, AppFont.normal, AppColor.blackColor),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.dimens_15),
                color: AppColor.whiteColor),
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.dimens_15, vertical: AppDimens.dimens_10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FittedBox(
                  child: Text('Blood pressure',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.semiBold, AppColor.blackColor)),
                ),
                FittedBox(
                  child: Row(
                    children: <Widget>[
                      Text('120/88',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_25,
                              AppFont.semiBold,
                              AppColor.blackColor)),
                      const SizedBox(
                        width: AppDimens.dimens_5,
                      ),
                      Text('mmHg',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_16,
                              AppFont.normal,
                              AppColor.darkgrey)),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                      child: SizedBox(
                    height: AppDimens.dimens_7,
                    width:
                        (width - AppDimens.dimens_30) / 2 - AppDimens.dimens_30,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: AppDimens.dimens_7,
                          width: (width - AppDimens.dimens_30) / 2 -
                              AppDimens.dimens_30,
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius:
                                  BorderRadius.circular(AppDimens.dimens_3)),
                        ),
                        Positioned(
                          left: AppDimens.dimens_0,
                          top: AppDimens.dimens_0,
                          child: Container(
                            width: ((width - AppDimens.dimens_30) / 2 -
                                    AppDimens.dimens_30) *
                                0.2,
                            height: AppDimens.dimens_7,
                            decoration: BoxDecoration(
                                color: AppColor.purple1,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_3)),
                          ),
                        ),
                        Positioned(
                          left: ((width - AppDimens.dimens_30) / 2 -
                                      AppDimens.dimens_30) *
                                  0.2 +
                              AppDimens.dimens_2,
                          top: AppDimens.dimens_0,
                          child: Container(
                            width: ((width - AppDimens.dimens_30) / 2 -
                                    AppDimens.dimens_30) *
                                0.8,
                            height: AppDimens.dimens_7,
                            decoration: BoxDecoration(
                                color: AppColor.orangeColor1,
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_3)),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                Text(
                  '5/12',
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_15, AppFont.normal, AppColor.blackColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
