import 'package:fitness_app_bloc/config/app_another.dart';
import 'package:fitness_app_bloc/config/app_color.dart';
import 'package:fitness_app_bloc/config/app_dimens.dart';
import 'package:fitness_app_bloc/config/app_font.dart';
import 'package:fitness_app_bloc/config/app_path.dart';
import 'package:fitness_app_bloc/config/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home_page_bloc/home_page_bloc.dart';

class IntoScreen extends StatelessWidget {
  const IntoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColor.whiteColor,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.8,
                    width: width,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(AppDimens.dimens_15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: height * 0.6,
                                width: width,
                                child: Image.asset(AppPath.healthImage),
                              ),
                              Text(
                                'Health Management',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_25,
                                    AppFont.medium,
                                    AppColor.blackColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(AppDimens.dimens_15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: height * 0.6,
                                width: width,
                                child: Image.asset(AppPath.menuImage),
                              ),
                              Text(
                                'Food Management',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_25,
                                    AppFont.medium,
                                    AppColor.blackColor),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(AppDimens.dimens_15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: height * 0.6,
                                width: width,
                                child: Image.asset(AppPath.scheduleImage),
                              ),
                              Text(
                                'Schedule a workout',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_25,
                                    AppFont.medium,
                                    AppColor.blackColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                    child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: const WormEffect(
                            strokeWidth: AppDimens.dimens_0,
                            dotColor: AppColor.colorGrey2,
                            dotHeight: AppDimens.dimens_5,
                            dotWidth: AppDimens.dimens_10,
                            activeDotColor: AppColor.blackColor,
                            spacing: AppDimens.dimens_10,
                            paintStyle: PaintingStyle.fill)),
                  )
                ],
              ),
            ),
            bottomNavigationBar: BlocBuilder<HomePageBloc, HomePageState>(
              builder: (context, state) => Container(
                height: height * 0.1,
                width: width,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.dimens_20,
                    vertical: AppDimens.dimens_10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.greenColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppDimens.dimens_15)),
                        elevation: AppDimens.dimens_0),
                    onPressed: () {
                      if (context.read<HomePageBloc>().pageView < 2) {
                        BlocProvider.of<HomePageBloc>(context)
                            .add(PageViewChange());
                        controller.animateToPage(
                            context.read<HomePageBloc>().pageView + 1,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                      } else {
                        Navigator.of(context).pushReplacementNamed(
                          RouteGenerator.enterInformation,
                        );
                      }
                    },
                    child: context.read<HomePageBloc>().pageView == 2
                        ? Text(
                            'Let`s Start',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_25,
                                AppFont.semiBold,
                                AppColor.whiteColor),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Next',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_25,
                                    AppFont.semiBold,
                                    AppColor.whiteColor),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColor.whiteColor,
                              )
                            ],
                          )),
              ),
            )));
  }
}
