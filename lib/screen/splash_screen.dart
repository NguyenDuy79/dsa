import 'package:fitness_app_bloc/config/app_path.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/config/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/local/prefs.dart';
import '../db/database_helper.dart';
import 'into_screen/home_page_bloc/home_page_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    BlocProvider.of<HomePageBloc>(context).add(SetSplash());
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) async {
        if (state is SplashLoaded) {
          var listData = await DbHelper().getData(AppString.informationTable);
          bool seen = LocalPref.getBool('seen') ?? false;

          if (seen) {
            if (listData.isEmpty) {
              // ignore: use_build_context_synchronously
              Navigator.popAndPushNamed(
                  context, RouteGenerator.enterInformation);
            } else {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, RouteGenerator.homePage);
            }
          } else {
            LocalPref.setBool('seen', true);
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacementNamed(
              RouteGenerator.intoScreen,
            );
          }
        }
      },
      builder: ((context, state) {
        return Scaffold(
          body: Center(
            child: SizedBox(
              height: height * 0.7,
              width: width * 0.7,
              child: Image.asset(AppPath.splashImage),
            ),
          ),
        );
      }),
    );
  }
}
