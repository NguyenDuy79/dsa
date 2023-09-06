import 'package:fitness_app_bloc/config/app_another.dart';
import 'package:fitness_app_bloc/config/app_color.dart';
import 'package:fitness_app_bloc/config/app_dimens.dart';
import 'package:fitness_app_bloc/config/app_font.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../config/route_generator.dart';
import 'home_page_bloc/home_page_bloc.dart';

class EnterInfomation extends StatelessWidget {
  const EnterInfomation({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Information',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
        ),
        backgroundColor: AppColor.themeColor,
        elevation: AppDimens.dimens_0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(AppDimens.dimens_10),
            child: BlocConsumer<HomePageBloc, HomePageState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<HomePageBloc>(context)
                              .add(UntiChange(isMetric: false));
                        },
                        child: Container(
                          height: AppDimens.dimens_60,
                          width: width / 2 - AppDimens.dimens_10,
                          decoration: BoxDecoration(
                            color: (!context.read<HomePageBloc>().isMetric
                                ? AppColor.blackColor
                                : AppColor.whiteColor),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(AppDimens.dimens_15),
                                topLeft: Radius.circular(AppDimens.dimens_15)),
                          ),
                          child: Container(
                            margin: !context.read<HomePageBloc>().isMetric
                                ? const EdgeInsets.only(
                                    top: AppDimens.dimens_1,
                                    left: AppDimens.dimens_1,
                                    right: AppDimens.dimens_1,
                                  )
                                : const EdgeInsets.all(AppDimens.dimens_0),
                            decoration: !context.read<HomePageBloc>().isMetric
                                ? const BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            AppDimens.dimens_13),
                                        topLeft: Radius.circular(
                                            AppDimens.dimens_13)),
                                  )
                                : const BoxDecoration(
                                    color: AppColor.whiteColor,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColor.blackColor,
                                            width: AppDimens.dimens_1))),
                            child: Center(
                              child: Text(
                                'Imperial',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_20,
                                    AppFont.medium,
                                    AppColor.blackColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<HomePageBloc>(context)
                              .add(UntiChange(isMetric: true));
                        },
                        child: Container(
                          height: AppDimens.dimens_60,
                          width: width / 2 - AppDimens.dimens_10,
                          decoration: BoxDecoration(
                            color:
                                (context.read<HomePageBloc>().isMetric == true
                                    ? AppColor.blackColor
                                    : AppColor.whiteColor),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(AppDimens.dimens_15),
                                topLeft: Radius.circular(AppDimens.dimens_15)),
                          ),
                          child: Container(
                            margin: context.read<HomePageBloc>().isMetric
                                ? const EdgeInsets.only(
                                    top: AppDimens.dimens_1,
                                    left: AppDimens.dimens_1,
                                    right: AppDimens.dimens_1,
                                  )
                                : const EdgeInsets.all(AppDimens.dimens_0),
                            decoration: context.read<HomePageBloc>().isMetric
                                ? const BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            AppDimens.dimens_13),
                                        topLeft: Radius.circular(
                                            AppDimens.dimens_13)),
                                  )
                                : const BoxDecoration(
                                    color: AppColor.whiteColor,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColor.blackColor,
                                            width: AppDimens.dimens_1))),
                            child: Center(
                              child: Text(
                                'Metric',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_20,
                                    AppFont.medium,
                                    AppColor.blackColor),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: AppDimens.dimens_15,
                  ),

                  /// Gender
                  /// //
                  /// //
                  /// ////
                  /// ////
                  Container(
                    height: AppDimens.dimens_50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppString.gender,
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.blackColor),
                        ),
                        const SizedBox(
                          width: AppDimens.dimens_25,
                        ),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<int>(
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimens.dimens_20),
                                child: Text(
                                  AppString.gender,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                    value: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppDimens.dimens_20),
                                      child: Text(AppString.male,
                                          style: AppAnother.textStyleDefault(
                                              AppDimens.dimens_20,
                                              AppFont.medium,
                                              AppColor.blackColor)),
                                    )),
                                DropdownMenuItem(
                                    value: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppDimens.dimens_20),
                                      child: Text(AppString.female,
                                          style: AppAnother.textStyleDefault(
                                              AppDimens.dimens_20,
                                              AppFont.medium,
                                              AppColor.blackColor)),
                                    ))
                              ],
                              value: context.read<HomePageBloc>().gender,
                              onChanged: (value) {
                                BlocProvider.of<HomePageBloc>(context)
                                    .add(SetGender(value: value!));
                              },
                              buttonStyleData: ButtonStyleData(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppDimens.dimens_10),
                                  height: 50,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.dimens_10),
                                      border: Border.all(
                                          color: AppColor.colorGrey3,
                                          width: AppDimens.dimens_1))),
                              dropdownStyleData: DropdownStyleData(
                                  maxHeight: AppDimens.dimens_150,
                                  scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(
                                          AppDimens.dimens_10),
                                      thickness: MaterialStateProperty.all(
                                          AppDimens.dimens_6),
                                      thumbColor: MaterialStateProperty.all(
                                          AppColor.colorGrey4),
                                      thumbVisibility:
                                          MaterialStateProperty.all(false))),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 50,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (context.read<HomePageBloc>().gender == null &&
                      context.read<HomePageBloc>().submited)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.dimens_20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppString.gender,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.whiteColor),
                          ),
                          const SizedBox(
                            width: AppDimens.dimens_45,
                          ),
                          Text(
                            'Please enter gender',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_12,
                                AppFont.normal,
                                AppColor.redColor1),
                          )
                        ],
                      ),
                    ),
                  if ((!context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().gender == null) ||
                      (!context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().gender != null) ||
                      (context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().gender != null))
                    const SizedBox(
                      height: AppDimens.dimens_10,
                    ),
                  // Age
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.dimens_20),
                      child: Row(children: <Widget>[
                        Text(
                          AppString.age,
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.blackColor),
                        ),
                        const SizedBox(
                          width: AppDimens.dimens_20,
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now().subtract(
                                        Duration(
                                            days: (365.25 * 5).toInt() + 1)),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime.now().subtract(Duration(
                                        days: (365.25 * 5).toInt() + 1)))
                                .then((pickedDate) {
                              if (pickedDate == null) {
                                return;
                              }

                              context
                                  .read<HomePageBloc>()
                                  .add(OnChangeAge(pickedDate.toString()));
                            });
                          },
                          child: Container(
                            height: AppDimens.dimens_50,
                            padding: const EdgeInsets.only(
                                left: AppDimens.dimens_20),
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius:
                                  BorderRadius.circular(AppDimens.dimens_10),
                              border: Border.all(
                                  color: AppColor.colorGrey3,
                                  width: AppDimens.dimens_1),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              context.read<HomePageBloc>().age == null
                                  ? 'age'
                                  : DateFormat.yMMMMd().format(DateTime.parse(
                                      context.read<HomePageBloc>().age!)),
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.normal,
                                  context.read<HomePageBloc>().age == null
                                      ? AppColor.colorGrey4
                                      : AppColor.blackColor),
                            ),
                          ),
                        ))
                      ])),
                  if (context.read<HomePageBloc>().ageError.isNotEmpty &&
                      context.read<HomePageBloc>().submited)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppString.age,
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.medium,
                                  AppColor.whiteColor)),
                          const SizedBox(
                            width: AppDimens.dimens_40,
                          ),
                          Text(
                            context.read<HomePageBloc>().ageError,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_12,
                                AppFont.normal,
                                AppColor.redColor1),
                          ),
                        ],
                      ),
                    ),
                  if ((!context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().ageError.isNotEmpty) ||
                      (!context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().ageError.isEmpty) ||
                      (context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().ageError.isEmpty))
                    const SizedBox(
                      height: AppDimens.dimens_10,
                    ),
                  // Height
                  Container(
                    height: AppDimens.dimens_50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          AppString.height,
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.blackColor),
                        ),
                        const SizedBox(
                          width: AppDimens.dimens_20,
                        ),
                        if (context.read<HomePageBloc>().isMetric)
                          Expanded(
                              child: TextField(
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.normal,
                                      AppColor.blackColor),
                                  onChanged: (value) {
                                    context
                                        .read<HomePageBloc>()
                                        .add(OnChangeHeight(value.trim()));
                                  },
                                  cursorColor: AppColor.blackColor,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: 'cm',
                                      contentPadding: EdgeInsets.only(
                                          left: AppDimens.dimens_20),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.colorGrey3),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  AppDimens.dimens_10))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  AppDimens.dimens_10)),
                                          borderSide: BorderSide(
                                              color: AppColor.blackColor))))),
                        if (!context.read<HomePageBloc>().isMetric)
                          SizedBox(
                            width: width * 0.3,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<int>(
                                isExpanded: true,
                                hint: Text(
                                  'feet',
                                  style: TextStyle(
                                    fontSize: AppDimens.dimens_20,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: AppAnother.listFeet.map((item) {
                                  return DropdownMenuItem<int>(
                                    value: item,
                                    child: Text(
                                      '$item feet',
                                      style: AppAnother.textStyleDefault(
                                          AppDimens.dimens_20,
                                          AppFont.medium,
                                          AppColor.blackColor),
                                    ),
                                  );
                                }).toList(),
                                value: context.read<HomePageBloc>().feet,
                                onChanged: (value) {
                                  BlocProvider.of<HomePageBloc>(context)
                                      .add(SetFeet(value: value!));
                                },
                                buttonStyleData: ButtonStyleData(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppDimens.dimens_10),
                                    height: AppDimens.dimens_50,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppDimens.dimens_10),
                                        border: Border.all(
                                            color: AppColor.colorGrey3,
                                            width: AppDimens.dimens_1))),
                                dropdownStyleData: DropdownStyleData(
                                    maxHeight: AppDimens.dimens_150,
                                    scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(
                                            AppDimens.dimens_10),
                                        thickness: MaterialStateProperty.all(
                                            AppDimens.dimens_6),
                                        thumbColor: MaterialStateProperty.all(
                                            AppColor.colorGrey4),
                                        thumbVisibility:
                                            MaterialStateProperty.all(false))),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: AppDimens.dimens_50,
                                ),
                              ),
                            ),
                          ),
                        if (!context.read<HomePageBloc>().isMetric)
                          const SizedBox(
                            width: AppDimens.dimens_20,
                          ),
                        if (!context.read<HomePageBloc>().isMetric)
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<int>(
                                isExpanded: true,
                                hint: Text(
                                  'inch',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: AppAnother.listInch.map((item) {
                                  return DropdownMenuItem<int>(
                                    value: item,
                                    child: Text(
                                      '$item inch',
                                      style: AppAnother.textStyleDefault(
                                          AppDimens.dimens_20,
                                          AppFont.medium,
                                          AppColor.blackColor),
                                    ),
                                  );
                                }).toList(),
                                value: context.read<HomePageBloc>().inch,
                                onChanged: (value) {
                                  BlocProvider.of<HomePageBloc>(context)
                                      .add(SetInch(value: value!));
                                },
                                buttonStyleData: ButtonStyleData(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppDimens.dimens_10),
                                    height: 50,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppDimens.dimens_10),
                                        border: Border.all(
                                            color: AppColor.colorGrey3,
                                            width: AppDimens.dimens_1))),
                                dropdownStyleData: DropdownStyleData(
                                    maxHeight: AppDimens.dimens_150,
                                    scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(
                                            AppDimens.dimens_10),
                                        thickness: MaterialStateProperty.all(
                                            AppDimens.dimens_6),
                                        thumbColor: MaterialStateProperty.all(
                                            AppColor.colorGrey4),
                                        thumbVisibility:
                                            MaterialStateProperty.all(false))),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 50,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().feet == null &&
                          !context.read<HomePageBloc>().isMetric)
                        Container(
                          padding:
                              const EdgeInsets.only(left: AppDimens.dimens_20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.height,
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_20,
                                    AppFont.medium,
                                    AppColor.whiteColor),
                              ),
                              const SizedBox(
                                width: AppDimens.dimens_25,
                              ),
                              Container(
                                width: width * 0.3,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimens.dimens_10),
                                child: Text(
                                  'Enter feet',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_12,
                                      AppFont.medium,
                                      AppColor.redColor1),
                                ),
                              )
                            ],
                          ),
                        ),
                      if (context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().inch == null &&
                          !context.read<HomePageBloc>().isMetric)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimens.dimens_20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (context.read<HomePageBloc>().submited &&
                                  context.read<HomePageBloc>().feet != null &&
                                  !context.read<HomePageBloc>().isMetric)
                                Text(
                                  AppString.height,
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.medium,
                                      AppColor.whiteColor),
                                ),
                              if (context.read<HomePageBloc>().submited &&
                                  context.read<HomePageBloc>().feet != null &&
                                  !context.read<HomePageBloc>().isMetric)
                                SizedBox(
                                  width: width * 0.3 + AppDimens.dimens_45,
                                ),
                              if (context.read<HomePageBloc>().submited &&
                                  context.read<HomePageBloc>().feet == null &&
                                  !context.read<HomePageBloc>().isMetric)
                                const SizedBox(
                                  width: AppDimens.dimens_5,
                                ),
                              Container(
                                padding: (context
                                            .read<HomePageBloc>()
                                            .submited &&
                                        context.read<HomePageBloc>().feet ==
                                            null &&
                                        !context.read<HomePageBloc>().isMetric)
                                    ? const EdgeInsets.all(AppDimens.dimens_0)
                                    : const EdgeInsets.symmetric(
                                        horizontal: AppDimens.dimens_10),
                                child: Text(
                                  'Enter inch',
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_12,
                                      AppFont.medium,
                                      AppColor.redColor1),
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (context.read<HomePageBloc>().submited &&
                      context.read<HomePageBloc>().heightError.isNotEmpty &&
                      context.read<HomePageBloc>().isMetric)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimens.dimens_20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.height,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.whiteColor),
                          ),
                          const SizedBox(
                            width: AppDimens.dimens_40,
                          ),
                          Text(
                            context.read<HomePageBloc>().heightError,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_12,
                                AppFont.medium,
                                AppColor.redColor1),
                          )
                        ],
                      ),
                    ),
                  if ((!context.read<HomePageBloc>().submited &&
                          context
                              .read<HomePageBloc>()
                              .heightError
                              .isNotEmpty) ||
                      (!context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().heightError.isEmpty) ||
                      (context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().heightError.isEmpty &&
                          context.read<HomePageBloc>().isMetric))
                    const SizedBox(
                      height: AppDimens.dimens_10,
                    ),
                  if ((context.read<HomePageBloc>().feet == null &&
                          context.read<HomePageBloc>().inch == null &&
                          !context.read<HomePageBloc>().isMetric &&
                          !context.read<HomePageBloc>().submited) ||
                      (context.read<HomePageBloc>().feet != null &&
                          context.read<HomePageBloc>().inch != null &&
                          !context.read<HomePageBloc>().isMetric &&
                          !context.read<HomePageBloc>().submited) ||
                      (context.read<HomePageBloc>().feet != null &&
                          context.read<HomePageBloc>().inch != null &&
                          !context.read<HomePageBloc>().isMetric &&
                          context.read<HomePageBloc>().submited))
                    const SizedBox(
                      height: AppDimens.dimens_10,
                    ),

                  //Weight
                  Container(
                    height: AppDimens.dimens_50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          AppString.weight,
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.blackColor),
                        ),
                        const SizedBox(
                          width: AppDimens.dimens_20,
                        ),
                        Expanded(
                            child: TextField(
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_20,
                                    AppFont.normal,
                                    AppColor.blackColor),
                                cursorColor: AppColor.blackColor,
                                onChanged: (value) {
                                  context
                                      .read<HomePageBloc>()
                                      .add(OnChangeWeight(value.trim()));
                                },
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText:
                                        context.read<HomePageBloc>().isMetric
                                            ? 'kg'
                                            : 'lbs',
                                    contentPadding: const EdgeInsets.only(
                                        left: AppDimens.dimens_20),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.colorGrey3),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                AppDimens.dimens_10))),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                AppDimens.dimens_10)),
                                        borderSide:
                                            BorderSide(color: AppColor.blackColor)))))
                      ],
                    ),
                  ),
                  if (context.read<HomePageBloc>().weightError.isNotEmpty &&
                      context.read<HomePageBloc>().submited)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.weight,
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.medium,
                              AppColor.whiteColor),
                        ),
                        const SizedBox(
                          width: AppDimens.dimens_40,
                        ),
                        Text(
                          context.read<HomePageBloc>().weightError,
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_12,
                              AppFont.medium,
                              AppColor.redColor1),
                        )
                      ],
                    ),
                  if ((!context.read<HomePageBloc>().submited &&
                          context
                              .read<HomePageBloc>()
                              .weightError
                              .isNotEmpty) ||
                      (!context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().weightError.isEmpty) ||
                      (context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().weightError.isEmpty))
                    const SizedBox(
                      height: AppDimens.dimens_10,
                    ),
                  // Activity
                  ///
                  //////
                  ///////
                  Container(
                    height: AppDimens.dimens_50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_20),
                    child: Row(
                      children: [
                        Text(AppString.activity,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor)),
                        const SizedBox(
                          width: AppDimens.dimens_20,
                        ),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<int>(
                              isExpanded: true,
                              hint: Text(
                                'choose activity',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: AppAnother.listAcctivity.map((item) {
                                return DropdownMenuItem<int>(
                                  value: item['Value'] - 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item[AppString.activity],
                                      style: AppAnother.textStyleDefault(
                                          AppDimens.dimens_20,
                                          AppFont.medium,
                                          AppColor.blackColor),
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: context.read<HomePageBloc>().activity,
                              onChanged: (value) {
                                BlocProvider.of<HomePageBloc>(context)
                                    .add(SetActivity(value: value!));
                              },
                              buttonStyleData: ButtonStyleData(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppDimens.dimens_10),
                                  height: AppDimens.dimens_60,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.dimens_10),
                                      border: Border.all(
                                          color: AppColor.colorGrey3,
                                          width: AppDimens.dimens_1))),
                              selectedItemBuilder: (context) {
                                return AppAnother.listAcctivity.map((e) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          (e[AppString.activity] as String)
                                              .split('(')[0],
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
                                      radius: const Radius.circular(
                                          AppDimens.dimens_10),
                                      thickness: MaterialStateProperty.all(
                                          AppDimens.dimens_6),
                                      thumbColor: MaterialStateProperty.all(
                                          AppColor.colorGrey4),
                                      thumbVisibility:
                                          MaterialStateProperty.all(false))),
                              menuItemStyleData: const MenuItemStyleData(
                                  height: AppDimens.dimens_60,
                                  padding: EdgeInsets.all(AppDimens.dimens_0)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (context.read<HomePageBloc>().activity == null &&
                      context.read<HomePageBloc>().submited)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppString.activity,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.whiteColor)),
                        const SizedBox(
                          width: AppDimens.dimens_40,
                        ),
                        Text(
                          'Please enter activity',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_12,
                              AppFont.normal,
                              AppColor.redColor1),
                        ),
                      ],
                    ),
                  if ((!context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().activity == null) ||
                      (!context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().activity != null) ||
                      (context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().activity != null))
                    const SizedBox(
                      height: AppDimens.dimens_10,
                    ),

                  //BodyFat
                  Container(
                    height: AppDimens.dimens_50,
                    width: width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.dimens_20,
                    ),
                    child: Row(
                      children: [
                        Text('Body Fat %',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor)),
                        const SizedBox(
                          width: AppDimens.dimens_20,
                        ),
                        Expanded(
                          child: TextField(
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.normal,
                                  AppColor.blackColor),
                              keyboardType: TextInputType.number,
                              cursorColor: AppColor.blackColor,
                              onChanged: (value) {
                                context
                                    .read<HomePageBloc>()
                                    .add(OnChangeBodyFat(value.trim()));
                              },
                              decoration: const InputDecoration(
                                  hintText: 'percent',
                                  contentPadding: EdgeInsets.only(
                                      left: AppDimens.dimens_20),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColor.colorGrey3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              AppDimens.dimens_10))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(AppDimens.dimens_10)),
                                      borderSide: BorderSide(
                                          color: AppColor.blackColor)))),
                        ),
                      ],
                    ),
                  ),
                  if (context.read<HomePageBloc>().bodyFatError.isNotEmpty &&
                      context.read<HomePageBloc>().submited)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Body Fat %',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.medium,
                                  AppColor.whiteColor)),
                          const SizedBox(
                            width: AppDimens.dimens_40,
                          ),
                          Text(
                            context.read<HomePageBloc>().bodyFatError,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_12,
                                AppFont.normal,
                                AppColor.redColor1),
                          ),
                        ],
                      ),
                    ),
                  if ((!context.read<HomePageBloc>().submited &&
                          context
                              .read<HomePageBloc>()
                              .bodyFatError
                              .isNotEmpty) ||
                      (!context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().bodyFatError.isEmpty) ||
                      (context.read<HomePageBloc>().submited &&
                          context.read<HomePageBloc>().bodyFatError.isEmpty))
                    const SizedBox(
                      height: AppDimens.dimens_10,
                    ),
                  Container(
                    height: AppDimens.dimens_50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_20),
                    child: Row(
                      children: [
                        Text(AppString.target,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor)),
                        const SizedBox(
                          width: AppDimens.dimens_20,
                        ),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<int>(
                              isExpanded: true,
                              hint: Text(
                                'choose target',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: AppAnother.listTarget.map((item) {
                                return DropdownMenuItem<int>(
                                  value: item['Value'] - 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item[AppString.target],
                                      style: AppAnother.textStyleDefault(
                                          AppDimens.dimens_20,
                                          AppFont.medium,
                                          AppColor.blackColor),
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: context.read<HomePageBloc>().target,
                              onChanged: (value) {
                                BlocProvider.of<HomePageBloc>(context)
                                    .add(SetTarget(value!));
                              },
                              buttonStyleData: ButtonStyleData(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppDimens.dimens_10),
                                  height: AppDimens.dimens_60,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.dimens_10),
                                      border: Border.all(
                                          color: AppColor.colorGrey3,
                                          width: AppDimens.dimens_1))),
                              dropdownStyleData: DropdownStyleData(
                                  maxHeight: AppDimens.dimens_150,
                                  padding: const EdgeInsets.only(
                                    left: AppDimens.dimens_10,
                                    bottom: AppDimens.dimens_3,
                                    top: AppDimens.dimens_3,
                                  ),
                                  scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(
                                          AppDimens.dimens_10),
                                      thickness: MaterialStateProperty.all(
                                          AppDimens.dimens_6),
                                      thumbColor: MaterialStateProperty.all(
                                          AppColor.colorGrey4),
                                      thumbVisibility:
                                          MaterialStateProperty.all(false))),
                              menuItemStyleData: const MenuItemStyleData(
                                  height: AppDimens.dimens_60,
                                  padding: EdgeInsets.all(AppDimens.dimens_0)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (context.read<HomePageBloc>().target == null &&
                      context.read<HomePageBloc>().submited)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppString.activity,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.whiteColor)),
                        const SizedBox(
                          width: AppDimens.dimens_40,
                        ),
                        Text(
                          'Please enter activity',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_12,
                              AppFont.normal,
                              AppColor.redColor1),
                        ),
                      ],
                    ),
                ]);
              },
            )),
      ),
      bottomNavigationBar: Container(
        height: AppDimens.dimens_60,
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_5),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.greenColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.dimens_15)),
            ),
            onPressed: () {
              context.read<HomePageBloc>().add(Submit());
            },
            child: BlocConsumer<HomePageBloc, HomePageState>(
              listener: (context, state) {
                if (state.status.isSuccess) {
                  Navigator.of(context).pushReplacementNamed(
                    RouteGenerator.homePage,
                  );
                }
              },
              builder: (context, state) => state.status.isInProgress
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      'Submit',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                          AppFont.semiBold, AppColor.whiteColor),
                    ),
            )),
      ),
    );
  }
}
