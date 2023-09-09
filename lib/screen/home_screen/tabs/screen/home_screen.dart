import 'package:fitness_app_bloc/data/local/prefs.dart';
import 'package:fitness_app_bloc/screen/home_screen/bloc/home_index_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../config/config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.now();
    if (LocalPref.getString(AppString.dateTime) == null) {
      LocalPref.setString(AppString.dateTime, dateTime.toString());
      LocalPref.setDouble(AppString.calories, 0);
      LocalPref.setDouble(AppString.protein, 0);
      LocalPref.setDouble(AppString.fats, 0);
      LocalPref.setDouble(AppString.carbs, 0);
      LocalPref.setInt(AppString.water, 0);
      for (int i = 0; i < 24; i++) {
        LocalPref.setInt(i.toString(), 0);
      }
    } else {
      if (DateFormat('dd-M-yyyy').format(
              DateTime.parse(LocalPref.getString(AppString.dateTime)!)) !=
          DateFormat('dd-M-yyyy').format(dateTime)) {
        LocalPref.setString(AppString.dateTime, dateTime.toString());
        LocalPref.setDouble(AppString.calories, 0);
        LocalPref.setDouble(AppString.protein, 0);
        LocalPref.setDouble(AppString.fats, 0);
        LocalPref.setDouble(AppString.carbs, 0);
        LocalPref.setInt(AppString.water, 0);
        for (int i = 0; i < 24; i++) {
          LocalPref.setInt(i.toString(), 0);
        }
      }
    }
    return BlocConsumer<HomeIndexBloc, HomeIndexState>(
      listener: (contex, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: AppAnother.bottomNavScreen.elementAt(state.index),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: AppAnother.bottomNavItems,
            iconSize: AppDimens.dimens_26,
            currentIndex: state.index,
            backgroundColor: AppColor.whiteColor,
            unselectedItemColor: AppColor.colorGrey4,
            selectedItemColor: AppColor.greenColor,
            onTap: (index) {
              BlocProvider.of<HomeIndexBloc>(context).add(TabIndex(index));
            },
          ),
        );
      },
    );
  }
}
