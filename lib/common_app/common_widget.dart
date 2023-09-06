import 'package:fitness_app_bloc/config/app_another.dart';
import 'package:fitness_app_bloc/config/app_color.dart';
import 'package:fitness_app_bloc/config/app_dimens.dart';
import 'package:fitness_app_bloc/config/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_bloc/bloc_history/history_bloc.dart';

import '../respository/db_history_repository.dart';
import '../screen/into_screen/home_page_bloc/home_page_bloc.dart';

class CommonWidget {
  CommonWidget._();
  static showBackAtionDialong(BuildContext context, bool dialog) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'In training',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_20, AppFont.semiBold, AppColor.blackColor),
        ),
        content: Text(
          'Do you sure want to exit',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_28, AppFont.normal, AppColor.blackColor),
        ),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.colorGrey4),
              onPressed: () {
                dialog = false;
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                'Yes',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.themeColor),
              )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.greenColor),
              onPressed: () {
                dialog = false;
                Navigator.of(context).pop();
              },
              child: Text(
                'No',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              )),
        ],
      ),
    );
  }

  static Future<bool> showBacWillPopkAtionDialong(
      BuildContext context, bool dialog) async {
    bool value = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'In training',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_20, AppFont.semiBold, AppColor.blackColor),
        ),
        content: Text(
          'Do you sure want to exit',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_28, AppFont.normal, AppColor.blackColor),
        ),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.colorGrey4),
              onPressed: () {
                Navigator.of(context).pop();
                dialog = false;
                value = true;
              },
              child: Text(
                'Yes',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.themeColor),
              )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.greenColor),
              onPressed: () {
                Navigator.of(context).pop();
                value = false;
                dialog = false;
              },
              child: Text(
                'No',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              )),
        ],
      ),
    );
    if (value == true) {
      return true;
    } else {
      return false;
    }
  }

  static showRepAndWeightDialog(
      BuildContext context,
      TextEditingController controller,
      TextEditingController editingController,
      GlobalKey<FormState> key,
      int id,
      Function validWeight) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => HomePageBloc(),
        child: AlertDialog(
          title: Text(
            'Enter rep and weight',
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_20, AppFont.semiBold, AppColor.blackColor),
          ),
          content: Form(
            key: key,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        'Rep',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                            AppFont.medium, AppColor.blackColor),
                      ),
                      const SizedBox(
                        width: AppDimens.dimens_20,
                      ),
                      Expanded(
                        child: TextFormField(
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.normal,
                                AppColor.blackColor),
                            onChanged: (value) {},
                            controller: controller,
                            validator: (value) => value!.isEmpty
                                ? 'Please enter value'
                                : (value.contains('.') ||
                                        value.contains('-') ||
                                        value.contains(' ') ||
                                        value.contains(','))
                                    ? 'Please enter the number '
                                    : int.parse(value) == 0
                                        ? 'Please enter the rep'
                                        : null,
                            cursorColor: AppColor.blackColor,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(AppDimens.dimens_10)),
                                    borderSide:
                                        BorderSide(color: AppColor.colorGrey3)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: AppDimens.dimens_20),
                                filled: true,
                                hintText: 'Rep',
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.colorGrey3),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(AppDimens.dimens_10))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(AppDimens.dimens_10)),
                                    borderSide: BorderSide(
                                        color: AppColor.blackColor)))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppDimens.dimens_10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        'Weight',
                        style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                            AppFont.medium, AppColor.blackColor),
                      ),
                      const SizedBox(
                        width: AppDimens.dimens_20,
                      ),
                      Expanded(
                        child: BlocConsumer<HomePageBloc, HomePageState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return TextFormField(
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_20,
                                    AppFont.normal,
                                    AppColor.blackColor),
                                onChanged: (value) {},
                                controller: editingController,
                                validator: (value) => validWeight(value!),
                                cursorColor: AppColor.blackColor,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    suffixIconColor: AppColor.blackColor,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          context.read<HomePageBloc>().add(
                                              UntiChange(
                                                  isMetric: !context
                                                      .read<HomePageBloc>()
                                                      .isMetric));
                                        },
                                        padding: const EdgeInsets.all(0),
                                        icon: const Icon(
                                          Icons.refresh_sharp,
                                        )),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(
                                            AppDimens.dimens_10)),
                                        borderSide: BorderSide(
                                            color: AppColor.colorGrey3)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: AppDimens.dimens_20),
                                    filled: true,
                                    hintText: context.read<HomePageBloc>().isMetric
                                        ? 'Kg'
                                        : 'Lbs',
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColor.colorGrey3),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                AppDimens.dimens_10))),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(AppDimens.dimens_10)),
                                        borderSide: BorderSide(color: AppColor.blackColor))));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppDimens.dimens_10,
                ),
                Center(child: BlocBuilder<HomePageBloc, HomePageState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.greenColor1),
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            String weight = '';

                            // ignore: use_build_context_synchronously
                            if (BlocProvider.of<HomePageBloc>(context)
                                .isMetric) {
                              weight = editingController.text;
                            } else {
                              weight = (double.parse(editingController.text) *
                                      0.45359237)
                                  .toString();
                            }
                            await DbHistoryRepository()
                                .updateSetAndTime(controller.text, weight, id);
                            // ignore: use_build_context_synchronously
                            context.read<HistoryBloc>().add(UpdateData());
                            controller.clear();
                            editingController.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          'Submit',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_20,
                              AppFont.normal,
                              AppColor.blackColor),
                        ));
                  },
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
