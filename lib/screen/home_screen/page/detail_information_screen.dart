import 'package:flutter/material.dart';

import '../../../config/config.dart';

class DetailInformationScreen extends StatelessWidget {
  const DetailInformationScreen(this.detailInformation, {super.key});
  final Map<String, Object?> detailInformation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.whiteColor,
        elevation: AppDimens.dimens_0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.blackColor,
            )),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender: ${detailInformation[AppString.gender]}',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_25, AppFont.medium, AppColor.blackColor),
            ),
            const SizedBox(
              height: AppDimens.dimens_5,
            ),
            Text(
                'Age: ${DateTime.now().difference(DateTime.parse(detailInformation[AppString.age] as String)).inDays ~/ 365.25}',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_25, AppFont.medium, AppColor.blackColor)),
            const SizedBox(
              height: AppDimens.dimens_5,
            ),
            Text('Height: ${detailInformation[AppString.height].toString()}',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_25, AppFont.medium, AppColor.blackColor)),
            const SizedBox(
              height: AppDimens.dimens_5,
            ),
            Text('Weight: ${detailInformation[AppString.weight].toString()}',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_25, AppFont.medium, AppColor.blackColor)),
            const SizedBox(
              height: AppDimens.dimens_5,
            ),
            Text(
                'Activity: ${detailInformation[AppString.activity].toString().split('(')[0]}',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_25, AppFont.medium, AppColor.blackColor)),
            const SizedBox(
              height: AppDimens.dimens_5,
            ),
            Text(
                '(${detailInformation[AppString.activity].toString().split('(')[1]}',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_25, AppFont.medium, AppColor.blackColor)),
            const SizedBox(
              height: AppDimens.dimens_5,
            ),
            Text('Body fat: ${detailInformation[AppString.bodyFat].toString()}',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_25, AppFont.medium, AppColor.blackColor)),
            const SizedBox(
              height: AppDimens.dimens_5,
            ),
            Text('Target: ${detailInformation[AppString.target]}',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_25, AppFont.medium, AppColor.blackColor))
          ],
        ),
      ),
    );
  }
}
