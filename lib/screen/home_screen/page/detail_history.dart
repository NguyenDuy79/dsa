import 'package:fitness_app_bloc/screen/into_screen/home_page_bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common_app/common_widget.dart';
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
                      context.read<HomePageBloc>().add(UntiChange(
                          isMetric: !context.read<HomePageBloc>().isMetric));
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
                            List<Map<String, Object?>> historyRepTime = [];
                            for (var item in listRepTime) {
                              if (history[AppString.dateTime] ==
                                  item[AppString.dateTime]) {
                                historyRepTime.add(item);
                              }
                            }

                            List<Map<String, Object?>> exerciseRepAndTime = [];
                            for (var item in historyRepTime) {
                              if (history[AppString.exercise]
                                      .toString()
                                      .split(',')[index] ==
                                  item[AppString.exercise].toString()) {
                                exerciseRepAndTime.add(item);
                              }
                            }
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
                                  height: exerciseRepAndTime.length *
                                      AppDimens.dimens_100,
                                  child: ListView.builder(
                                    itemCount: exerciseRepAndTime.length,
                                    itemBuilder: (context, indexRepAndTime) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: AppDimens.dimens_3),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Set ${exerciseRepAndTime[indexRepAndTime]['SetNumber']}:',
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_20,
                                                      AppFont.semiBold,
                                                      AppColor.blackColor),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    'Time: ${exerciseRepAndTime[indexRepAndTime][AppString.timeAtSet]}',
                                                    style: AppAnother
                                                        .textStyleDefault(
                                                            AppDimens.dimens_18,
                                                            AppFont.normal,
                                                            AppColor
                                                                .blackColor)),
                                                const SizedBox(
                                                  width: AppDimens.dimens_20,
                                                ),
                                                Text(
                                                    'Rest time: ${history[AppString.restTime].toString().split(',')[index]}',
                                                    style: AppAnother
                                                        .textStyleDefault(
                                                            AppDimens.dimens_18,
                                                            AppFont.normal,
                                                            AppColor
                                                                .blackColor)),
                                                if (int.parse(exerciseRepAndTime[
                                                                indexRepAndTime]
                                                            [AppString.rep]
                                                        .toString()) !=
                                                    0)
                                                  const SizedBox(
                                                    width: AppDimens.dimens_20,
                                                  ),
                                              ],
                                            ),
                                            if (int.parse(exerciseRepAndTime[
                                                                indexRepAndTime]
                                                            [AppString.rep]
                                                        .toString()) ==
                                                    0 &&
                                                double.parse(exerciseRepAndTime[
                                                                indexRepAndTime]
                                                            [AppString.weight]
                                                        .toString()) ==
                                                    0)
                                              Center(
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                AppColor
                                                                    .greenColor1),
                                                    onPressed: () {
                                                      CommonWidget
                                                          .showRepAndWeightDialog(
                                                        context,
                                                        controller,
                                                        editingController,
                                                        key,
                                                        exerciseRepAndTime[
                                                                indexRepAndTime]
                                                            [AppString
                                                                .id] as int,
                                                        AppAnother.validWeight,
                                                      );
                                                    },
                                                    child: Text(
                                                      'Submit',
                                                      style: AppAnother
                                                          .textStyleDefault(
                                                              AppDimens
                                                                  .dimens_20,
                                                              AppFont.normal,
                                                              AppColor
                                                                  .blackColor),
                                                    )),
                                              ),
                                            if (int.parse(exerciseRepAndTime[
                                                                indexRepAndTime]
                                                            [AppString.rep]
                                                        .toString()) !=
                                                    0 &&
                                                double.parse(exerciseRepAndTime[
                                                                indexRepAndTime]
                                                            [AppString.weight]
                                                        .toString()) !=
                                                    0)
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      'Rep: ${exerciseRepAndTime[indexRepAndTime][AppString.rep]}',
                                                      style: AppAnother
                                                          .textStyleDefault(
                                                              AppDimens
                                                                  .dimens_18,
                                                              AppFont.normal,
                                                              AppColor
                                                                  .blackColor)),
                                                  const SizedBox(
                                                    width: AppDimens.dimens_20,
                                                  ),
                                                  Text(
                                                      context
                                                              .read<
                                                                  HomePageBloc>()
                                                              .isMetric
                                                          ? result(
                                                              'Weight:  ${double.parse(exerciseRepAndTime[indexRepAndTime][AppString.weight] as String).toStringAsFixed(1)}')
                                                          : result(
                                                              'Weight: ${(double.parse(exerciseRepAndTime[indexRepAndTime][AppString.weight] as String) * (1 / 0.45359237)).toStringAsFixed(1)}'),
                                                      style: AppAnother
                                                          .textStyleDefault(
                                                              AppDimens
                                                                  .dimens_18,
                                                              AppFont.normal,
                                                              AppColor
                                                                  .blackColor)),
                                                ],
                                              )
                                          ],
                                        ),
                                      );
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
