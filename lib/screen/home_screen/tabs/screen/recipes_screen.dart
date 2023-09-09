import 'package:fitness_app_bloc/config/config.dart';

import 'package:fitness_app_bloc/screen/home_screen/tabs/bloc/bloc/recipes_toggle_bloc.dart';
import 'package:fitness_app_bloc/screen/home_screen/tabs/widget/recipes/calories.dart';
import 'package:fitness_app_bloc/screen/home_screen/tabs/widget/recipes/water.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                context.read<RecipesToggleBloc>().add(
                    ToggleEvent(!context.read<RecipesToggleBloc>().toggle));
              },
              child: Container(
                padding: const EdgeInsets.all(AppDimens.dimens_3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocConsumer<RecipesToggleBloc, RecipesToggleState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Text(
                          context.read<RecipesToggleBloc>().toggle
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
          child: BlocConsumer<RecipesToggleBloc, RecipesToggleState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (context.read<RecipesToggleBloc>().toggle) {
            return const CaloriesWidget();
          } else {
            return const WaterWidget();
          }
        },
      )),
    );
  }
}
