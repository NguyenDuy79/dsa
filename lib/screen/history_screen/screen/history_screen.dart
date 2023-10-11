import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../common_bloc/bloc_history/history_bloc.dart';
import '../../../config/config.dart';
import '../bloc/filter_bloc/filter_bloc.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HistoryLoaded) {
          return Scaffold(
            backgroundColor: AppColor.colorGrey1,
            appBar: AppBar(
              backgroundColor: AppColor.colorGrey1,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.blackColor,
                  )),
              elevation: AppDimens.dimens_0,
              centerTitle: true,
              title: Text(
                'History',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
              ),
              actions: [
                SizedBox(
                  width: AppDimens.dimens_130,
                  child: PopupMenuButton(
                      onSelected: (value) {
                        context
                            .read<FilterBloc>()
                            .add(OnChangeFilter(value, state.dataHistory));
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(AppDimens.dimens_3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                context.select(
                                    (FilterBloc bloc) => bloc.state.name),
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_17,
                                    AppFont.medium,
                                    AppColor.blackColor),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down_sharp,
                              color: AppColor.blackColor,
                              size: AppDimens.dimens_25,
                            )
                          ],
                        ),
                      ),
                      itemBuilder: (context) => listPopUp()),
                )
              ],
            ),
            body: BlocBuilder<FilterBloc, FilterState>(
              builder: (context, stateFilter) {
                List<Map<String, Object?>> value = [];
                if (stateFilter is FilterDone) {
                  value = stateFilter.result.reversed.toList();
                } else {
                  value = state.dataHistory.reversed.toList();
                }

                final List<String> timeForMonth = getListTimeOfMoth(value);
                return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimens.dimens_20),
                    child: ListView.builder(
                        itemCount: timeForMonth.length,
                        itemBuilder: (context, index) {
                          List<Map<String, Object?>> newList = listOfMonth(
                              DateFormat('M-yyyy')
                                  .format(DateTime.parse(timeForMonth[index])),
                              value);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppDimens.dimens_10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('M-yyyy').format(
                                      DateTime.parse(timeForMonth[index])),
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.semiBold,
                                      AppColor.blackColor),
                                ),
                                SizedBox(
                                  height: newList.length * AppDimens.dimens_100,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: newList.length,
                                    itemBuilder: (context, indexItem) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            RouteGenerator.detailHistoryScreen,
                                            arguments: newList[indexItem],
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(
                                              AppDimens.dimens_5),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            'Time: ${DateTime.parse(newList[indexItem][AppString.dateTimeEnd] as String).difference(DateTime.parse(newList[indexItem][AppString.dateTime] as String)).inMinutes} min'),
                                                        Text(
                                                            'Exercise: ${newList[indexItem][AppString.exercise].toString().split(',').length - 1}'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(DateFormat('dd/M')
                                                            .format(DateTime.parse(
                                                                newList[indexItem]
                                                                        [
                                                                        AppString
                                                                            .dateTime]
                                                                    as String))),
                                                        const Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: AppColor
                                                              .blackColor,
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
                                )
                              ],
                            ),
                          );
                        }));
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

List<PopupMenuItem> listPopUp() {
  var newList = AppAnother.exerciseMethod
      .map((value) => PopupMenuItem(
            value: value,
            child: Text(value,
                style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                    AppFont.semiBold, AppColor.blackColor)),
          ))
      .toList()
      .reversed
      .toList();
  newList.add(PopupMenuItem(
    value: 'All item',
    child: Text('All item',
        style: AppAnother.textStyleDefault(
            AppDimens.dimens_18, AppFont.semiBold, AppColor.blackColor)),
  ));
  return newList.reversed.toList();
}

listOfMonth(String format, List<Map<String, Object?>> listState) {
  List<Map<String, Object?>> newList = [];
  for (int i = 0; i < listState.length; i++) {
    if (format ==
        DateFormat('M-yyyy').format(
            DateTime.parse(listState[i][AppString.dateTime] as String))) {
      newList.add(listState[i]);
    }
  }
  return newList;
}

List<String> getListTimeOfMoth(List<Map<String, Object?>> value) {
  List<String> timeForMonth = [];
  for (int i = 0; i < value.length; i++) {
    timeForMonth.add(value[i][AppString.dateTime] as String);

    for (int j = i + 1; j < value.length; j++) {
      if (DateFormat('M-yyyy')
              .format(DateTime.parse(value[i][AppString.dateTime] as String)) !=
          DateFormat('M-yyyy')
              .format(DateTime.parse(value[j][AppString.dateTime] as String))) {
        i = j;
        j = value.length;
      } else if (j == value.length - 1) {
        i = j + 1;
      }
    }
  }
  return timeForMonth;
}
