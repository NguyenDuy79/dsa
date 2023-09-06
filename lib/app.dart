import 'package:fitness_app_bloc/common_bloc/bloc_application/application_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/common_bloc.dart';
import 'package:fitness_app_bloc/config/app_theme.dart';
import 'package:fitness_app_bloc/config/route_generator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    CommonBloc.applicationBloc.add(SetupApplication());
    super.initState();
  }

  @override
  void dispose() {
    CommonBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: CommonBloc.blocProviders,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: themeData,
        initialRoute: RouteGenerator.splashScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
