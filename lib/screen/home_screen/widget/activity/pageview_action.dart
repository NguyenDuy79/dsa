import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../config/app_another.dart';
import '../../../../config/app_color.dart';
import '../../../../config/app_dimens.dart';
import '../../../../config/app_font.dart';

class PageViewActionWidget extends StatelessWidget {
  PageViewActionWidget(this.width, {super.key});
  final double width;
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: (width - AppDimens.dimens_30) / 2,
          child: PageView(
            scrollDirection: Axis.vertical,
            controller: controller,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(AppDimens.dimens_10),
                decoration: BoxDecoration(
                    color: AppColor.greenColor,
                    borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Calories',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.themeColor),
                        ),
                        const Icon(
                          Icons.local_fire_department,
                          color: AppColor.whiteColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: AppDimens.dimens_10,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(bottom: AppDimens.dimens_10),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: SizedBox(
                              height: (width - AppDimens.dimens_30) / 2 -
                                  AppDimens.dimens_30,
                              width: (width - AppDimens.dimens_30) / 2 -
                                  AppDimens.dimens_30,
                              child: RotationTransition(
                                turns: const AlwaysStoppedAnimation(180 / 360),
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      AppColor.whiteColor.withOpacity(0.2),
                                  color: AppColor.whiteColor,
                                  value: 0.2,
                                  strokeWidth: AppDimens.dimens_10,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: (width - AppDimens.dimens_30) / 2 -
                                AppDimens.dimens_30,
                            width: (width - AppDimens.dimens_30) / 2 -
                                AppDimens.dimens_30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '700',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_32,
                                      AppFont.medium,
                                      AppColor.whiteColor),
                                ),
                                Text(
                                  'kCal',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.light,
                                      AppColor.colorGrey3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppDimens.dimens_10),
                decoration: BoxDecoration(
                    color: AppColor.blueColor1.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Steps',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.purple1),
                        ),
                        const Icon(
                          Icons.directions_walk,
                          color: AppColor.purple1,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: AppDimens.dimens_10,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(bottom: AppDimens.dimens_10),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: SizedBox(
                              height: (width - AppDimens.dimens_30) / 2 -
                                  AppDimens.dimens_30,
                              width: (width - AppDimens.dimens_30) / 2 -
                                  AppDimens.dimens_30,
                              child: RotationTransition(
                                turns: const AlwaysStoppedAnimation(180 / 360),
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      AppColor.purple1.withOpacity(0.2),
                                  color: AppColor.purple1,
                                  value: 0.2,
                                  strokeWidth: AppDimens.dimens_10,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: (width - AppDimens.dimens_30) / 2 -
                                AppDimens.dimens_30,
                            width: (width - AppDimens.dimens_30) / 2 -
                                AppDimens.dimens_30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '700',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_32,
                                      AppFont.medium,
                                      AppColor.purple1),
                                ),
                                Text(
                                  'steps',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.light,
                                      AppColor.purple1.withOpacity(0.6)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: AppDimens.dimens_2_5,
        ),
        SizedBox(
          width: AppDimens.dimens_5,
          height: AppDimens.dimens_70,
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
