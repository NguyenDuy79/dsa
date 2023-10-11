import 'package:fitness_app_bloc/common_bloc/bloc_activity/activity_bloc.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_recipes/recipes_bloc.dart';
import 'package:fitness_app_bloc/reused/widget_reused.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../config/app_another.dart';
import '../../../config/app_color.dart';
import '../../../config/app_dimens.dart';
import '../../../config/app_font.dart';
import '../../../config/app_string.dart';
import '../../into_screen/home_page_bloc/home_page_bloc.dart';

class AddInformationScreen extends StatelessWidget {
  const AddInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'New Information',
          style: AppAnother.textStyleDefault(
              AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
        ),
        elevation: AppDimens.dimens_0,
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.blackColor,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(AppDimens.dimens_10),
            child: BlocBuilder<HomePageBloc, HomePageState>(
              buildWhen: (previous, current) =>
                  previous.isMetric != current.isMetric ||
                  previous.status != current.status,
              builder: (context, state) {
                return Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      WidgetReused.metric(context, width, false),
                      WidgetReused.metric(context, width, true)
                    ],
                  ),
                  const SizedBox(
                    height: AppDimens.dimens_15,
                  ),

                  /// Gender

                  // Height
                  Container(
                    height: AppDimens.dimens_50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_20),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: AppDimens.dimens_75,
                          child: Text(
                            AppString.height,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor),
                          ),
                        ),
                        const SizedBox(
                          width: AppDimens.dimens_20,
                        ),
                        if (context.read<HomePageBloc>().isMetric)
                          Expanded(
                              child:
                                  WidgetReused.textFieldWidget('cm', (value) {
                            context
                                .read<HomePageBloc>()
                                .add(OnChangeHeight(value.trim()));
                          }, null)),
                        if (!context.read<HomePageBloc>().isMetric)
                          BlocBuilder<HomePageBloc, HomePageState>(
                            buildWhen: (previous, current) =>
                                previous.feet != current.feet,
                            builder: (context, state) {
                              return SizedBox(
                                  width: width * 0.3,
                                  child: WidgetReused.dropDownButtonInchAndFeet(
                                      context, 'feet'));
                            },
                          ),
                        if (!context.read<HomePageBloc>().isMetric)
                          const SizedBox(
                            width: AppDimens.dimens_20,
                          ),
                        if (!context.read<HomePageBloc>().isMetric)
                          BlocBuilder<HomePageBloc, HomePageState>(
                            buildWhen: (previous, current) =>
                                previous.inch != current.inch,
                            builder: (context, state) {
                              return Expanded(
                                  child: WidgetReused.dropDownButtonInchAndFeet(
                                      context, 'inch'));
                            },
                          )
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<HomePageBloc, HomePageState>(
                        buildWhen: (previous, current) =>
                            previous.feet != current.feet,
                        builder: (context, state) {
                          return (context.read<HomePageBloc>().submited &&
                                  context.read<HomePageBloc>().feet == null &&
                                  !context.read<HomePageBloc>().isMetric)
                              ? Container(
                                  height: AppDimens.dimens_16,
                                  padding: const EdgeInsets.only(
                                      left: AppDimens.dimens_20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: AppDimens.dimens_95,
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
                                )
                              : const SizedBox();
                        },
                      ),
                      BlocBuilder<HomePageBloc, HomePageState>(
                        buildWhen: (previous, current) =>
                            previous.inch != current.inch ||
                            previous.feet != current.feet,
                        builder: (context, state) => (context
                                    .read<HomePageBloc>()
                                    .submited &&
                                context.read<HomePageBloc>().inch == null &&
                                !context.read<HomePageBloc>().isMetric)
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppDimens.dimens_20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (context.read<HomePageBloc>().submited &&
                                        context.read<HomePageBloc>().feet !=
                                            null &&
                                        !context.read<HomePageBloc>().isMetric)
                                      const SizedBox(
                                        width: AppDimens.dimens_95,
                                      ),
                                    if (context.read<HomePageBloc>().submited &&
                                        context.read<HomePageBloc>().feet !=
                                            null &&
                                        !context.read<HomePageBloc>().isMetric)
                                      SizedBox(
                                        width:
                                            width * 0.3 + AppDimens.dimens_45,
                                      ),
                                    if (context.read<HomePageBloc>().submited &&
                                        context.read<HomePageBloc>().feet ==
                                            null &&
                                        !context.read<HomePageBloc>().isMetric)
                                      const SizedBox(
                                        width: AppDimens.dimens_5,
                                      ),
                                    Container(
                                      padding: (context
                                                  .read<HomePageBloc>()
                                                  .submited &&
                                              context
                                                      .read<HomePageBloc>()
                                                      .feet ==
                                                  null &&
                                              !context
                                                  .read<HomePageBloc>()
                                                  .isMetric)
                                          ? const EdgeInsets.all(
                                              AppDimens.dimens_0)
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
                              )
                            : Container(),
                      ),
                    ],
                  ),

                  BlocBuilder<HomePageBloc, HomePageState>(
                    buildWhen: (previous, current) =>
                        previous.height != current.height,
                    builder: (context, state) {
                      return (context.read<HomePageBloc>().submited &&
                              context
                                  .read<HomePageBloc>()
                                  .heightError
                                  .isNotEmpty &&
                              context.read<HomePageBloc>().isMetric)
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: AppDimens.dimens_75,
                                ),
                                const SizedBox(
                                  width: AppDimens.dimens_60,
                                ),
                                Text(
                                  context.read<HomePageBloc>().heightError,
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_12,
                                      AppFont.medium,
                                      AppColor.redColor1),
                                )
                              ],
                            )
                          : Container();
                    },
                  ),

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
                        SizedBox(
                          width: AppDimens.dimens_75,
                          child: Text(
                            AppString.weight,
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.medium,
                                AppColor.blackColor),
                          ),
                        ),
                        const SizedBox(
                          width: AppDimens.dimens_20,
                        ),
                        Expanded(
                            child: WidgetReused.textFieldWidget(
                                context.read<HomePageBloc>().isMetric
                                    ? 'kg'
                                    : 'lbs', (value) {
                          context
                              .read<HomePageBloc>()
                              .add(OnChangeWeight(value.trim()));
                        }, null))
                      ],
                    ),
                  ),

                  BlocBuilder<HomePageBloc, HomePageState>(
                    buildWhen: (previous, current) =>
                        previous.weight != current.weight,
                    builder: (context, state) {
                      return (context
                                  .read<HomePageBloc>()
                                  .weightError
                                  .isNotEmpty &&
                              context.read<HomePageBloc>().submited)
                          ? SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: AppDimens.dimens_75,
                                  ),
                                  const SizedBox(
                                    width: AppDimens.dimens_60,
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
                            )
                          : Container();
                    },
                  ),

                  const SizedBox(
                    height: AppDimens.dimens_10,
                  ),
                  // Activity
                  ///
                  //////
                  ///////
                  BlocBuilder<HomePageBloc, HomePageState>(
                    buildWhen: (previous, current) =>
                        previous.activity != current.activity,
                    builder: (context, state) {
                      return Container(
                        height: AppDimens.dimens_50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimens.dimens_20),
                        child: Row(
                          children: [
                            SizedBox(
                              width: AppDimens.dimens_75,
                              child: Text(AppString.activity,
                                  style: AppAnother.textStyleDefault(
                                      AppDimens.dimens_20,
                                      AppFont.medium,
                                      AppColor.blackColor)),
                            ),
                            const SizedBox(
                              width: AppDimens.dimens_20,
                            ),
                            Expanded(
                                child: WidgetReused.dropDownMenuButtonActivity(
                                    context, 'choose activity'))
                          ],
                        ),
                      );
                    },
                  ),

                  BlocBuilder<HomePageBloc, HomePageState>(
                    buildWhen: (previous, current) =>
                        previous.activity != current.activity,
                    builder: (context, state) {
                      return (context.read<HomePageBloc>().activity == null &&
                              context.read<HomePageBloc>().submited)
                          ? SizedBox(
                              height: AppDimens.dimens_16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: AppDimens.dimens_75,
                                  ),
                                  const SizedBox(
                                    width: AppDimens.dimens_60,
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
                            )
                          : const SizedBox();
                    },
                  ),

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
                        SizedBox(
                          width: AppDimens.dimens_110,
                          child: Text('Body Fat %',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.medium,
                                  AppColor.blackColor)),
                        ),
                        const SizedBox(
                          width: AppDimens.dimens_20,
                        ),
                        Expanded(
                            child: WidgetReused.textFieldWidget('percent',
                                (value) {
                          context
                              .read<HomePageBloc>()
                              .add(OnChangeBodyFat(value.trim()));
                        }, null)),
                      ],
                    ),
                  ),

                  BlocBuilder<HomePageBloc, HomePageState>(
                    buildWhen: (previous, current) =>
                        previous.bodyFat != current.bodyFat,
                    builder: (context, state) {
                      return (context
                                  .read<HomePageBloc>()
                                  .bodyFatError
                                  .isNotEmpty &&
                              context.read<HomePageBloc>().submited)
                          ? SizedBox(
                              height: AppDimens.dimens_16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimens.dimens_20,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: AppDimens.dimens_110,
                                    ),
                                    const SizedBox(
                                      width: AppDimens.dimens_50,
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
                            )
                          : const SizedBox();
                    },
                  ),

                  const SizedBox(
                    height: AppDimens.dimens_10,
                  ),
                  Container(
                    height: AppDimens.dimens_50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.dimens_20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: AppDimens.dimens_75,
                          child: Text(AppString.target,
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.medium,
                                  AppColor.blackColor)),
                        ),
                        const SizedBox(
                          width: AppDimens.dimens_20,
                        ),
                        BlocBuilder<HomePageBloc, HomePageState>(
                          buildWhen: (previous, current) =>
                              previous.target != current.target,
                          builder: (context, state) {
                            return Expanded(
                                child: WidgetReused.dropDownMenuButtonActivity(
                                    context, 'choose target'));
                          },
                        )
                      ],
                    ),
                  ),

                  BlocBuilder<HomePageBloc, HomePageState>(
                    buildWhen: (previous, current) =>
                        previous.target != current.target,
                    builder: (context, state) {
                      return (context.read<HomePageBloc>().target == null &&
                              context.read<HomePageBloc>().submited)
                          ? SizedBox(
                              height: AppDimens.dimens_16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: AppDimens.dimens_75),
                                  const SizedBox(
                                    width: AppDimens.dimens_60,
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
                            )
                          : const SizedBox();
                    },
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
              context.read<HomePageBloc>().add(AddSubmit());
            },
            child: BlocConsumer<HomePageBloc, HomePageState>(
              listener: (context, state) {
                if (state.status.isSuccess) {
                  context.read<ActivityBloc>().add(UpdateDataInfo());
                  context.read<RecipesBloc>().add(UpdateData());
                  Navigator.of(context).pop();
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
