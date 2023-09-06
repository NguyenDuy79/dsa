import 'package:fitness_app_bloc/config/app_color.dart';
import 'package:fitness_app_bloc/config/app_dimens.dart';
import 'package:fitness_app_bloc/screen/home_screen/bloc/home_index_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_another.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
