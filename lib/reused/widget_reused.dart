import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fitness_app_bloc/common_app/common_widget.dart';
import 'package:fitness_app_bloc/reused/method_reused.dart';
import 'package:fitness_app_bloc/screen/into_screen/home_page_bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/config.dart';

class WidgetReused {
  WidgetReused._();
  static Widget exercise(List<String> muscleGroup, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (muscleGroup.isNotEmpty)
          Text(
            '$name:',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_15, AppFont.medium, AppColor.blackColor),
          ),
        if (muscleGroup.isNotEmpty)
          SizedBox(
            height: muscleGroup.length * AppDimens.dimens_25,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: muscleGroup.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimens.dimens_2),
                    child: Text(muscleGroup[index]),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  static Widget progress(double precent, String value, Color color) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: AppDimens.dimens_35,
            width: AppDimens.dimens_35,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(180 / 360),
              child: CircularProgressIndicator(
                backgroundColor: color.withOpacity(0.2),
                color: color,
                value: precent,
                strokeWidth: AppDimens.dimens_5,
              ),
            ),
          ),
        ),
        SizedBox(
          height: AppDimens.dimens_35,
          width: AppDimens.dimens_35,
          child: Center(
            child: Text(
              value,
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_12, AppFont.medium, AppColor.blackColor),
            ),
          ),
        ),
      ],
    );
  }

  static Widget setItem(
      List<Map<String, Object?>> exerciseRepAndTime,
      int indexRepAndTime,
      Map<String, Object?> history,
      int index,
      TextEditingController controller,
      TextEditingController editingController,
      GlobalKey<FormState> key,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.dimens_3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Set: ${exerciseRepAndTime[indexRepAndTime]['SetNumber']}',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_18, AppFont.normal, AppColor.blackColor),
              ),
              const SizedBox(
                width: AppDimens.dimens_20,
              ),
              Text(
                  'Time: ${exerciseRepAndTime[indexRepAndTime][AppString.timeAtSet]}',
                  style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                      AppFont.normal, AppColor.blackColor)),
              const SizedBox(
                width: AppDimens.dimens_20,
              ),
              Text(
                  'Rest time: ${history[AppString.restTime].toString().split(',')[index]}',
                  style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                      AppFont.normal, AppColor.blackColor)),
              if (int.parse(exerciseRepAndTime[indexRepAndTime][AppString.rep]
                      .toString()) !=
                  0)
                const SizedBox(
                  width: AppDimens.dimens_20,
                ),
            ],
          ),
          if (int.parse(exerciseRepAndTime[indexRepAndTime][AppString.rep]
                      .toString()) ==
                  0 &&
              double.parse(exerciseRepAndTime[indexRepAndTime][AppString.weight]
                      .toString()) ==
                  0)
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.greenColor1),
                onPressed: () {
                  CommonWidget.showRepAndWeightDialog(
                      context,
                      controller,
                      editingController,
                      key,
                      exerciseRepAndTime[indexRepAndTime][AppString.id] as int,
                      MethodReused.validWeight,
                      '',
                      0,
                      0);
                },
                child: Text(
                  'Enter weight and rep',
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_20, AppFont.normal, AppColor.blackColor),
                )),
          if (int.parse(exerciseRepAndTime[indexRepAndTime][AppString.rep]
                      .toString()) !=
                  0 &&
              double.parse(exerciseRepAndTime[indexRepAndTime][AppString.weight]
                      .toString()) !=
                  0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Rep: ${exerciseRepAndTime[indexRepAndTime][AppString.rep]}',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                        AppFont.normal, AppColor.blackColor)),
                Text(
                    'Weight: ${exerciseRepAndTime[indexRepAndTime][AppString.weight]}',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                        AppFont.normal, AppColor.blackColor)),
              ],
            )
        ],
      ),
    );
  }

  static Widget setItemDropset(
    List<Map<String, Object?>> repAndTime,
    int indexRepAndTime,
    Map<String, Object?> history,
    int index,
    TextEditingController controller,
    TextEditingController editingController,
    GlobalKey<FormState> key,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.dimens_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Set ${repAndTime[indexRepAndTime][AppString.setNumber].toString().split(':')[0]}: ',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_18, AppFont.normal, AppColor.blackColor)),
          const SizedBox(
            height: AppDimens.dimens_10,
          ),
          SizedBox(
              height: MethodReused.getQauntity(repAndTime[indexRepAndTime]
                              [AppString.rep]
                          .toString()) *
                      AppDimens.dimens_70 +
                  (int.parse(repAndTime[indexRepAndTime][AppString.setNumber]
                              .toString()
                              .split(':')[1]) -
                          MethodReused.getQauntity(repAndTime[indexRepAndTime]
                                  [AppString.rep]
                              .toString())) *
                      AppDimens.dimens_80,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: int.parse(
                  repAndTime[indexRepAndTime][AppString.setNumber]
                      .toString()
                      .split(':')[1],
                ),
                itemBuilder: (BuildContext context, int indexSet) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDimens.dimens_5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${indexSet + 1} :',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_18,
                                  AppFont.semiBold,
                                  AppColor.blackColor),
                            ),
                            Text(
                                'Time: ${repAndTime[indexRepAndTime][AppString.timeAtSet].toString().split(':')[indexSet]}',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.normal,
                                    AppColor.blackColor)),
                            Text(
                                'Rest drop: ${history[AppString.restTime].toString().split(',')[index].split(':')[0]}',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.normal,
                                    AppColor.blackColor)),
                            Text(
                                'Rest time: ${history[AppString.restTime].toString().split(',')[index].split(':')[1]}',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_18,
                                    AppFont.normal,
                                    AppColor.blackColor)),
                          ],
                        ),
                        if (MethodReused.getBool(
                            repAndTime[indexRepAndTime][AppString.rep]
                                .toString(),
                            repAndTime[indexRepAndTime][AppString.weight]
                                .toString(),
                            indexSet))
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.greenColor1),
                              onPressed: () {
                                CommonWidget.showRepAndWeightDialog(
                                    context,
                                    controller,
                                    editingController,
                                    key,
                                    repAndTime[indexRepAndTime][AppString.id]
                                        as int,
                                    MethodReused.validWeight,
                                    'Dropset',
                                    int.parse(
                                      repAndTime[indexRepAndTime]
                                              [AppString.setNumber]
                                          .toString()
                                          .split(':')[1],
                                    ),
                                    indexSet);
                              },
                              child: Text(
                                'Enter weight and rep',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_20,
                                    AppFont.normal,
                                    AppColor.blackColor),
                              )),
                        if (!MethodReused.getBool(
                            repAndTime[indexRepAndTime][AppString.rep]
                                .toString(),
                            repAndTime[indexRepAndTime][AppString.weight]
                                .toString(),
                            indexSet))
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                  'Rep: ${repAndTime[indexRepAndTime][AppString.rep].toString().split(':')[indexSet]}',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.normal,
                                      AppColor.blackColor)),
                              Text(
                                  'Weight: ${repAndTime[indexRepAndTime][AppString.weight].toString().split(':')[indexSet]}',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.normal,
                                      AppColor.blackColor)),
                            ],
                          )
                      ],
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }

  static Widget setItemSuperset(
    List<Map<String, Object?>> exerciseRepAndTime,
    int indexRepAndTime,
    Map<String, Object?> history,
    int index,
    TextEditingController controller,
    TextEditingController editingController,
    GlobalKey<FormState> key,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.dimens_3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Set: ${exerciseRepAndTime[indexRepAndTime]['SetNumber']}',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_18, AppFont.normal, AppColor.blackColor),
              ),
              const SizedBox(
                width: AppDimens.dimens_20,
              ),
              Text(
                  'Time: ${exerciseRepAndTime[indexRepAndTime][AppString.timeAtSet]}',
                  style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                      AppFont.normal, AppColor.blackColor)),
              const SizedBox(
                width: AppDimens.dimens_20,
              ),
              Text(
                  'Rest time: ${history[AppString.restTime].toString().split(',')[index]}',
                  style: AppAnother.textStyleDefault(AppDimens.dimens_18,
                      AppFont.normal, AppColor.blackColor)),
            ],
          ),
          SizedBox(
            height: MethodReused.getQauntity(exerciseRepAndTime[indexRepAndTime]
                            [AppString.rep]
                        .toString()) *
                    AppDimens.dimens_90 +
                (history[AppString.exercise]
                            .toString()
                            .split(',')[index]
                            .split(':')[1]
                            .split(';')
                            .length -
                        1 -
                        MethodReused.getQauntity(
                            exerciseRepAndTime[indexRepAndTime][AppString.rep]
                                .toString())) *
                    AppDimens.dimens_80,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: history[AppString.exercise]
                      .toString()
                      .split(',')[index]
                      .split(':')[1]
                      .split(';')
                      .length -
                  1,
              itemBuilder: (context, indexSet) {
                return Column(
                  children: [
                    if (MethodReused.getBool(
                        exerciseRepAndTime[indexRepAndTime][AppString.rep]
                            .toString(),
                        exerciseRepAndTime[indexRepAndTime][AppString.weight]
                            .toString(),
                        indexSet))
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.greenColor1),
                          onPressed: () {
                            CommonWidget.showRepAndWeightDialog(
                                context,
                                controller,
                                editingController,
                                key,
                                exerciseRepAndTime[indexRepAndTime]
                                    [AppString.id] as int,
                                MethodReused.validWeight,
                                'Superset',
                                history[AppString.exercise]
                                        .toString()
                                        .split(',')[index]
                                        .split(':')[1]
                                        .split(';')
                                        .length -
                                    1,
                                indexSet);
                          },
                          child: Text(
                            'Enter weight and rep',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.normal,
                                AppColor.blackColor),
                          )),
                    if (!MethodReused.getBool(
                        exerciseRepAndTime[indexRepAndTime][AppString.rep]
                            .toString(),
                        exerciseRepAndTime[indexRepAndTime][AppString.weight]
                            .toString(),
                        indexSet))
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${history[AppString.exercise].toString().split(',')[index].split(':')[1].split(';')[indexSet]}:',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_18,
                                  AppFont.normal,
                                  AppColor.blackColor)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                  'Rep: ${exerciseRepAndTime[indexRepAndTime][AppString.rep].toString().split(':')[indexSet]}',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.normal,
                                      AppColor.blackColor)),
                              Text(
                                  'Weight: ${exerciseRepAndTime[indexRepAndTime][AppString.weight].toString().split(':')[indexSet]}',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_18,
                                      AppFont.normal,
                                      AppColor.blackColor)),
                            ],
                          ),
                        ],
                      )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget textFieldWidget(
      String hint, Function(String value) funtion, String? errorText) {
    return TextField(
        style: AppAnother.textStyleDefault(
            AppDimens.dimens_20, AppFont.normal, AppColor.blackColor),
        onChanged: (value) {
          funtion(value);
        },
        cursorColor: AppColor.blackColor,
        maxLines: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            errorText: errorText,
            hintText: hint,
            contentPadding: const EdgeInsets.only(left: AppDimens.dimens_20),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.colorGrey3),
                borderRadius:
                    BorderRadius.all(Radius.circular(AppDimens.dimens_10))),
            focusedBorder: const OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppDimens.dimens_10)),
                borderSide: BorderSide(color: AppColor.blackColor))));
  }

  static Widget textFormFieldWidget(String hint, Function(String value) funtion,
      Function(String value) errorText) {
    return TextFormField(
        style: AppAnother.textStyleDefault(
            AppDimens.dimens_20, AppFont.normal, AppColor.blackColor),
        onChanged: (value) {
          funtion(value);
        },
        validator: (value) {
         
          return errorText(value!);
        },
        cursorColor: AppColor.blackColor,
        maxLines: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.only(left: AppDimens.dimens_20),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.colorGrey3),
                borderRadius:
                    BorderRadius.all(Radius.circular(AppDimens.dimens_10))),
            focusedBorder: const OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppDimens.dimens_10)),
                borderSide: BorderSide(color: AppColor.blackColor))));
  }

  static Widget metric(BuildContext context, double width, bool isMetric) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<HomePageBloc>(context).add(UntiChange(isMetric));
      },
      child: Container(
        height: AppDimens.dimens_60,
        width: width / 2 - AppDimens.dimens_10,
        decoration: BoxDecoration(
          color: ((isMetric
                  ? context.read<HomePageBloc>().isMetric
                  : !context.read<HomePageBloc>().isMetric)
              ? AppColor.blackColor
              : AppColor.whiteColor),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(AppDimens.dimens_15),
              topLeft: Radius.circular(AppDimens.dimens_15)),
        ),
        child: Container(
          margin: (isMetric
                  ? context.read<HomePageBloc>().isMetric
                  : !context.read<HomePageBloc>().isMetric)
              ? const EdgeInsets.only(
                  top: AppDimens.dimens_1,
                  left: AppDimens.dimens_1,
                  right: AppDimens.dimens_1,
                )
              : const EdgeInsets.all(AppDimens.dimens_0),
          decoration: (isMetric
                  ? context.read<HomePageBloc>().isMetric
                  : !context.read<HomePageBloc>().isMetric)
              ? const BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppDimens.dimens_13),
                      topLeft: Radius.circular(AppDimens.dimens_13)),
                )
              : const BoxDecoration(
                  color: AppColor.whiteColor,
                  border: Border(
                      bottom: BorderSide(
                          color: AppColor.blackColor,
                          width: AppDimens.dimens_1))),
          child: Center(
            child: Text(
              isMetric ? 'Metric' : 'Imperial',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
            ),
          ),
        ),
      ),
    );
  }

  static Widget dropDownMenuButtonActivity(BuildContext context, String hint) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        isExpanded: true,
        hint: Text(
          hint,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: (hint == 'choose activity'
                ? AppAnother.listAcctivity
                : AppAnother.listTarget)
            .map((item) {
          return DropdownMenuItem<int>(
            value: item['Value'] - 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item[hint == 'choose activity'
                    ? AppString.activity
                    : AppString.target],
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
            ),
          );
        }).toList(),
        value: hint == 'choose activity'
            ? context.read<HomePageBloc>().activity
            : context.read<HomePageBloc>().target,
        onChanged: (value) {
          hint == 'choose activity'
              ? BlocProvider.of<HomePageBloc>(context)
                  .add(SetActivity(value: value!))
              : BlocProvider.of<HomePageBloc>(context).add(SetTarget(value!));
        },
        buttonStyleData: ButtonStyleData(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.dimens_10),
            height: AppDimens.dimens_60,
            width: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.dimens_10),
                border: Border.all(
                    color: AppColor.colorGrey3, width: AppDimens.dimens_1))),
        selectedItemBuilder: (context) {
          return hint == 'choose activity'
              ? AppAnother.listAcctivity.map((e) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          (e[AppString.activity] as String).split('(')[0],
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.blackColor)),
                    ),
                  );
                }).toList()
              : AppAnother.listTarget.map((e) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text((e[AppString.target] as String),
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.blackColor)),
                    ),
                  );
                }).toList();
        },
        dropdownStyleData: DropdownStyleData(
            maxHeight: AppDimens.dimens_150,
            padding: const EdgeInsets.only(
              left: AppDimens.dimens_10,
              bottom: AppDimens.dimens_3,
              top: AppDimens.dimens_3,
            ),
            scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(AppDimens.dimens_10),
                thickness: MaterialStateProperty.all(AppDimens.dimens_6),
                thumbColor: MaterialStateProperty.all(AppColor.colorGrey4),
                thumbVisibility: MaterialStateProperty.all(false))),
        menuItemStyleData: const MenuItemStyleData(
            height: AppDimens.dimens_60,
            padding: EdgeInsets.all(AppDimens.dimens_0)),
      ),
    );
  }

  static Widget dropDownButtonInchAndFeet(BuildContext context, String hint) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        isExpanded: true,
        hint: Text(
          hint,
          style: TextStyle(
            fontSize: AppDimens.dimens_20,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: (hint == 'feet' ? AppAnother.listFeet : AppAnother.listInch)
            .map((item) {
          return DropdownMenuItem<int>(
            value: hint == 'feet' ? item : item + 1,
            child: Text(
              '$item ${(hint == 'feet' ? 'feet' : 'inch')}',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
            ),
          );
        }).toList(),
        value: hint == 'feet'
            ? context.read<HomePageBloc>().feet
            : context.read<HomePageBloc>().inch,
        onChanged: (value) {
          hint == 'feet'
              ? BlocProvider.of<HomePageBloc>(context)
                  .add(SetFeet(value: value!))
              : BlocProvider.of<HomePageBloc>(context)
                  .add(SetInch(value: value!));
        },
        buttonStyleData: ButtonStyleData(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.dimens_10),
            height: AppDimens.dimens_50,
            width: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.dimens_10),
                border: Border.all(
                    color: AppColor.colorGrey3, width: AppDimens.dimens_1))),
        dropdownStyleData: DropdownStyleData(
            maxHeight: AppDimens.dimens_150,
            scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(AppDimens.dimens_10),
                thickness: MaterialStateProperty.all(AppDimens.dimens_6),
                thumbColor: MaterialStateProperty.all(AppColor.colorGrey4),
                thumbVisibility: MaterialStateProperty.all(false))),
        menuItemStyleData: const MenuItemStyleData(
          height: AppDimens.dimens_50,
        ),
      ),
    );
  }
}
