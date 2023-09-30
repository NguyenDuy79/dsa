// ignore_for_file: prefer_null_aware_operators

import 'package:fitness_app_bloc/reused/reused.dart';
import 'package:fitness_app_bloc/screen/into_screen/home_page_bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common_bloc/bloc_history/history_bloc.dart';
import '../../../config/config.dart';

class DetailHistoryScreen extends StatelessWidget {
  const DetailHistoryScreen(this.history, {super.key});
  final Map<String, Object?> history;

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();

    final TextEditingController controller = TextEditingController();
    final TextEditingController editingController = TextEditingController();
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {},
      builder: (context, state) {
        final width = MediaQuery.of(context).size.width;
        return Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: AppDimens.dimens_0,
            backgroundColor: AppColor.whiteColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.blackColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              SizedBox(
                width: width * 0.3,
                child: GestureDetector(
                    onTap: () {
                      context.read<HomePageBloc>().add(
                          UntiChange(!context.read<HomePageBloc>().isMetric));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimens.dimens_5),
                      child: Row(
                        children: [
                          Text(
                            context.read<HomePageBloc>().isMetric
                                ? 'Metric'
                                : 'Imperial',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor),
                          ),
                          const Icon(
                            Icons.refresh_sharp,
                            color: AppColor.blackColor,
                          )
                        ],
                      ),
                    )),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time: ${MethodReused.formatTime(DateTime.parse(history['DateTimeEnd'] as String).difference(DateTime.parse(history[AppString.dateTime] as String)).inSeconds)}',
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
                ),
                const SizedBox(
                  height: AppDimens.dimens_15,
                ),
                Center(
                    child: Text(
                  history[AppString.restTime] == null
                      ? AppString.lissCardio
                      : AppString.hittCardio,
                  style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                      AppFont.semiBold, AppColor.blackColor),
                )),
                const SizedBox(
                  height: AppDimens.dimens_15,
                ),
                Expanded(
                    child: history[AppString.methodExercise].toString() ==
                            AppString.cardio
                        ? widgetHistoryCardio(
                            returnHiitMethod(
                                history[AppString.exercise].toString(),
                                (history[AppString.restTime] == null
                                    ? null
                                    : history[AppString.restTime].toString())),
                            history,
                            history[AppString.restTime] == null
                                ? AppString.lissCardio
                                : AppString.hittCardio)
                        : widgetHistoryAnother(
                            history, key, controller, editingController)),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget widgetHistoryAnother(
    Map<String, Object?> history,
    GlobalKey<FormState> key,
    TextEditingController controller,
    TextEditingController editingController) {
  return ListView.builder(
    itemCount: history[AppString.exercise].toString().split(',').length - 1,
    itemBuilder: (context, index) {
      return BlocConsumer<HistoryBloc, HistoryState>(
        listener: (context, state) {},
        builder: (context, stateHistory) {
          if (stateHistory is HistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (stateHistory is HistoryLoaded) {
            List<Map<String, Object?>>? listRepTime =
                stateHistory.dataRepAndTime;
            List<Map<String, Object?>> historyRepTime =
                getHistoryToday(listRepTime, history);

            List<Map<String, Object?>> exerciseRepAndTime =
                getListRepAndTimeToday(historyRepTime, index, history);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  history[AppString.exercise].toString().split(',')[index],
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
                ),
                SizedBox(
                  height: AppDimens.dimens_200,
                  child: ListView.builder(
                    itemCount: exerciseRepAndTime.length,
                    itemBuilder: (context, indexRepAndTime) {
                      return exerciseRepAndTime[indexRepAndTime]
                                  [AppString.exercise]
                              .toString()
                              .contains('Dropset')
                          ? WidgetReused.setItemDropset(
                              exerciseRepAndTime,
                              indexRepAndTime,
                              history,
                              index,
                              controller,
                              editingController,
                              key)
                          : exerciseRepAndTime[indexRepAndTime]
                                      [AppString.exercise]
                                  .toString()
                                  .contains('Superset')
                              ? WidgetReused.setItemSuperset(
                                  exerciseRepAndTime,
                                  indexRepAndTime,
                                  history,
                                  index,
                                  controller,
                                  editingController,
                                  key)
                              : WidgetReused.setItem(
                                  exerciseRepAndTime,
                                  indexRepAndTime,
                                  history,
                                  index,
                                  controller,
                                  editingController,
                                  key,
                                  context);
                    },
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      );
    },
  );
}

String result(String value) {
  if (value.split('.')[1] == '0') {
    return value.split('.')[0];
  } else {
    return value;
  }
}

List<Map<String, Object?>> getHistoryToday(
    List<Map<String, Object?>> listRepTime, Map<String, Object?> history) {
  List<Map<String, Object?>> result = [];
  for (var item in listRepTime) {
    if (history[AppString.dateTime] == item[AppString.dateTime]) {
      result.add(item);
      print(item[AppString.id]);
    }
  }
  return result;
}

List<Map<String, Object?>> getListRepAndTimeToday(
    List<Map<String, Object?>> historyRepTime,
    int index,
    Map<String, Object?> history) {
  List<Map<String, Object?>> result = [];
  for (var item in historyRepTime) {
    if (history[AppString.exercise].toString().split(',')[index] ==
        item[AppString.exercise].toString()) {
      result.add(item);
    }
  }
  return result;
}

Widget widgetHistoryCardio(
    String hiitMethod, Map<String, Object?> history, String cardioMethod) {
  return hiitMethod == 'group'
      ? ListView.builder(
          itemCount: history[AppString.exercise].toString().split(':').length,
          itemBuilder: (context, index) {
            return BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                List<Map<String, Object?>>? listRepTime =
                    getHistoryToday(state.dataRepAndTime, history);
                List<Map<String, Object?>> listRepAndTime = [];
                for (int i = 0; i < listRepTime.length; i++) {
                  if (listRepTime[i][AppString.level].toString() ==
                      (index + 1).toString()) {
                    listRepAndTime.add(listRepTime[i]);
                  }
                }
                print(listRepAndTime.length);
                return Column(
                  children: [
                    Text('Level ${index + 1}:',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                            AppFont.semiBold, AppColor.blackColor)),
                    const SizedBox(
                      height: AppDimens.dimens_10,
                    ),
                    SizedBox(
                      height: getHeight(listRepAndTime),
                      child: ListView.builder(
                        itemCount: listRepAndTime.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indexSet) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Set ${listRepAndTime[indexSet][AppString.setNumber]}:',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.semiBold,
                                      AppColor.blackColor)),
                              const SizedBox(
                                height: AppDimens.dimens_10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      'Time : ${MethodReused.formatTime((listRepAndTime[indexSet][AppString.exercise].toString().split(',').length - 1) * int.parse(history[AppString.time].toString()))}'),
                                  Text(
                                      'Rest time: ${history[AppString.restTime]}')
                                ],
                              ),
                              SizedBox(
                                height: (listRepAndTime[indexSet]
                                                [AppString.exercise]
                                            .toString()
                                            .split(',')
                                            .length -
                                        1) *
                                    AppDimens.dimens_20,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: listRepAndTime[indexSet]
                                              [AppString.exercise]
                                          .toString()
                                          .split(',')
                                          .length -
                                      1,
                                  itemBuilder: (context, indexExercise) {
                                    return Center(
                                      child: SizedBox(
                                        height: AppDimens.dimens_20,
                                        child: Text(listRepAndTime[indexSet]
                                                [AppString.exercise]
                                            .toString()
                                            .split(',')[indexExercise]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            );
          },
        )
      : (cardioMethod != '' &&
              AppAnother.lissCardioExercise.indexWhere((element) =>
                      element == history[AppString.exercise].toString()) >=
                  0)
          ? Text(history[AppString.exercise].toString(),
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_20, AppFont.medium, AppColor.blackColor))
          : BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, state) {
                List<Map<String, Object?>>? listRepTime = state.dataRepAndTime;
                List<Map<String, Object?>> historyRepTime =
                    getHistoryToday(listRepTime, history);
                return ListView.builder(
                    itemCount: historyRepTime.length,
                    itemBuilder: ((context, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Set ${historyRepTime[index][AppString.setNumber]}',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.semiBold,
                                      AppColor.blackColor)),
                              const SizedBox(
                                height: AppDimens.dimens_10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    cardioMethod == AppString.lissCardio
                                        ? MainAxisAlignment.center
                                        : MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      'Time : ${MethodReused.formatTime(((historyRepTime[index][AppString.exercise].toString().split(',').length - 1) * int.parse(history[AppString.time].toString())) + (cardioMethod == AppString.lissCardio ? 0 : ((historyRepTime[index][AppString.exercise].toString().split(',').length - 1) * int.parse(history[AppString.restTime].toString()))))} '),
                                  cardioMethod == AppString.lissCardio
                                      ? Container()
                                      : Text(
                                          'Rest time: ${history[AppString.restTime]}')
                                ],
                              ),
                              SizedBox(
                                height: AppDimens.dimens_20 *
                                    (historyRepTime[index][AppString.exercise]
                                            .toString()
                                            .split(',')
                                            .length -
                                        1),
                                child: ListView.builder(
                                  itemCount: historyRepTime[index]
                                              [AppString.exercise]
                                          .toString()
                                          .split(',')
                                          .length -
                                      1,
                                  itemBuilder: (context, indexExercise) {
                                    return Center(
                                      child: SizedBox(
                                        height: AppDimens.dimens_20,
                                        child: Text(historyRepTime[index]
                                                [AppString.exercise]
                                            .toString()
                                            .split(',')[indexExercise]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ])));
              },
            );
}

double getHeight(
  List<Map<String, Object?>> list,
) {
  double height = 0;
  for (int i = 0; i < list.length; i++) {
    height = height +
        AppDimens.dimens_60 +
        AppDimens.dimens_20 *
            (list[i][AppString.exercise].toString().split(',').length - 1);
  }
  return height;
}

String returnHiitMethod(String exercise, String? restTime) {
  if (exercise.contains(':')) {
    return 'group';
  } else if (restTime == null) {
    return 'sequentially';
  } else {
    return '';
  }
}
