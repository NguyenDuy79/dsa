import 'package:fitness_app_bloc/reused/widget_reused.dart';
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
                  'Start: ${history[AppString.dateTime].toString().split(':')[0]}:${history[AppString.dateTime].toString().split(':')[1]}:${history[AppString.dateTime].toString().split(':')[2].split('.')[0]}',
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
                ),
                Text(
                  'End: ${history['DateTimeEnd'].toString().split(':')[0]}:${history['DateTimeEnd'].toString().split(':')[1]}:${history['DateTimeEnd'].toString().split(':')[2].split('.')[0]}',
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
                ),
                const SizedBox(
                  height: AppDimens.dimens_15,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: history[AppString.exercise]
                            .toString()
                            .split(',')
                            .length -
                        1,
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
                                getListRepAndTimeToday(
                                    historyRepTime, index, history);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  history[AppString.exercise]
                                      .toString()
                                      .split(',')[index],
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.medium,
                                      AppColor.blackColor),
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
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
