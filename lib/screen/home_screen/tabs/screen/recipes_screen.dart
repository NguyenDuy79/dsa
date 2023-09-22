import 'package:fitness_app_bloc/common_bloc/bloc_index/index_common_bloc.dart';
import 'package:fitness_app_bloc/config/config.dart';
import 'package:fitness_app_bloc/reused/method_reused.dart';
import 'package:fitness_app_bloc/screen/home_screen/tabs/widget/recipes/calories.dart';
import 'package:fitness_app_bloc/screen/into_screen/home_page_bloc/home_page_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final TextEditingController controllerProtein = TextEditingController();
  final TextEditingController controllerFat = TextEditingController();
  final DateTime dateTime =
      DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  final PageController controller = PageController(
      initialPage: MethodReused.getWeek(
              DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())))
          .indexWhere(
    (element) =>
        DateFormat('E').format(
            DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()))) ==
        DateFormat('E').format(element),
  ));
  @override
  void dispose() {
    controllerFat.dispose();
    controllerProtein.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocProvider<IndexCommonBloc>(
      create: (context) => IndexCommonBloc()
        ..add(ScrollPageView(MethodReused.getWeek(dateTime).indexWhere(
          (element) =>
              DateFormat('E').format(dateTime) ==
              DateFormat('E').format(element),
        ))),
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          centerTitle: true,
          elevation: AppDimens.dimens_0,
          title: Text(
            'Recipes',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
          ),
          actions: [
            SizedBox(
              width: width * 0.27,
              child: GestureDetector(
                onTap: () {
                  context
                      .read<HomePageBloc>()
                      .add(UntiChange(!context.read<HomePageBloc>().isMetric));
                },
                child: Container(
                  padding: const EdgeInsets.all(AppDimens.dimens_3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocConsumer<HomePageBloc, HomePageState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Text(
                            context.read<HomePageBloc>().isMetric
                                ? AppString.calories
                                : AppString.water,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_17,
                                AppFont.medium,
                                AppColor.blackColor),
                          );
                        },
                      ),
                      const Icon(
                        Icons.refresh_outlined,
                        size: AppDimens.dimens_25,
                        color: AppColor.blackColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            BlocBuilder<IndexCommonBloc, IndexCommonState>(
              builder: (context, state) {
                return SizedBox(
                  width: width,
                  height: AppDimens.dimens_60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: MethodReused.getWeek(dateTime).length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: width / 7,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  DateFormat('E').format(
                                      MethodReused.getWeek(dateTime)[index]),
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_12,
                                      AppFont.medium,
                                      AppColor.colorGrey4)),
                              GestureDetector(
                                onTap: () {
                                  controller.animateToPage(index,
                                      duration:
                                          const Duration(microseconds: 100),
                                      curve: Curves.linear);
                                },
                                child: CircleAvatar(
                                  backgroundColor: dayNotComeYet(dateTime,
                                          MethodReused.getWeek(dateTime)[index])
                                      ? AppColor.colorGrey3
                                      : state.index != index
                                          ? AppColor.colorGrey2
                                          : AppColor.blackColor,
                                  child: Text(
                                    DateFormat('dd').format(
                                        MethodReused.getWeek(dateTime)[index]),
                                    style: AppAnother.textStyleDefault(
                                        AppDimens.dimens_20,
                                        AppFont.semiBold,
                                        dayNotComeYet(
                                                dateTime,
                                                MethodReused.getWeek(
                                                    dateTime)[index])
                                            ? AppColor.whiteColor
                                            : state.index != index.toDouble()
                                                ? AppColor.blackColor
                                                : AppColor.whiteColor),
                                  ),
                                ),
                              ),
                            ]),
                      );
                    },
                  ),
                );
              },
            ),
            CaloriesWidget(
                controller,
                dateTime,
                listDayNow(dateTime, MethodReused.getWeek(dateTime)),
                controllerProtein,
                controllerFat,
                key)
          ],
        )),
      ),
    );
  }
}

bool dayNotComeYet(DateTime dateTime, DateTime dataTime1) {
  return dataTime1.difference(dateTime).inDays >= 1;
}

int listDayNow(DateTime dateTime, List<DateTime> listDateTime) {
  int count = 0;
  for (int i = 0; i < listDateTime.length; i++) {
    if (listDateTime[i].difference(dateTime).inDays <= 0) {
      count += 1;
    }
  }
  return count;
}
