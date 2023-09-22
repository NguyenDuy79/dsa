import 'package:fitness_app_bloc/common_bloc/bloc_history/history_bloc.dart';
import 'package:fitness_app_bloc/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryTodayScreen extends StatelessWidget {
  const HistoryTodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.now();
    return BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
      if (state is HistoryLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is HistoryLoaded) {
        List<Map<String, Object?>> listToday =
            getList(state.dataHistory, dateTime);

        return Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: AppBar(
            elevation: AppDimens.dimens_0,
            backgroundColor: AppColor.whiteColor,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.blackColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Today',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
            ),
            centerTitle: true,
          ),
          body: listToday.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.dimens_20,
                      vertical: AppDimens.dimens_20),
                  child: Image.asset(AppPath.empty),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.dimens_20,
                      vertical: AppDimens.dimens_20),
                  child: ListView.builder(
                    itemCount: listToday.length,
                    itemBuilder: (context, indexItem) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RouteGenerator.detailHistoryScreen,
                            arguments: listToday[indexItem],
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(AppDimens.dimens_5),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.notes_rounded,
                                color: AppColor.blackColor,
                              ),
                              const SizedBox(
                                width: AppDimens.dimens_20,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Time: ${DateTime.parse(listToday[indexItem][AppString.dateTimeEnd] as String).difference(DateTime.parse(listToday[indexItem][AppString.dateTime] as String)).inMinutes} min'),
                                        Text(
                                            'Exercise: ${listToday[indexItem][AppString.exercise].toString().split(',').length - 1}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(DateFormat('dd/M').format(
                                            DateTime.parse(listToday[indexItem]
                                                    [AppString.dateTime]
                                                as String))),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: AppColor.blackColor,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      } else {
        return Container();
      }
    });
  }
}

List<Map<String, Object?>> getList(
    List<Map<String, Object?>> dataHistory, DateTime dateTime) {
  List<Map<String, Object?>> listToday = [];
  for (int i = 0; i < dataHistory.length; i++) {
    if (DateFormat('dd/M/yyyy').format(
            DateTime.parse(dataHistory[i][AppString.dateTime] as String)) ==
        DateFormat('dd/M/yyyy').format(dateTime)) {
      listToday.add(dataHistory[i]);
    }
  }
  return listToday.reversed.toList();
}
