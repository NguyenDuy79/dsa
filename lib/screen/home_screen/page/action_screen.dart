import 'package:fitness_app_bloc/common_app/common_widget.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_history/history_bloc.dart';
import 'package:fitness_app_bloc/config/app_another.dart';
import 'package:fitness_app_bloc/config/app_color.dart';
import 'package:fitness_app_bloc/config/app_dimens.dart';
import 'package:fitness_app_bloc/config/app_font.dart';
import 'package:fitness_app_bloc/config/app_path.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/db/database.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../respository/db_history_repository.dart';
import '../../into_screen/home_page_bloc/home_page_bloc.dart';
import 'bloc/timer_bloc/timer_bloc.dart';
import 'bloc/visibility_bloc/visibility_bloc.dart';

class ActionScreen extends StatefulWidget {
  const ActionScreen(
      this.method, this.exercise, this.muscleGroup, this.restTime, this.set,
      {super.key});
  final String method;
  final String set;
  final String restTime;
  final String exercise;
  final String muscleGroup;

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  late String dateTimeFirst;

  final _key = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _editingController = TextEditingController();

  FlutterTts flutterTts = FlutterTts();
  late HistoryBloc historyBloc;
  void initSetting() async {
    await flutterTts.setLanguage("en-Us");
  }

  @override
  void initState() {
    initSetting();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    historyBloc = BlocProvider.of<HistoryBloc>(context);
    bool dialog = false;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    return BlocConsumer<VisibilityBloc, VisibilityState>(
      listener: (context, state) {
        if (state is PracticeState) {
          flutterTts.speak('Hello i want to fuck beautiful girls');
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (state is VisibilityInitial) {
              return true;
            }
            if (state is DoneState) {
              return false;
            } else {
              dialog = true;
              return await CommonWidget.showBacWillPopkAtionDialong(
                  context, dialog);
            }
          },
          child: Scaffold(
            backgroundColor: AppColor.themeColor,
            appBar: AppBar(
              elevation: AppDimens.dimens_0,
              automaticallyImplyLeading: false,
              backgroundColor: AppColor.whiteColor,
              leading: state is DoneState
                  ? null
                  : IconButton(
                      onPressed: () {
                        if (state is VisibilityInitial) {
                          Navigator.of(context).pop();
                        } else {
                          dialog = true;
                          CommonWidget.showBackAtionDialong(context, dialog);
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.blackColor,
                      )),
              title: Text(
                'Action',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_25, AppFont.semiBold, AppColor.blackColor),
              ),
              centerTitle: true,
              actions: [
                state is DoneState
                    ? BlocConsumer<HomePageBloc, HomePageState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return SizedBox(
                            width: width * 0.3,
                            child: GestureDetector(
                                onTap: () {
                                  context.read<HomePageBloc>().add(UntiChange(
                                      isMetric: !context
                                          .read<HomePageBloc>()
                                          .isMetric));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(AppDimens.dimens_5),
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
                          );
                        },
                      )
                    : Container()
              ],
            ),
            body: SingleChildScrollView(
                child: state is VisibilityInitial
                    ? SizedBox(
                        height: height,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'First exercise: ${widget.exercise.split(',')[0]}',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_20,
                                    AppFont.medium,
                                    AppColor.blackColor),
                              ),
                              const SizedBox(
                                height: AppDimens.dimens_20,
                              ),
                              Text(
                                'Press to start',
                                style: AppAnother.textStyleDefault(
                                    AppDimens.dimens_25,
                                    AppFont.semiBold,
                                    AppColor.blackColor),
                              ),
                              const SizedBox(
                                height: AppDimens.dimens_20,
                              ),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      backgroundColor: AppColor.greenColor1),
                                  onPressed: () {
                                    dateTimeFirst = DateTime.now().toString();
                                    context
                                        .read<VisibilityBloc>()
                                        .add(RestTimeEvent());
                                    context.read<TimerBloc>().add(
                                        const TimerStartedRestTime(
                                            duration: 1, timeBegin: 1));
                                  },
                                  child: SizedBox(
                                      height: AppDimens.dimens_100,
                                      width: AppDimens.dimens_100,
                                      child: CircleAvatar(
                                        child: ClipOval(
                                          child: Image.asset(
                                              AppPath.practiceImage,
                                              fit: BoxFit.cover),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )

                    ///
                    /// ///
                    /// //
                    /// //
                    : state is RestTimeState
                        ? Container(
                            padding: const EdgeInsets.only(
                                bottom: AppDimens.dimens_10),
                            height: height,
                            child: BlocBuilder<TimerBloc, TimerState>(
                              builder: (context, stateTimer) {
                                handlerRestTime(
                                    stateTimer,
                                    widget.restTime,
                                    widget.exercise,
                                    state,
                                    widget.set,
                                    flutterTts,
                                    context);

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppDimens.dimens_20,
                                      vertical: AppDimens.dimens_10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (state.set > 0)
                                          Form(
                                              key: _key,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      'Enter the number of reps and weight you just trained:',
                                                      style: AppAnother
                                                          .textStyleDefault(
                                                              AppDimens
                                                                  .dimens_20,
                                                              AppFont.medium,
                                                              AppColor
                                                                  .blackColor),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Rep',
                                                          style: AppAnother
                                                              .textStyleDefault(
                                                                  AppDimens
                                                                      .dimens_20,
                                                                  AppFont
                                                                      .medium,
                                                                  AppColor
                                                                      .blackColor),
                                                        ),
                                                        const SizedBox(
                                                          width: AppDimens
                                                              .dimens_20,
                                                        ),
                                                        Expanded(
                                                          child: TextFormField(
                                                              style: AppAnother
                                                                  .textStyleDefault(
                                                                      AppDimens
                                                                          .dimens_20,
                                                                      AppFont
                                                                          .normal,
                                                                      AppColor
                                                                          .blackColor),
                                                              onChanged:
                                                                  (value) {},
                                                              controller:
                                                                  _controller,
                                                              validator: (value) => value!
                                                                      .isEmpty
                                                                  ? 'Please enter value'
                                                                  : (value.contains('.') ||
                                                                          value.contains(
                                                                              '-') ||
                                                                          value.contains(
                                                                              ' ') ||
                                                                          value.contains(
                                                                              ','))
                                                                      ? 'Please enter the number '
                                                                      : int.parse(value) ==
                                                                              0
                                                                          ? 'Please enter the rep'
                                                                          : null,
                                                              cursorColor:
                                                                  AppColor
                                                                      .blackColor,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration: const InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(AppDimens.dimens_10)),
                                                                      borderSide: BorderSide(color: AppColor.colorGrey3)),
                                                                  contentPadding: EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
                                                                  filled: true,
                                                                  hintText: 'Rep',
                                                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.colorGrey3), borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_10))),
                                                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_10)), borderSide: BorderSide(color: AppColor.blackColor)))),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: AppDimens.dimens_10,
                                                  ),
                                                  BlocConsumer<HomePageBloc,
                                                      HomePageState>(
                                                    listener:
                                                        (context, state) {},
                                                    builder: (context, state) {
                                                      return SizedBox(
                                                        width: double.infinity,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Weight',
                                                              style: AppAnother
                                                                  .textStyleDefault(
                                                                      AppDimens
                                                                          .dimens_20,
                                                                      AppFont
                                                                          .medium,
                                                                      AppColor
                                                                          .blackColor),
                                                            ),
                                                            const SizedBox(
                                                              width: AppDimens
                                                                  .dimens_20,
                                                            ),
                                                            Expanded(
                                                              child: TextFormField(
                                                                  style: AppAnother.textStyleDefault(AppDimens.dimens_20, AppFont.normal, AppColor.blackColor),
                                                                  onChanged: (value) {},
                                                                  controller: _editingController,
                                                                  validator: (value) => AppAnother.validWeight(value!),
                                                                  cursorColor: AppColor.blackColor,
                                                                  keyboardType: TextInputType.number,
                                                                  decoration: InputDecoration(
                                                                      suffixIconColor: AppColor.blackColor,
                                                                      suffixIcon: IconButton(
                                                                          onPressed: () {
                                                                            context.read<HomePageBloc>().add(UntiChange(isMetric: !context.read<HomePageBloc>().isMetric));
                                                                          },
                                                                          padding: const EdgeInsets.all(0),
                                                                          icon: const Icon(
                                                                            Icons.refresh_sharp,
                                                                          )),
                                                                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_10)), borderSide: BorderSide(color: AppColor.colorGrey3)),
                                                                      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
                                                                      filled: true,
                                                                      hintText: context.read<HomePageBloc>().isMetric ? 'Kg' : 'Lbs',
                                                                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.colorGrey3), borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_10))),
                                                                      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_10)), borderSide: BorderSide(color: AppColor.blackColor)))),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: AppDimens.dimens_10,
                                                  ),
                                                  Center(
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    AppColor
                                                                        .greenColor1),
                                                        onPressed: () async {
                                                          if (_key.currentState!
                                                              .validate()) {
                                                            List<
                                                                    Map<String,
                                                                        Object?>>
                                                                listRepAndTime =
                                                                await DbHelper()
                                                                    .getData(
                                                                        AppString
                                                                            .repTimeTable);

                                                            String weight = '';
                                                            // ignore: use_build_context_synchronously
                                                            if (context
                                                                .read<
                                                                    HomePageBloc>()
                                                                .isMetric) {
                                                              weight =
                                                                  _editingController
                                                                      .text;
                                                            } else {
                                                              weight = (double.parse(
                                                                          _editingController
                                                                              .text) *
                                                                      0.45359237)
                                                                  .toString();
                                                            }
                                                            await DbHistoryRepository()
                                                                .updateSetAndTime(
                                                                    _controller
                                                                        .text,
                                                                    weight,
                                                                    listRepAndTime
                                                                            .last[
                                                                        AppString
                                                                            .id] as int);
                                                            historyBloc.add(
                                                                UpdateData());
                                                            _controller.clear();
                                                            _editingController
                                                                .clear();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          }
                                                        },
                                                        child: Text(
                                                          'Submit',
                                                          style: AppAnother
                                                              .textStyleDefault(
                                                                  AppDimens
                                                                      .dimens_20,
                                                                  AppFont
                                                                      .normal,
                                                                  AppColor
                                                                      .blackColor),
                                                        )),
                                                  )
                                                ],
                                              )),
                                        const SizedBox(
                                          height: AppDimens.dimens_10,
                                        ),
                                        Stack(
                                          children: <Widget>[
                                            Center(
                                              child: SizedBox(
                                                height: width * 0.6,
                                                width: width * 0.6,
                                                child: RotationTransition(
                                                  turns:
                                                      const AlwaysStoppedAnimation(
                                                          180 / 360),
                                                  child:
                                                      CircularProgressIndicator(
                                                    backgroundColor: AppColor
                                                        .purple1
                                                        .withOpacity(0.2),
                                                    color: AppColor.purple1,
                                                    value: stateTimer.duration /
                                                        stateTimer.timeBegin,
                                                    strokeWidth:
                                                        AppDimens.dimens_10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: SizedBox(
                                                height: width * 0.6,
                                                width: width * 0.6,
                                                child: Center(
                                                  child: Text(
                                                    formatTime(context.select(
                                                        (TimerBloc bloc) => bloc
                                                            .state.duration)),
                                                    style: AppAnother
                                                        .textStyleDefault(
                                                            AppDimens.dimens_32,
                                                            AppFont.medium,
                                                            AppColor.purple1),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (state.set > 0)
                                          const SizedBox(
                                            height: AppDimens.dimens_10,
                                          ),
                                        if (state.set > 0)
                                          Text(
                                              'Rest time : ${state.set}/${int.parse(widget.set.split(',')[state.exercise])}',
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_25,
                                                      AppFont.medium,
                                                      AppColor.blackColor)),
                                        if (int.parse(widget.set.split(
                                                    ',')[state.exercise]) ==
                                                state.set &&
                                            state.exercise <
                                                widget.exercise
                                                        .split(',')
                                                        .length -
                                                    2)
                                          const SizedBox(
                                            height: AppDimens.dimens_10,
                                          ),
                                        if (int.parse(widget.set.split(
                                                    ',')[state.exercise]) ==
                                                state.set &&
                                            state.exercise <
                                                widget.exercise
                                                        .split(',')
                                                        .length -
                                                    2)
                                          Text(
                                            'Next ${widget.exercise.split(',')[state.exercise + 1]}',
                                            style: AppAnother.textStyleDefault(
                                                AppDimens.dimens_25,
                                                AppFont.medium,
                                                AppColor.blackColor),
                                          ),
                                        if (int.parse(widget.set.split(
                                                    ',')[state.exercise]) ==
                                                state.set &&
                                            state.exercise ==
                                                widget.exercise
                                                        .split(',')
                                                        .length -
                                                    2)
                                          const SizedBox(
                                            height: AppDimens.dimens_10,
                                          ),
                                        if (int.parse(widget.set.split(
                                                    ',')[state.exercise]) ==
                                                state.set &&
                                            state.exercise ==
                                                widget.exercise
                                                        .split(',')
                                                        .length -
                                                    2)
                                          Text(
                                            'Next stretching after exercise',
                                            style: AppAnother.textStyleDefault(
                                                AppDimens.dimens_25,
                                                AppFont.medium,
                                                AppColor.blackColor),
                                          ),
                                      ]),
                                );
                              },
                            ),
                          )
                        : state is PracticeState
                            ? BlocConsumer<TimerBloc, TimerState>(
                                listener: (context, state) {},
                                builder: (context, stateTimer) {
                                  return Container(
                                      height: height,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(
                                          AppDimens.dimens_15),
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              String dateTime =
                                                  DateTime.now().toString();

                                              handlerPractice(
                                                  context,
                                                  widget.exercise,
                                                  widget.restTime,
                                                  widget.set,
                                                  dateTimeFirst,
                                                  dateTime,
                                                  stateTimer.duration,
                                                  flutterTts,
                                                  historyBloc,
                                                  state,
                                                  widget.method);
                                            },
                                            child: Stack(
                                              children: <Widget>[
                                                Center(
                                                  child: SizedBox(
                                                    height: width * 0.6,
                                                    width: width * 0.6,
                                                    child: RotationTransition(
                                                      turns:
                                                          const AlwaysStoppedAnimation(
                                                              180 / 360),
                                                      child:
                                                          CircularProgressIndicator(
                                                        backgroundColor:
                                                            AppColor.purple1
                                                                .withOpacity(
                                                                    0.2),
                                                        color: AppColor.purple1,
                                                        value: 1,
                                                        strokeWidth:
                                                            AppDimens.dimens_10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    height: width * 0.6,
                                                    width: width * 0.6,
                                                    child: Center(
                                                      child: Text(
                                                        formatTime(context
                                                            .select((TimerBloc
                                                                    bloc) =>
                                                                bloc.state
                                                                    .duration)),
                                                        style: AppAnother
                                                            .textStyleDefault(
                                                                AppDimens
                                                                    .dimens_32,
                                                                AppFont.medium,
                                                                AppColor
                                                                    .purple1),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: AppDimens.dimens_10,
                                          ),
                                          Text(
                                            'Set: ${state.set}/${int.parse(widget.set.split(',')[state.exercise])}',
                                            style: AppAnother.textStyleDefault(
                                                AppDimens.dimens_25,
                                                AppFont.medium,
                                                AppColor.blackColor),
                                          )
                                        ],
                                      )));
                                },
                              )
                            : SizedBox(
                                height: height,
                                child: BlocConsumer<HistoryBloc, HistoryState>(
                                    listener: (context, stateHistory) {},
                                    builder: (context, stateHistory) {
                                      if (dialog) {
                                        Navigator.of(context).pop();
                                      }
                                      Map<String, Object?> history =
                                          stateHistory.dataHistory.last;
                                      List<Map<String, Object?>>? listRepTime =
                                          stateHistory.dataRepAndTime;
                                      List<Map<String, Object?>>
                                          historyRepTime = [];
                                      for (var item in listRepTime) {
                                        if (history[AppString.dateTime] ==
                                            item[AppString.dateTime]) {
                                          historyRepTime.add(item);
                                        }
                                      }

                                      // DateTime dateTime = DateTime.now();
                                      return
                                          //  DateTime.parse(dateTimeFirst)
                                          //             .difference(dateTime)
                                          //             .inSeconds <=
                                          //         3
                                          //     ? Center(
                                          //         child: Column(
                                          //         children: [
                                          //           Text(
                                          //             'There is no data because the training time is too short',
                                          //             style: AppAnother
                                          //                 .textStyleDefault(
                                          //                     AppDimens.dimens_20,
                                          //                     AppFont.medium,
                                          //                     AppColor.blackColor),
                                          //           ),
                                          //           const SizedBox(
                                          //             height: AppDimens.dimens_20,
                                          //           ),
                                          //           SizedBox(
                                          //             height: AppDimens.dimens_50,
                                          //             child: ElevatedButton(
                                          //                 style: ElevatedButton
                                          //                     .styleFrom(
                                          //                         backgroundColor:
                                          //                             AppColor
                                          //                                 .greenColor),
                                          //                 onPressed: () {
                                          //                   Navigator.of(context)
                                          //                       .pop();
                                          //                 },
                                          //                 child: Text(
                                          //                   'Back',
                                          //                   style: AppAnother
                                          //                       .textStyleDefault(
                                          //                           AppDimens
                                          //                               .dimens_25,
                                          //                           AppFont
                                          //                               .semiBold,
                                          //                           AppColor
                                          //                               .whiteColor),
                                          //                 )),
                                          //           )
                                          //         ],
                                          //       )) :
                                          Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppDimens.dimens_20,
                                            vertical: AppDimens.dimens_10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Start: ${history[AppString.dateTime].toString().split(':')[0]}:${history[AppString.dateTime].toString().split(':')[1]}:${history[AppString.dateTime].toString().split(':')[2].split('.')[0]}',
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_20,
                                                      AppFont.medium,
                                                      AppColor.blackColor),
                                            ),
                                            Text(
                                              'End: ${history['DateTimeEnd'].toString().split(':')[0]}:${history['DateTimeEnd'].toString().split(':')[1]}:${history['DateTimeEnd'].toString().split(':')[2].split('.')[0]}',
                                              style:
                                                  AppAnother.textStyleDefault(
                                                      AppDimens.dimens_20,
                                                      AppFont.medium,
                                                      AppColor.blackColor),
                                            ),
                                            const SizedBox(
                                              height: AppDimens.dimens_15,
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                itemCount:
                                                    history[AppString.exercise]
                                                            .toString()
                                                            .split(',')
                                                            .length -
                                                        1,
                                                itemBuilder: (context, index) {
                                                  List<Map<String, Object?>>
                                                      exerciseRepAndTime = [];
                                                  for (var item
                                                      in historyRepTime) {
                                                    if (history[AppString
                                                                .exercise]
                                                            .toString()
                                                            .split(
                                                                ',')[index] ==
                                                        item[AppString.exercise]
                                                            .toString()) {
                                                      exerciseRepAndTime
                                                          .add(item);
                                                    }
                                                  }
                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        history[AppString
                                                                .exercise]
                                                            .toString()
                                                            .split(',')[index],
                                                        style: AppAnother
                                                            .textStyleDefault(
                                                                AppDimens
                                                                    .dimens_20,
                                                                AppFont.medium,
                                                                AppColor
                                                                    .blackColor),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            exerciseRepAndTime
                                                                    .length *
                                                                AppDimens
                                                                    .dimens_100,
                                                        child: ListView.builder(
                                                          itemCount:
                                                              exerciseRepAndTime
                                                                  .length,
                                                          itemBuilder: (context,
                                                              indexRepAndTime) {
                                                            return Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  bottom: AppDimens
                                                                      .dimens_3),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Set: ${exerciseRepAndTime[indexRepAndTime]['SetNumber']}',
                                                                        style: AppAnother.textStyleDefault(
                                                                            AppDimens.dimens_18,
                                                                            AppFont.normal,
                                                                            AppColor.blackColor),
                                                                      ),
                                                                      const SizedBox(
                                                                        width: AppDimens
                                                                            .dimens_20,
                                                                      ),
                                                                      Text(
                                                                          'Time: ${exerciseRepAndTime[indexRepAndTime][AppString.timeAtSet]}',
                                                                          style: AppAnother.textStyleDefault(
                                                                              AppDimens.dimens_18,
                                                                              AppFont.normal,
                                                                              AppColor.blackColor)),
                                                                      const SizedBox(
                                                                        width: AppDimens
                                                                            .dimens_20,
                                                                      ),
                                                                      Text(
                                                                          'Rest time: ${history[AppString.restTime].toString().split(',')[index]}',
                                                                          style: AppAnother.textStyleDefault(
                                                                              AppDimens.dimens_18,
                                                                              AppFont.normal,
                                                                              AppColor.blackColor)),
                                                                      if (int.parse(
                                                                              exerciseRepAndTime[indexRepAndTime][AppString.rep].toString()) !=
                                                                          0)
                                                                        const SizedBox(
                                                                          width:
                                                                              AppDimens.dimens_20,
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
                                                                            backgroundColor: AppColor
                                                                                .greenColor1),
                                                                        onPressed:
                                                                            () {
                                                                          CommonWidget
                                                                              .showRepAndWeightDialog(
                                                                            context,
                                                                            _controller,
                                                                            _editingController,
                                                                            _key,
                                                                            exerciseRepAndTime[indexRepAndTime][AppString.id]
                                                                                as int,
                                                                            AppAnother.validWeight,
                                                                          );
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Submit',
                                                                          style: AppAnother.textStyleDefault(
                                                                              AppDimens.dimens_20,
                                                                              AppFont.normal,
                                                                              AppColor.blackColor),
                                                                        )),
                                                                  if (int.parse(exerciseRepAndTime[indexRepAndTime][AppString.rep]
                                                                              .toString()) !=
                                                                          0 &&
                                                                      double.parse(
                                                                              exerciseRepAndTime[indexRepAndTime][AppString.weight].toString()) !=
                                                                          0)
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                            'Rep: ${exerciseRepAndTime[indexRepAndTime][AppString.rep]}',
                                                                            style: AppAnother.textStyleDefault(
                                                                                AppDimens.dimens_18,
                                                                                AppFont.normal,
                                                                                AppColor.blackColor)),
                                                                        Text(
                                                                            'Weight: ${exerciseRepAndTime[indexRepAndTime][AppString.weight]}',
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
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              height: AppDimens.dimens_50,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              AppColor
                                                                  .greenColor),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'Done',
                                                    style: AppAnother
                                                        .textStyleDefault(
                                                            AppDimens.dimens_25,
                                                            AppFont.semiBold,
                                                            AppColor
                                                                .whiteColor),
                                                  )),
                                            )
                                          ],
                                        ),
                                      );
                                    }))),
          ),
        );
      },
    );
  }
}

