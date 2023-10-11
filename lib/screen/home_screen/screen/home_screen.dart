import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../common_bloc/bloc_index/index_common_bloc.dart';
import '../../../config/config.dart';
import '../../../reused/reused.dart';
import '../bloc/bloc_home_index/home_index_bloc.dart';
import 'activity_screen.dart';
import 'analytics_screen.dart';
import 'recipes_screen.dart';
import 'setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController controller = PageController(
      initialPage: MethodReused.getWeek(DateTime.now()).indexWhere(
    (element) =>
        DateFormat('E').format(DateTime.now()) ==
        DateFormat('E').format(element),
  ));
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.now();

    List<Widget> bottomNavScreen = <Widget>[
      const ActivityScreen(),
      AnalyticsScreen(controller),
      RecipesScreen(controller),
      const SettingScreen()
    ];
    return BlocConsumer<HomeIndexBloc, HomeIndexState>(
      listener: (contex, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: bottomNavScreen.elementAt(state.index),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: AppAnother.bottomNavItems,
            iconSize: AppDimens.dimens_26,
            currentIndex: state.index,
            backgroundColor: AppColor.whiteColor,
            unselectedItemColor: AppColor.colorGrey4,
            selectedItemColor: AppColor.greenColor,
            onTap: (index) {
              context
                  .read<IndexCommonBloc>()
                  .add(ScrollPageView(MethodReused.getWeek(dateTime).indexWhere(
                    (element) =>
                        DateFormat('E').format(dateTime) ==
                        DateFormat('E').format(element),
                  )));
              context.read<HomeIndexBloc>().add(TabIndex(index));
            },
          ),
        );
      },
    );
  }
}
