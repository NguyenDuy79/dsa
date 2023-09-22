import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/config.dart';
import '../bloc/bloc_home_index/home_index_bloc.dart';

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
              context.read<HomeIndexBloc>().add(TabIndex(index));
            },
          ),
        );
      },
    );
  }
}