void handlerRestTime(
    TimerState stateTimer,
    String restTime,
    String exercise,
    VisibilityState state,
    String set,
    FlutterTts flutterTts,
    BuildContext context) {
  if (stateTimer.duration == int.parse(restTime.split(',')[state.exercise])) {
    if (state.set.toString() == set.split(',')[state.exercise] &&
        state.exercise != exercise.split(',').length - 2) {
      flutterTts.speak('Next ${exercise.split(',')[state.exercise + 1]} set 1');
    } else if (state.exercise == exercise.split(',').length - 2 &&
        state.set.toString() == set.split(',')[state.exercise]) {
      flutterTts.speak('Next stretching after exercise');
    } else {
      flutterTts.speak(
          'Next ${exercise.split(',')[state.exercise]} set ${state.set + 1}');
    }
  }

  if (stateTimer.duration < 6 && stateTimer.duration > 0) {
    flutterTts.speak(stateTimer.duration.toString());
  }
  if (stateTimer.duration == 0) {
    if (state.exercise == exercise.split(',').length - 2 &&
        state.set == int.parse(set.split(',')[state.exercise])) {
      flutterTts.speak('Done');
      context.read<TimerBloc>().add(const TimerCompleted());
    } else {
      context.read<TimerBloc>().add(const TimerStartedSet(duration: 0));
    }
    context.read<VisibilityBloc>().add(PracticeEvent(
        exercise.split(',').length - 1,
        int.parse(set.split(',')[state.exercise])));
  }
}

void handlerPractice(
    BuildContext context,
    String exercise,
    String restTime,
    String set,
    String dateTimeFirst,
    String dateTime,
    int duration,
    FlutterTts flutterTts,
    HistoryBloc historyBloc,
    PracticeState state,
    String method) async {
  context.read<TimerBloc>().add(TimerStartedRestTime(
      duration: int.parse(restTime.split(',')[state.exercise]),
      timeBegin: int.parse(restTime.split(',')[state.exercise])));

  context.read<VisibilityBloc>().add(RestTimeEvent());

  // if (DateTime.parse(dateTimeFirst)
  //         .difference(DateTime.parse(dateTime))
  //         .inSeconds >
  //     3) {
  if (state.exercise == 0 && state.set == 1) {
    await DbHelper().insert(AppString.historyTable, {
      AppString.dateTime: dateTimeFirst,
      'DateTimeEnd': dateTime,
      AppString.methodExercise: method,
      AppString.exercise: '${exercise.split(',')[state.exercise]},',
      AppString.restTime: '${restTime.split(',')[state.exercise]},'
    });
    await DbHelper().insert(AppString.repTimeTable, {
      AppString.dateTime: dateTimeFirst,
      AppString.exercise: exercise.split(',')[state.exercise],
      AppString.setNumber: state.set.toString(),
      AppString.timeAtSet: duration.toString(),
      AppString.rep: '0',
      AppString.weight: '0'
    });
  } else if (!(state.exercise == 0 && state.set == 1) &&
      !(state.exercise == 0 && state.set == 0)) {
    List<Map<String, Object?>> list =
        await DbHelper().getData(AppString.historyTable);
    if (state.exercise + 1 >
        list.last[AppString.exercise].toString().split(',').length - 1) {
      await DbHistoryRepository().update(
          AppString.historyTable,
          '${list.last[AppString.exercise].toString()}${exercise.split(',')[state.exercise]},',
          '${list.last[AppString.restTime].toString()}${restTime.split(',')[state.exercise]},',
          dateTime.toString(),
          list.length);
    } else {
      await DbHistoryRepository().updateDateTime(dateTime, list.length);
    }

    await DbHelper().insert(AppString.repTimeTable, {
      AppString.dateTime: dateTimeFirst,
      AppString.exercise: exercise.split(',')[state.exercise],
      AppString.setNumber: state.set.toString(),
      AppString.timeAtSet: duration.toString(),
      AppString.rep: '0',
      AppString.weight: '0'
    });
  }

  historyBloc.add(UpdateData());
  // }
}

String formatTime(int duration) {
  Duration value = Duration(seconds: duration);

  final hours = value.inHours.remainder(24).toString().padLeft(2, '0');

  final minutes = value.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = value.inSeconds.remainder(60).toString().padLeft(2, '0');
  if (value.inHours > 0) {
    return '$hours:$minutes:$seconds';
  } else {
    return '$minutes:$seconds';
  }
}
