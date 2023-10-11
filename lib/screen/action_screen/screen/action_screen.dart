import 'package:fitness_app_bloc/common_app/common_widget.dart';
import 'package:fitness_app_bloc/common_bloc/bloc_history/history_bloc.dart';
import 'package:fitness_app_bloc/config/app_another.dart';
import 'package:fitness_app_bloc/config/app_color.dart';
import 'package:fitness_app_bloc/config/app_dimens.dart';
import 'package:fitness_app_bloc/config/app_font.dart';
import 'package:fitness_app_bloc/config/app_path.dart';
import 'package:fitness_app_bloc/config/app_string.dart';
import 'package:fitness_app_bloc/db/database.dart';
import 'package:fitness_app_bloc/reused/method_reused.dart';
import 'package:fitness_app_bloc/reused/widget_reused.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../respository/db_history_repository.dart';
import '../../into_screen/home_page_bloc/home_page_bloc.dart';
import '../bloc/timer_bloc/timer_bloc.dart';
import '../bloc/visibility_bloc/visibility_bloc.dart';

class ActionScreen extends StatefulWidget {
  const ActionScreen(this.method, this.exercise, this.muscleGroup,
      this.restTime, this.set, this.cardioMethod, this.hiitMethod, this.time,
      {super.key});
  final String method;
  final String set;
  final String restTime;
  final String exercise;
  final String muscleGroup;
  final String cardioMethod;
  final String hiitMethod;
  final String time;

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
      listener: (context, state) async {
        if (state is PracticeState) {
          if (state.setDrop > 1) {
            flutterTts.speak(
                '${widget.exercise.split(',')[state.exercise]} set ${state.set.toString()} drop time ${(state.setDrop - 1).toString()}');
          } else {
            flutterTts.speak(
                '${widget.exercise.split(',')[state.exercise]} set ${state.set.toString()}');
          }
        } else if (state is RestTimeState) {}
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
                                      !context.read<HomePageBloc>().isMetric));
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
                    : state is RestTimeState
                        ? restTimeState(
                            _key,
                            height,
                            width,
                            widget.exercise,
                            widget.restTime,
                            widget.set,
                            flutterTts,
                            widget.cardioMethod,
                            widget.hiitMethod,
                            state,
                            _controller,
                            _editingController,
                            historyBloc,
                            widget.time,
                            context,
                            widget.method)
                        : state is PracticeState
                            ? practiceState(
                                height,
                                width,
                                state,
                                dateTimeFirst,
                                widget.exercise,
                                widget.restTime,
                                widget.set,
                                widget.method,
                                flutterTts,
                                historyBloc,
                                context)
                            : state is PracticeCardioState
                                ? practiceCardioState(
                                    flutterTts,
                                    height,
                                    width,
                                    context,
                                    widget.cardioMethod,
                                    widget.hiitMethod,
                                    state,
                                    widget.exercise,
                                    widget.time,
                                    widget.set,
                                    widget.restTime,
                                    dateTimeFirst,
                                    widget.method,
                                    historyBloc)
                                : doneState(
                                    height,
                                    dialog,
                                    _key,
                                    _controller,
                                    _editingController,
                                    dateTimeFirst,
                                    widget.method,
                                    widget.hiitMethod,
                                    widget.cardioMethod)),
          ),
        );
      },
    );
  }
}

/////
///
///
///
///
/// Rest time state
Widget restTimeState(
    GlobalKey<FormState> key,
    double height,
    double width,
    String exercise,
    String restTime,
    String set,
    FlutterTts flutterTts,
    String cardioMethod,
    String hiitMethod,
    RestTimeState state,
    TextEditingController controller,
    TextEditingController editingController,
    HistoryBloc historyBloc,
    String time,
    BuildContext context,
    String method) {
  final List<String> listExercise = exercise.split(',');
  final List<String> listSet = set.split(',');

  handlerRestTime(
      context.select((TimerBloc bloc) => bloc.state),
      restTime,
      exercise,
      state,
      set,
      time,
      cardioMethod,
      hiitMethod,
      flutterTts,
      context);
  return Container(
      padding: const EdgeInsets.only(bottom: AppDimens.dimens_10),
      height: height,
      child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.dimens_20, vertical: AppDimens.dimens_10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.set > 0 &&
                    !listExercise[state.exercise].contains('Superset') &&
                    (method == AppString.calisthenics ||
                        method == AppString.inTheGym))
                  addWeighAndRep(
                      key,
                      controller,
                      editingController,
                      context,
                      state.setDrop,
                      state.exercise,
                      exercise,
                      set,
                      historyBloc,
                      false,
                      ''),
                if (state.set > 0 &&
                    listExercise[state.exercise].contains('Superset') &&
                    (method == AppString.calisthenics ||
                        method == AppString.inTheGym))
                  addWeightAndRepSuperset(exercise, state, key, controller,
                      editingController, historyBloc, set),
                const SizedBox(
                  height: AppDimens.dimens_10,
                ),
                if (state.set == 0)
                  Text(
                    'Ready in:',
                    textAlign: TextAlign.center,
                    style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                        AppFont.medium, AppColor.blackColor),
                  ),
                if (state.set > 0 && hiitMethod != 'group')
                  Text(
                    listExercise[state.exercise].contains('Dropset')
                        ? '${listExercise[state.exercise].split(':')[0]}: ${listExercise[state.exercise].split(':')[1]}'
                        : listExercise[state.exercise],
                    textAlign: TextAlign.center,
                    style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                        AppFont.medium, AppColor.blackColor),
                  ),
                const SizedBox(
                  height: AppDimens.dimens_15,
                ),
                Stack(
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        height: width * 0.6,
                        width: width * 0.6,
                        child: RotationTransition(
                          turns: const AlwaysStoppedAnimation(180 / 360),
                          child: CircularProgressIndicator(
                            backgroundColor: AppColor.purple1.withOpacity(0.2),
                            color: AppColor.purple1,
                            value: context.select(
                                    (TimerBloc bloc) => bloc.state.duration) /
                                context.select(
                                    (TimerBloc bloc) => bloc.state.timeBegin),
                            strokeWidth: AppDimens.dimens_10,
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
                            MethodReused.formatTime(context.select(
                                (TimerBloc bloc) => bloc.state.duration)),
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_32,
                                AppFont.medium,
                                AppColor.purple1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.set > 0 &&
                    (method == AppString.calisthenics ||
                        method == AppString.inTheGym))
                  const SizedBox(
                    height: AppDimens.dimens_10,
                  ),
                if (state.set > 0 &&
                    (method == AppString.calisthenics ||
                        method == AppString.inTheGym))
                  Text(
                      'Rest time : ${state.set}/ ${(listExercise[state.exercise].contains('Dropset') ? int.parse(listSet[state.exercise].split(':')[0]) : int.parse(listSet[state.exercise]))}',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                          AppFont.medium, AppColor.blackColor)),
                if (listExercise[state.exercise].contains('Dropset') &&
                    int.parse(listSet[state.exercise].split(':')[1]) + 1 >
                        state.setDrop)
                  Text(
                      'Next drop time:  ${state.setDrop.toString()}/ ${listSet[state.exercise].split(':')[1]}',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                          AppFont.medium, AppColor.blackColor)),
                if (visibilityNextExercise(
                    hiitMethod,
                    listExercise,
                    listSet,
                    exercise,
                    set,
                    state.exercise,
                    state.set,
                    state.setDrop,
                    cardioMethod))
                  const SizedBox(
                    height: AppDimens.dimens_10,
                  ),
                if (visibilityNextExercise(
                    hiitMethod,
                    listExercise,
                    listSet,
                    exercise,
                    set,
                    state.exercise,
                    state.set,
                    state.setDrop,
                    cardioMethod))
                  Text(
                    'Next  ${hiitMethod == '' ? listExercise[state.exercise + 1] : nextExercise(exercise, state.exercise, state.set, int.parse(set), state.setDrop, hiitMethod, true)}',
                    textAlign: TextAlign.center,
                    style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                        AppFont.medium, AppColor.blackColor),
                  ),
                if (visibilityNextAfterExercise(
                    hiitMethod,
                    listExercise,
                    listSet,
                    exercise,
                    set,
                    cardioMethod,
                    state.exercise,
                    state.set,
                    state.setDrop))
                  const SizedBox(
                    height: AppDimens.dimens_10,
                  ),
                if (visibilityNextAfterExercise(
                    hiitMethod,
                    listExercise,
                    listSet,
                    exercise,
                    set,
                    cardioMethod,
                    state.exercise,
                    state.set,
                    state.setDrop))
                  Text(
                    'Next stretching after exercise',
                    textAlign: TextAlign.center,
                    style: AppAnother.textStyleDefault(AppDimens.dimens_25,
                        AppFont.medium, AppColor.blackColor),
                  ),
              ])));
}
//// Practice State
///
///
///
///
///
///
///

Widget practiceState(
    double height,
    double width,
    PracticeState state,
    String dateTimeFirst,
    String exercise,
    String restTime,
    String set,
    String method,
    FlutterTts flutterTts,
    HistoryBloc historyBloc,
    BuildContext context) {
  int duration = context.select((TimerBloc bloc) => bloc.state.duration);
  List<String> listExercise = exercise.split(',');
  return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.dimens_15),
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            method == AppString.cardio
                ? listExercise[state.exercise].contains('Dropset')
                    ? '${listExercise[state.exercise].split(':')[0]}: ${listExercise[state.exercise].split(':')[1]}'
                    : listExercise[state.exercise]
                : exercise,
            textAlign: TextAlign.center,
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.medium, AppColor.blackColor),
          ),
          const SizedBox(
            height: AppDimens.dimens_15,
          ),
          GestureDetector(
            onTap: () {
              String dateTime = DateTime.now().toString();

              handlerPractice(context, exercise, restTime, set, dateTimeFirst,
                  dateTime, duration, flutterTts, historyBloc, state, method);
            },
            child: Stack(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: width * 0.6,
                    width: width * 0.6,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(180 / 360),
                      child: CircularProgressIndicator(
                        backgroundColor: AppColor.purple1.withOpacity(0.2),
                        color: AppColor.purple1,
                        value: 1,
                        strokeWidth: AppDimens.dimens_10,
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
                        MethodReused.formatTime(context
                            .select((TimerBloc bloc) => bloc.state.duration)),
                        style: AppAnother.textStyleDefault(AppDimens.dimens_32,
                            AppFont.medium, AppColor.purple1),
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
          if (listExercise[state.exercise].contains('Dropset'))
            Text(
                'Drop time: ${state.setDrop - 1}/${set.split(',')[state.exercise].split(':')[1]}',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_25, AppFont.medium, AppColor.blackColor)),
          if (listExercise[state.exercise].contains('Dropset'))
            const SizedBox(
              height: AppDimens.dimens_10,
            ),
          if (exercise.contains(','))
            Text(
              listExercise[state.exercise].contains('Dropset')
                  ? 'Set: ${state.set}/${set.split(',')[state.exercise].split(':')[0]}'
                  : 'Set: ${state.set}/${set.split(',')[state.exercise]}',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_25, AppFont.medium, AppColor.blackColor),
            ),
          const SizedBox(
            height: AppDimens.dimens_10,
          ),
        ],
      )));
}
//////
///
///
///
/// Practice cardio state

Widget practiceCardioState(
    FlutterTts flutterTts,
    double height,
    double width,
    BuildContext context,
    String cardioMethod,
    String hiitMethod,
    PracticeCardioState state,
    String exercise,
    String time,
    String set,
    String restTime,
    String daterTimeFirst,
    String method,
    HistoryBloc historyBloc) {
  TimerState timerState = context.select((TimerBloc bloc) => bloc.state);
  handlerPracticeCardio(state, context, cardioMethod, daterTimeFirst, method,
      exercise, time, set, restTime, historyBloc, hiitMethod, timerState);

  return Container(
    height: height,
    width: double.infinity,
    padding: const EdgeInsets.all(AppDimens.dimens_15),
    child: Center(
      child: Column(
        children: [
          Text('Set: ${state.set}/$set',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_25, AppFont.medium, AppColor.blackColor)),
          const SizedBox(
            height: AppDimens.dimens_10,
          ),
          if (hiitMethod == 'group')
            Text('Level: ${state.setDrop}/${exercise.split(':').length}',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_25, AppFont.medium, AppColor.blackColor)),
          if (hiitMethod == 'group')
            const SizedBox(
              height: AppDimens.dimens_10,
            ),
          Text(
            hiitMethod == 'group'
                ? exercise
                    .split(':')[state.setDrop - 1]
                    .split(',')[state.exercise]
                : exercise.split(',')[state.exercise],
            textAlign: TextAlign.center,
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_25, AppFont.medium, AppColor.blackColor),
          ),
          const SizedBox(
            height: AppDimens.dimens_15,
          ),
          Stack(
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: width * 0.6,
                  width: width * 0.6,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(180 / 360),
                    child: CircularProgressIndicator(
                      backgroundColor: AppColor.purple1.withOpacity(0.2),
                      color: AppColor.purple1,
                      value: timerState.duration / timerState.timeBegin,
                      strokeWidth: AppDimens.dimens_10,
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
                      MethodReused.formatTime(timerState.duration),
                      style: AppAnother.textStyleDefault(AppDimens.dimens_32,
                          AppFont.medium, AppColor.purple1),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (hiitMethod != 'seqentially')
            const SizedBox(
              height: AppDimens.dimens_10,
            ),
          if (hiitMethod != 'seqentially')
            Text(
              'Next ${nextExercise(exercise, state.exercise, state.set, int.parse(set), state.setDrop, hiitMethod, false)}',
              textAlign: TextAlign.center,
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_25, AppFont.medium, AppColor.blackColor),
            )
        ],
      ),
    ),
  );
}

////
///
///
///
///
/// Done State

Widget doneState(
  double height,
  bool dialog,
  GlobalKey<FormState> key,
  TextEditingController controller,
  TextEditingController editingController,
  String dateTimeFirst,
  String method,
  String hiitMethod,
  String cardioMethod,
) {
  return SizedBox(
      height: height,
      child: BlocConsumer<HistoryBloc, HistoryState>(
          listener: (context, stateHistory) {},
          builder: (context, stateHistory) {
            if (dialog) {
              Navigator.of(context).pop();
            }
            Map<String, Object?> history = stateHistory.dataHistory.last;
            List<Map<String, Object?>>? listRepTime =
                stateHistory.dataRepAndTime;
            List<Map<String, Object?>> historyRepTime = [];
            for (var item in listRepTime) {
              if (history[AppString.dateTime] == item[AppString.dateTime]) {
                historyRepTime.add(item);
              }
            }

            // DateTime dateTime = DateTime.now();
            return
                // DateTime.parse(dateTimeFirst)
                //             .difference(dateTime)
                //             .inSeconds <=
                //         3
                //     ? Center(
                //         child: Column(
                //         children: [
                //           Text(
                //             'There is no data because the training time is too short',
                //             style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                //                 AppFont.medium, AppColor.blackColor),
                //           ),
                //           const SizedBox(
                //             height: AppDimens.dimens_20,
                //           ),
                //           SizedBox(
                //             height: AppDimens.dimens_50,
                //             child: ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                     backgroundColor: AppColor.greenColor),
                //                 onPressed: () {
                //                   Navigator.of(context).pop();
                //                 },
                //                 child: Text(
                //                   'Back',
                //                   style: AppAnother.textStyleDefault(
                //                       AppDimens.dimens_25,
                //                       AppFont.semiBold,
                //                       AppColor.whiteColor),
                //                 )),
                //           )
                //         ],
                //       ))
                //     :
                Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.dimens_20,
                  vertical: AppDimens.dimens_10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time: ${MethodReused.formatTime(DateTime.parse(history['DateTimeEnd'] as String).difference(DateTime.parse(history[AppString.dateTime] as String)).inSeconds)}',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                        AppFont.medium, AppColor.blackColor),
                  ),
                  const SizedBox(
                    height: AppDimens.dimens_15,
                  ),
                  Expanded(
                      child: method == AppString.cardio
                          ? widgetHistoryCardio(
                              hiitMethod, history, historyRepTime, cardioMethod)
                          : widgetHistoryAnother(history, historyRepTime,
                              controller, editingController, key)),
                  SizedBox(
                    width: double.infinity,
                    height: AppDimens.dimens_50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.greenColor),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Done',
                          style: AppAnother.textStyleDefault(
                              AppDimens.dimens_25,
                              AppFont.semiBold,
                              AppColor.whiteColor),
                        )),
                  )
                ],
              ),
            );
          }));
}
/////
////
///
///
///
/// Handler practice

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
  String exerciseNow = exercise.split(',')[state.exercise];
  String setNow = set.split(',')[state.exercise];
  String restTimeNow = restTime.split(',')[state.exercise];
  if (method == AppString.cardio) {
    context.read<TimerBloc>().add(const TimerCompleted());
    context.read<VisibilityBloc>().add(DoneEvent());
  } else {
    if (exerciseNow.contains('Dropset')) {
      if (int.parse(setNow.split(':')[1]) + 1 == state.setDrop) {
        context.read<TimerBloc>().add(TimerStartedRestTime(
            duration: int.parse(restTimeNow.split(':')[0]),
            timeBegin: int.parse(restTimeNow.split(':')[0])));
        context.read<VisibilityBloc>().add(RestTimeEvent());
      } else {
        context.read<TimerBloc>().add(TimerStartedRestTime(
            duration: int.parse(restTimeNow.split(':')[1]),
            timeBegin: int.parse(restTimeNow.split(':')[1])));
        context.read<VisibilityBloc>().add(RestTimeEvent());
      }

      context.read<VisibilityBloc>().add(RestTimeEvent());
    } else {
      context.read<TimerBloc>().add(TimerStartedRestTime(
          duration: int.parse(restTimeNow), timeBegin: int.parse(restTimeNow)));

      context.read<VisibilityBloc>().add(RestTimeEvent());
    }
  }

  // if (DateTime.parse(dateTimeFirst)
  //         .difference(DateTime.parse(dateTime))
  //         .inSeconds >
  //     3) {
  if (method != AppString.cardio) {
    if (state.exercise == 0 && state.set == 1) {
      await DbHelper().insert(AppString.historyTable, {
        AppString.dateTime: dateTimeFirst,
        'DateTimeEnd': dateTime,
        AppString.methodExercise: method,
        AppString.exercise: '${exercise.split(',')[state.exercise]},',
        AppString.restTime: '${restTime.split(',')[state.exercise]},'
      });
      if (exerciseNow.contains('Dropset')) {
        List<Map<String, Object?>> listRepAndTime =
            await DbHelper().getData(AppString.repTimeTable);
        if (state.setDrop == 1) {
          await DbHelper().insert(AppString.repTimeTable, {
            AppString.dateTime: dateTimeFirst,
            AppString.exercise: exerciseNow,
            AppString.setNumber: '${state.set}:${state.setDrop}',
            AppString.timeAtSet: duration.toString(),
            AppString.rep: '0',
            AppString.weight: '0'
          });
        } else {
          await DbHistoryRepository().updateData(
              listRepAndTime.last[AppString.id] as int,
              '${listRepAndTime.last[AppString.timeAtSet] as String}:$duration',
              '${state.set}:${state.setDrop}');
        }
      } else {
        await DbHelper().insert(AppString.repTimeTable, {
          AppString.dateTime: dateTimeFirst,
          AppString.exercise: exercise.split(',')[state.exercise],
          AppString.setNumber: state.set.toString(),
          AppString.timeAtSet: duration.toString(),
          AppString.rep: '0',
          AppString.weight: '0'
        });
      }
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

      if (exerciseNow.contains('Dropset')) {
        List<Map<String, Object?>> listRepAndTime =
            await DbHelper().getData(AppString.repTimeTable);
        if (state.setDrop == 1) {
          await DbHelper().insert(AppString.repTimeTable, {
            AppString.dateTime: dateTimeFirst,
            AppString.exercise: exerciseNow,
            AppString.setNumber: '${state.set}:${state.setDrop}',
            AppString.timeAtSet: duration.toString(),
            AppString.rep: '0',
            AppString.weight: '0'
          });
        } else {
          await DbHistoryRepository().updateData(
              listRepAndTime.last[AppString.id] as int,
              '${listRepAndTime.last[AppString.timeAtSet] as String}:$duration',
              '${state.set}:${state.setDrop}');
        }
      } else {
        await DbHelper().insert(AppString.repTimeTable, {
          AppString.dateTime: dateTimeFirst,
          AppString.exercise: exercise.split(',')[state.exercise],
          AppString.setNumber: state.set.toString(),
          AppString.timeAtSet: duration.toString(),
          AppString.rep: '0',
          AppString.weight: '0'
        });
      }
    }
  } else {
    await DbHelper().insert(AppString.historyTable, {
      AppString.dateTime: dateTimeFirst,
      'DateTimeEnd': dateTime,
      AppString.methodExercise: method,
      AppString.exercise: exercise,
    });
  }

  historyBloc.add(UpdateData());
  // }
}

Widget textFieldAddRepAndWeight(TextEditingController editingController,
    BuildContext context, String hint) {
  return TextFormField(
      style: AppAnother.textStyleDefault(
          AppDimens.dimens_20, AppFont.normal, AppColor.blackColor),
      onChanged: (value) {},
      controller: editingController,
      validator: (value) => hint == AppString.weight
          ? MethodReused.validWeight(value!)
          : (value!.isEmpty
              ? 'Please enter value'
              : (value.contains('.') ||
                      value.contains('-') ||
                      value.contains(' ') ||
                      value.contains(','))
                  ? 'Please enter the number '
                  : int.parse(value) == 0
                      ? 'Please enter the $hint'
                      : null),
      cursorColor: AppColor.blackColor,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          suffixIconColor: AppColor.blackColor,
          suffixIcon: hint == AppString.weight
              ? IconButton(
                  onPressed: () {
                    context.read<HomePageBloc>().add(
                        UntiChange(!context.read<HomePageBloc>().isMetric));
                  },
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(
                    Icons.refresh_sharp,
                  ))
              : const SizedBox(
                  height: AppDimens.dimens_0,
                  width: AppDimens.dimens_0,
                ),
          border: const OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppDimens.dimens_10)),
              borderSide: BorderSide(color: AppColor.colorGrey3)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: AppDimens.dimens_20),
          filled: true,
          hintText: hint == AppString.weight
              ? context.read<HomePageBloc>().isMetric
                  ? 'kg'
                  : 'lbs'
              : 'rep',
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colorGrey3),
              borderRadius:
                  BorderRadius.all(Radius.circular(AppDimens.dimens_10))),
          focusedBorder: const OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppDimens.dimens_10)),
              borderSide: BorderSide(color: AppColor.blackColor))));
}

/////
///
///
///
/// Add weight and rep
Widget addWeighAndRep(
    GlobalKey<FormState> key,
    TextEditingController controller,
    TextEditingController editingController,
    BuildContext context,
    int setDrop,
    int exerciseIndex,
    String exercise,
    String set,
    HistoryBloc historyBloc,
    bool superset,
    String currentExercise) {
  return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!superset)
            Center(
              child: Text(
                'Enter the number of reps and weight you just trained:',
                style: AppAnother.textStyleDefault(
                    AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  'Rep',
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
                ),
                const SizedBox(
                  width: AppDimens.dimens_20,
                ),
                Expanded(
                    child: textFieldAddRepAndWeight(
                        controller, context, AppString.rep)),
              ],
            ),
          ),
          const SizedBox(
            height: AppDimens.dimens_10,
          ),
          BlocConsumer<HomePageBloc, HomePageState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SizedBox(
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
                        child: textFieldAddRepAndWeight(
                            editingController, context, AppString.weight)),
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
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.greenColor1),
                onPressed: () async {
                  if (key.currentState!.validate()) {
                    addWeightAndRepMEthod(
                        context,
                        editingController,
                        superset,
                        exercise,
                        currentExercise,
                        exerciseIndex,
                        controller,
                        historyBloc,
                        setDrop,
                        set);
                  }
                },
                child: Text(
                  'Submit',
                  style: AppAnother.textStyleDefault(
                      AppDimens.dimens_20, AppFont.normal, AppColor.blackColor),
                )),
          )
        ],
      ));
}

Widget addWeightAndRepSuperset(
    String exercise,
    RestTimeState state,
    GlobalKey<FormState> key,
    TextEditingController controller,
    TextEditingController editingController,
    HistoryBloc historyBloc,
    String set) {
  return Expanded(
    child: ListView.builder(
      itemCount: exercise.split(',')[state.exercise].split(';').length - 1,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${exercise.split(',')[state.exercise].split(':')[1].split(';')[index]}:',
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_20, AppFont.normal, AppColor.blackColor),
            ),
            if (!state.exerciseName.contains(exercise
                .split(',')[state.exercise]
                .split(':')[1]
                .split(';')[index]))
              Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: AppDimens.dimens_5),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.greenColor1),
                    onPressed: () async {
                      context.read<VisibilityBloc>().add(VisibilityAdd(exercise
                          .split(',')[state.exercise]
                          .split(':')[1]
                          .split(';')[index]));
                    },
                    child: Text(
                      'Add weight and rep',
                      style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                          AppFont.normal, AppColor.blackColor),
                    )),
              ),
            if (state.exerciseName.contains(exercise
                .split(',')[state.exercise]
                .split(':')[1]
                .split(';')[index]))
              addWeighAndRep(
                  key,
                  controller,
                  editingController,
                  context,
                  state.setDrop,
                  state.exercise,
                  exercise,
                  set,
                  historyBloc,
                  true,
                  state.exerciseName)
          ],
        );
      },
    ),
  );
}
/////
///
///
/// Handler practice cardio

void handlerPracticeCardio(
    PracticeCardioState state,
    BuildContext context,
    String cardioMethod,
    String daterTimeFirst,
    String method,
    String exercise,
    String time,
    String set,
    String restTime,
    HistoryBloc historyBloc,
    String hiitMethod,
    TimerState timerState) {
  if (timerState.duration == 0) {
    final DateTime dateTime = DateTime.now();

    Map<String, Object?> dataHistoryNow =
        context.select((HistoryBloc bloc) => bloc.state.dataHistory).isEmpty
            ? {}
            : context.select((HistoryBloc bloc) => bloc.state.dataHistory.last);
    Map<String, Object?> dataRepAndTimeNow = context
            .select((HistoryBloc bloc) => bloc.state.dataRepAndTime)
            .isEmpty
        ? {}
        : context.select((HistoryBloc bloc) => bloc.state.dataRepAndTime.last);
    if (cardioMethod == AppString.lissCardio) {
      if (state.exercise == 0 && state.set == 1) {
        DbHelper()
            .insert(AppString.historyTable, {
              AppString.dateTime: daterTimeFirst,
              'DateTimeEnd': dateTime.toString(),
              AppString.methodExercise: method,
              AppString.exercise: exercise,
              AppString.time: time
            })
            .then((value) => DbHelper().insert(AppString.repTimeTable, {
                  AppString.dateTime: daterTimeFirst,
                  AppString.exercise: '${exercise.split(',')[state.exercise]},',
                  AppString.setNumber: state.set.toString()
                }))
            .then((value) => historyBloc.add(UpdateData()));
      } else {
        DbHistoryRepository()
            .updateDateTime(
                dateTime.toString(), dataHistoryNow[AppString.id] as int)
            .then((value) {
          if (dataRepAndTimeNow[AppString.setNumber].toString() ==
              state.set.toString()) {
            DbHistoryRepository().updateExercise(
                dataRepAndTimeNow[AppString.id] as int,
                '${dataRepAndTimeNow[AppString.exercise]}${exercise.split(',')[state.exercise]},');
          } else {
            DbHelper().insert(AppString.repTimeTable, {
              AppString.dateTime: daterTimeFirst,
              AppString.exercise: '${exercise.split(',')[state.exercise]},',
              AppString.setNumber: state.set.toString(),
            });
          }
        }).then((value) => historyBloc.add(UpdateData()));
      }
      context.read<VisibilityBloc>().add(PracticeCardioEvent(
          exercise.split(',').length - 1, int.parse(set), 0));
      if (exercise.split(',').length - 2 == state.exercise &&
          int.parse(set) == state.set) {
        context.read<TimerBloc>().add(const TimerCompleted());
      } else {
        context.read<TimerBloc>().add(TimerStartedRestTime(
            duration: int.parse(time), timeBegin: int.parse(time)));
      }
    } else {
      if (hiitMethod == 'sequentially') {
        if (state.exercise == 0 && state.set == 1) {
          DbHelper()
              .insert(AppString.historyTable, {
                AppString.dateTime: daterTimeFirst,
                'DateTimeEnd': dateTime.toString(),
                AppString.methodExercise: method,
                AppString.exercise: exercise,
                AppString.restTime: restTime,
                AppString.time: time
              })
              .then((value) => DbHelper().insert(AppString.repTimeTable, {
                    AppString.dateTime: daterTimeFirst,
                    AppString.exercise:
                        '${exercise.split(',')[state.exercise]},',
                    AppString.setNumber: state.set.toString(),
                  }))
              .then((value) => historyBloc.add(UpdateData()));
        } else {
          DbHistoryRepository()
              .updateDateTime(
                  dateTime.toString(), dataHistoryNow[AppString.id] as int)
              .then((value) {
            if (dataRepAndTimeNow[AppString.setNumber].toString() ==
                state.set.toString()) {
              DbHistoryRepository().updateExercise(
                  dataRepAndTimeNow[AppString.id] as int,
                  '${dataRepAndTimeNow[AppString.exercise]}${exercise.split(',')[state.exercise]},');
            } else {
              DbHelper().insert(AppString.repTimeTable, {
                AppString.dateTime: daterTimeFirst,
                AppString.exercise: '${exercise.split(',')[state.exercise]},',
                AppString.setNumber: state.set.toString(),
              });
            }
          }).then((value) => historyBloc.add(UpdateData()));
        }

        context.read<VisibilityBloc>().add(RestTimeEvent());

        context.read<TimerBloc>().add(TimerStartedRestTime(
            duration: int.parse(restTime), timeBegin: int.parse(restTime)));
      } else {
        if (state.exercise == 0 && state.set == 1) {
          DbHelper()
              .insert(AppString.historyTable, {
                AppString.dateTime: daterTimeFirst,
                'DateTimeEnd': dateTime.toString(),
                AppString.methodExercise: method,
                AppString.exercise: exercise,
                AppString.restTime: restTime,
                AppString.time: time
              })
              .then((value) => DbHelper().insert(AppString.repTimeTable, {
                    AppString.dateTime: daterTimeFirst,
                    AppString.exercise:
                        '${exercise.split(':')[state.setDrop - 1].split(',')[state.exercise]},',
                    AppString.setNumber: state.set.toString(),
                    AppString.level: state.setDrop.toString()
                  }))
              .then((value) => historyBloc.add(UpdateData()));
        } else {
          DbHistoryRepository()
              .updateDateTime(
                  dateTime.toString(), dataHistoryNow[AppString.id] as int)
              .then((value) {
            if (dataRepAndTimeNow[AppString.setNumber].toString() ==
                state.set.toString()) {
              DbHistoryRepository().updateExercise(
                  dataRepAndTimeNow[AppString.id] as int,
                  '${dataRepAndTimeNow[AppString.exercise]}${exercise.split(':')[state.setDrop - 1].split(',')[state.exercise]},');
            } else {
              DbHelper().insert(AppString.repTimeTable, {
                AppString.dateTime: daterTimeFirst,
                AppString.exercise:
                    '${exercise.split(':')[state.setDrop - 1].split(',')[state.exercise]},',
                AppString.setNumber: state.set.toString(),
                AppString.level: state.setDrop.toString()
              });
            }
          }).then((value) => historyBloc.add(UpdateData()));
        }

        if (exercise.split(':')[state.setDrop - 1].split(',').length - 2 ==
            state.exercise) {
          context.read<VisibilityBloc>().add(RestTimeEvent());
          context.read<TimerBloc>().add(TimerStartedRestTime(
              duration: int.parse(restTime), timeBegin: int.parse(restTime)));
        } else {
          context.read<VisibilityBloc>().add(PracticeCardioEvent(
              exercise.split(':')[state.setDrop - 1].split(',').length - 1,
              int.parse(set),
              exercise.split(':').length));
          context.read<TimerBloc>().add(TimerStartedRestTime(
              duration: int.parse(time), timeBegin: int.parse(time)));
        }
      }
    }
  }
}

/////
///
///
/// HandlerRestTime
void handlerRestTime(
    TimerState stateTimer,
    String restTime,
    String exercise,
    VisibilityState state,
    String set,
    String time,
    String cardioMethod,
    String hiitMethod,
    FlutterTts flutterTts,
    BuildContext context) {
  if (state.set > 0) {
    if (cardioMethod == '') {
      if (exercise.split(',')[state.exercise].contains('Dropset')) {
        if (state.setDrop ==
            int.parse(set.split(',')[state.exercise].split(':')[1]) + 1) {
          if (stateTimer.duration ==
              int.parse(restTime.split(',')[state.exercise].split(':')[0])) {
            if (state.set.toString() ==
                    set.split(',')[state.exercise].split(':')[0] &&
                state.exercise != exercise.split(',').length - 2) {
              flutterTts.speak(
                  'Next ${exercise.split(',')[state.exercise + 1].split(':')[1]} set 1');
            } else if (state.exercise == exercise.split(',').length - 2 &&
                state.set.toString() ==
                    set.split(',')[state.exercise].split(':')[0]) {
              flutterTts.speak('Next stretching after exercise');
            } else {
              flutterTts.speak(
                  'Next ${exercise.split(',')[state.exercise].split(':')[1]} set ${state.set + 1}');
            }
          }
        }
      } else {
        if (stateTimer.duration ==
            int.parse(restTime.split(',')[state.exercise])) {
          if (state.set.toString() == set.split(',')[state.exercise] &&
              state.exercise != exercise.split(',').length - 2) {
            flutterTts
                .speak('Next ${exercise.split(',')[state.exercise + 1]} set 1');
          } else if (state.exercise == exercise.split(',').length - 2 &&
              state.set.toString() == set.split(',')[state.exercise]) {
            flutterTts.speak('Next stretching after exercise');
          } else {
            flutterTts.speak(
                'Next ${exercise.split(',')[state.exercise]} set ${state.set + 1}');
          }
        }
      }
      if (exercise.split(',')[state.exercise].contains('Dropset')) {
        if (state.setDrop <
            int.parse(set.split(',')[state.exercise].split(':')[1]) + 1) {
          flutterTts.speak(stateTimer.duration.toString());
        } else if (stateTimer.duration < 6 && stateTimer.duration > 0) {
          flutterTts.speak(stateTimer.duration.toString());
        }
      } else {
        if (stateTimer.duration < 6 && stateTimer.duration > 0) {
          flutterTts.speak(stateTimer.duration.toString());
        }
      }
    } else {
      if (hiitMethod == 'sequentially') {
        if (exercise.split(',').length - 2 == state.exercise &&
            int.parse(set) == state.set) {
          flutterTts.speak('Next stretching after exercise');
        } else {
          flutterTts.speak('Next ${exercise.split(',')[state.exercise]}');
        }
      } else {
        if (exercise.split(':')[state.setDrop - 1].split(',').length - 2 ==
                state.exercise &&
            int.parse(set) == state.set &&
            exercise.split(':').length == state.setDrop) {
          flutterTts.speak('Next stretching after exercise');
        } else {
          flutterTts.speak(
              'Next ${exercise.split(':')[state.setDrop - 1].split(',')[state.exercise]}');
        }
      }
      if (stateTimer.duration < 6 && stateTimer.duration > 0) {
        flutterTts.speak(stateTimer.duration.toString());
      }
    }
  } else {
    flutterTts.speak('ready in').then((value) {
      if (stateTimer.duration < 10 && stateTimer.duration > 0) {
        flutterTts.speak(stateTimer.duration.toString());
      } else if (stateTimer.duration == 0) {
        flutterTts.speak('start');
      }
    });
  }

  if (stateTimer.duration == 0) {
    if (cardioMethod == '') {
      context.read<VisibilityBloc>().add(const VisibilityAdd(''));
      if (exercise.split(',')[state.exercise].contains('Dropset')) {
        if (state.exercise == exercise.split(',').length - 2 &&
            state.setDrop ==
                int.parse(set.split(',')[state.exercise].split(':')[1]) + 1 &&
            state.set ==
                int.parse(set.split(',')[state.exercise].split(':')[0])) {
          flutterTts.speak('Done');
          context.read<TimerBloc>().add(const TimerCompleted());
        } else {
          context.read<TimerBloc>().add(const TimerStartedSet(duration: 0));
        }

        context.read<VisibilityBloc>().add(PracticeEvent(
            exercise.split(',').length - 1,
            int.parse(set.split(',')[state.exercise].split(':')[0]),
            int.parse(set.split(',')[state.exercise].split(':')[1]) + 1,
            exercise.split(',')[state.exercise],
            exercise.split(',')[state.exercise + 1]));
      } else {
        if (state.exercise == exercise.split(',').length - 2 &&
            state.set == int.parse(set.split(',')[state.exercise])) {
          flutterTts.speak('Done');
          context.read<TimerBloc>().add(const TimerCompleted());
        } else {
          context.read<TimerBloc>().add(const TimerStartedSet(duration: 0));
        }
        context.read<VisibilityBloc>().add(PracticeEvent(
            exercise.split(',').length - 1,
            int.parse(set.split(',')[state.exercise]),
            0,
            exercise.split(',')[state.exercise],
            exercise.split(',')[state.exercise + 1]));
      }
    } else {
      if (cardioMethod == AppString.lissCardio) {
        if (AppAnother.lissCardioExercise
                .indexWhere((element) => element == exercise) <
            0) {
          if (exercise.split(',').length - 2 == state.exercise &&
              int.parse(set) == state.set) {
            flutterTts.speak('Done');
            context.read<TimerBloc>().add(const TimerCompleted());
          } else {
            context.read<TimerBloc>().add(TimerStartedRestTime(
                duration: int.parse(time), timeBegin: int.parse(time)));
          }
          context.read<VisibilityBloc>().add(PracticeCardioEvent(
              exercise.split(',').length - 1, int.parse(set), 0));
        } else {
          context.read<TimerBloc>().add(const TimerStartedSet(duration: 0));
          context
              .read<VisibilityBloc>()
              .add(PracticeEvent(0, 0, 0, exercise, ''));
        }
      } else {
        if (hiitMethod == 'sequentially') {
          if (exercise.split(',').length - 2 == state.exercise &&
              int.parse(set) == state.set) {
            flutterTts.speak('Done');
            context.read<TimerBloc>().add(const TimerCompleted());
          } else {
            context.read<TimerBloc>().add(TimerStartedRestTime(
                duration: int.parse(time), timeBegin: int.parse(time)));
          }
          context.read<VisibilityBloc>().add(PracticeCardioEvent(
              exercise.split(',').length - 1, int.parse(set), 0));
        } else {
          if (state.setDrop == 0) {
            context.read<TimerBloc>().add(TimerStartedRestTime(
                duration: int.parse(time), timeBegin: int.parse(time)));

            context.read<VisibilityBloc>().add(PracticeCardioEvent(
                exercise.split(':')[state.setDrop].split(',').length - 1,
                int.parse(set),
                exercise.split(':').length));
          } else {
            if (exercise.split(':')[state.setDrop - 1].split(',').length - 2 ==
                    state.exercise &&
                int.parse(set) == state.set &&
                exercise.split(':').length == state.setDrop) {
              context.read<TimerBloc>().add(const TimerCompleted());
            } else {
              context.read<TimerBloc>().add(TimerStartedRestTime(
                  duration: int.parse(time), timeBegin: int.parse(time)));
            }

            context.read<VisibilityBloc>().add(PracticeCardioEvent(
                exercise.split(':')[state.setDrop - 1].split(',').length - 1,
                int.parse(set),
                exercise.split(':').length));
          }
        }
      }
    }
  }
}

Widget widgetHistoryCardio(String hiitMethod, Map<String, Object?> history,
    List<Map<String, Object?>> historyRepTime, String cardioMethod) {
  return hiitMethod == 'group'
      ? ListView.builder(
          itemCount: history[AppString.exercise].toString().split(':').length,
          itemBuilder: (context, index) {
            List<Map<String, Object?>> listRepAndTime = [];
            for (int i = 0; i < historyRepTime.length; i++) {
              if (historyRepTime[i][AppString.level].toString() ==
                  (index + 1).toString()) {
                listRepAndTime.add(historyRepTime[i]);
              }
            }
            return Column(
              children: [
                Text('Level ${index + 1}:',
                    style: AppAnother.textStyleDefault(AppDimens.dimens_20,
                        AppFont.semiBold, AppColor.blackColor)),
                const SizedBox(
                  height: AppDimens.dimens_10,
                ),
                SizedBox(
                  height: getHeight(listRepAndTime),
                  child: ListView.builder(
                    itemCount: listRepAndTime.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, indexSet) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Set ${listRepAndTime[indexSet][AppString.setNumber]}:',
                              style: AppAnother.textStyleDefault(
                                  AppDimens.dimens_20,
                                  AppFont.semiBold,
                                  AppColor.blackColor)),
                          const SizedBox(
                            height: AppDimens.dimens_10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                  'Time : ${MethodReused.formatTime((listRepAndTime[indexSet][AppString.exercise].toString().split(',').length - 1) * int.parse(history[AppString.time].toString()))}'),
                              Text('Rest time: ${history[AppString.restTime]}')
                            ],
                          ),
                          SizedBox(
                            height: (listRepAndTime[indexSet]
                                            [AppString.exercise]
                                        .toString()
                                        .split(',')
                                        .length -
                                    1) *
                                AppDimens.dimens_20,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listRepAndTime[indexSet]
                                          [AppString.exercise]
                                      .toString()
                                      .split(',')
                                      .length -
                                  1,
                              itemBuilder: (context, indexExercise) {
                                return Center(
                                  child: SizedBox(
                                    height: AppDimens.dimens_20,
                                    child: Text(listRepAndTime[indexSet]
                                            [AppString.exercise]
                                        .toString()
                                        .split(',')[indexExercise]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          },
        )
      : (cardioMethod != '' &&
              AppAnother.lissCardioExercise.indexWhere((element) =>
                      element == history[AppString.exercise].toString()) >=
                  0)
          ? Text(history[AppString.exercise].toString(),
              style: AppAnother.textStyleDefault(
                  AppDimens.dimens_20, AppFont.medium, AppColor.blackColor))
          : ListView.builder(
              itemCount: historyRepTime.length,
              itemBuilder: ((context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Set ${historyRepTime[index][AppString.setNumber]}',
                            style: AppAnother.textStyleDefault(
                                AppDimens.dimens_20,
                                AppFont.semiBold,
                                AppColor.blackColor)),
                        const SizedBox(
                          height: AppDimens.dimens_10,
                        ),
                        Row(
                          mainAxisAlignment:
                              cardioMethod == AppString.lissCardio
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                'Time : ${MethodReused.formatTime(((historyRepTime[index][AppString.exercise].toString().split(',').length - 1) * int.parse(history[AppString.time].toString())) + (cardioMethod == AppString.lissCardio ? 0 : ((historyRepTime[index][AppString.exercise].toString().split(',').length - 1) * int.parse(history[AppString.restTime].toString()))))} '),
                            cardioMethod == AppString.lissCardio
                                ? Container()
                                : Text(
                                    'Rest time: ${history[AppString.restTime]}')
                          ],
                        ),
                        SizedBox(
                          height: AppDimens.dimens_20 *
                              (historyRepTime[index][AppString.exercise]
                                      .toString()
                                      .split(',')
                                      .length -
                                  1),
                          child: ListView.builder(
                            itemCount: historyRepTime[index][AppString.exercise]
                                    .toString()
                                    .split(',')
                                    .length -
                                1,
                            itemBuilder: (context, indexExercise) {
                              return Center(
                                child: SizedBox(
                                  height: AppDimens.dimens_20,
                                  child: Text(historyRepTime[index]
                                          [AppString.exercise]
                                      .toString()
                                      .split(',')[indexExercise]),
                                ),
                              );
                            },
                          ),
                        ),
                      ])));
}

Widget widgetHistoryAnother(
    Map<String, Object?> history,
    List<Map<String, dynamic>> historyRepTime,
    TextEditingController controller,
    TextEditingController editingController,
    GlobalKey<FormState> key) {
  return ListView.builder(
    itemCount: history[AppString.exercise].toString().split(',').length - 1,
    itemBuilder: (context, index) {
      List<Map<String, Object?>> exerciseRepAndTime = [];
      for (var item in historyRepTime) {
        if (history[AppString.exercise].toString().split(',')[index] ==
            item[AppString.exercise].toString()) {
          exerciseRepAndTime.add(item);
        }
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            history[AppString.exercise].toString().split(',')[index],
            style: AppAnother.textStyleDefault(
                AppDimens.dimens_20, AppFont.medium, AppColor.blackColor),
          ),
          SizedBox(
            height: exerciseRepAndTime.length * AppDimens.dimens_100,
            child: ListView.builder(
              itemCount: exerciseRepAndTime.length,
              // physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, indexRepAndTime) {
                return exerciseRepAndTime[indexRepAndTime][AppString.exercise]
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
                    : exerciseRepAndTime[indexRepAndTime][AppString.exercise]
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
    },
  );
}

////// Add Method
Future<void> addWeightAndRepMEthod(
    BuildContext context,
    TextEditingController editingController,
    bool superset,
    String exercise,
    String currentExercise,
    int exerciseIndex,
    TextEditingController controller,
    HistoryBloc historyBloc,
    int setDrop,
    String set) async {
  List<Map<String, Object?>> listRepAndTime =
      await DbHelper().getData(AppString.repTimeTable);

  String weight = '';
  // ignore: use_build_context_synchronously
  if (context.read<HomePageBloc>().isMetric) {
    weight = editingController.text;
  } else {
    weight = (double.parse(editingController.text) * 0.45359237).toString();
  }
  if (superset) {
    int index =
        exercise.split(',')[exerciseIndex].split(':')[1].split(';').indexWhere(
              (element) => element == currentExercise,
            );
    if (listRepAndTime.last[AppString.rep] == '0') {
      String weightValue = '';
      String rep = '';
      for (int i = 0;
          i <
              exercise
                      .split(',')[exerciseIndex]
                      .split(':')[1]
                      .split(';')
                      .length -
                  1;
          i++) {
        if (i == index) {
          weightValue = '$weightValue$weight:';
          rep = '$rep${controller.text}:';
        } else {
          weightValue = '$weightValue:';
          rep = '$rep:';
        }
      }
      await DbHistoryRepository().updateSetAndTime(
          rep, weightValue, listRepAndTime.last[AppString.id] as int);
    } else {
      String weightValue = '';
      String rep = '';
      for (int i = 0;
          i <
              exercise
                      .split(',')[exerciseIndex]
                      .split(':')[1]
                      .split(';')
                      .length -
                  1;
          i++) {
        if (i == index) {
          weightValue = '$weightValue$weight:';
          rep = '$rep${controller.text}:';
        } else {
          weightValue =
              '$weightValue${listRepAndTime.last[AppString.weight].toString().split(':')[i]}:';
          rep =
              '$rep${listRepAndTime.last[AppString.rep].toString().split(':')[i]}:';
        }
      }
      await DbHistoryRepository().updateSetAndTime(
          rep, weightValue, listRepAndTime.last[AppString.id] as int);
    }
  } else {
    if (exercise.split(',')[exerciseIndex].contains('Dropset')) {
      if (listRepAndTime.last[AppString.rep] == '0') {
        String weightValue = '';
        String rep = '';
        for (int i = 0;
            i < int.parse(set.split(',')[exerciseIndex].split(':')[1]) + 1;
            i++) {
          if (i == setDrop - 1) {
            weightValue = '$weightValue$weight:';
            rep = '$rep${controller.text}:';
          } else {
            weightValue = '$weightValue:';
            rep = '$rep:';
          }
        }

        await DbHistoryRepository().updateSetAndTime(
            rep, weightValue, listRepAndTime.last[AppString.id] as int);
      } else {
        String weightValue = '';
        String rep = '';
        for (int i = 0;
            i < int.parse(set.split(',')[exerciseIndex].split(':')[1]) + 1;
            i++) {
          if (i == setDrop - 1) {
            weightValue = '$weightValue$weight:';
            rep = '$rep${controller.text}:';
          } else {
            weightValue =
                '$weightValue${listRepAndTime.last[AppString.weight].toString().split(':')[i]}:';
            rep =
                '$rep${listRepAndTime.last[AppString.rep].toString().split(':')[i]}:';
          }
        }

        await DbHistoryRepository().updateSetAndTime(
            rep, weightValue, listRepAndTime.last[AppString.id] as int);
      }
    } else {
      await DbHistoryRepository().updateSetAndTime(
          controller.text, weight, listRepAndTime.last[AppString.id] as int);
    }
  }
  historyBloc.add(UpdateData());
  controller.clear();
  editingController.clear();
  FocusManager.instance.primaryFocus?.unfocus();
}

String nextExercise(String exercise, int indexExercise, int indexSet, int set,
    int indexLevel, String hiitMethod, bool restTime) {
  if (hiitMethod == 'group') {
    if (indexLevel == 0) {
      return exercise.split(':')[0].split(',')[0];
    } else {
      if (indexExercise ==
          exercise.split(':')[indexLevel - 1].split(',').length - 2) {
        if (indexSet == set) {
          if (indexLevel < exercise.split(':').length) {
            return restTime
                ? exercise.split(':')[indexLevel].split(',')[0]
                : 'Next rest time';
          } else {
            return '';
          }
        } else {
          return restTime
              ? exercise.split(':')[indexLevel - 1].split(',')[0]
              : 'Next rest time';
        }
      } else {
        return exercise
            .split(':')[indexLevel - 01]
            .split(',')[indexExercise + 1];
      }
    }
  } else {
    if (indexExercise == exercise.split(',').length - 2) {
      if (indexSet < set) {
        return exercise.split(',')[0];
      } else {
        return 'stretching after exercise';
      }
    } else {
      return exercise.split(',')[indexExercise + 1];
    }
  }
}

bool visibilityNextAfterExercise(
    String hiitMethod,
    List<String> listExercise,
    List<String> listSet,
    String exercise,
    String set,
    String cariodMethod,
    int indexExercise,
    int indexSet,
    int indexLevel) {
  return exercise.contains(',')
      ? hiitMethod == ''
          ? (listExercise[indexExercise].contains('Dropset')
              ? (indexLevel ==
                      int.parse(listSet[indexExercise].split(':')[1]) + 1 &&
                  int.parse(listSet[indexExercise].split(':')[0]) == indexSet &&
                  indexExercise == listExercise.length - 2)
              : ((int.parse(listSet[indexExercise])) == indexSet &&
                  indexExercise == listExercise.length - 2))
          : hiitMethod == 'group'
              ? (exercise
                              .split(':')[indexLevel == 0 ? 0 : indexLevel - 1]
                              .split(',')
                              .length -
                          2 ==
                      indexExercise &&
                  int.parse(set) == indexSet &&
                  exercise.split(':').length == indexLevel)
              : (exercise.split(',').length - 2 == indexExercise &&
                  int.parse(set) == indexSet)
      : false;
}

bool visibilityNextExercise(
    String hiitMethod,
    List<String> listExercise,
    List<String> listSet,
    String exercise,
    String set,
    int indexExercise,
    int indexSet,
    int indexLevel,
    String cardioMethod) {
  return exercise.contains(',')
      ? hiitMethod == ''
          ? ((listExercise[indexExercise].contains('Dropset')
                      ? int.parse(listSet[indexExercise].split(':')[0])
                      : int.parse(listSet[indexExercise])) ==
                  indexSet &&
              indexExercise < listExercise.length - 2)
          : hiitMethod == 'group'
              ? !(exercise
                              .split(':')[indexLevel == 0 ? 0 : indexLevel - 1]
                              .split(',')
                              .length -
                          2 ==
                      indexExercise &&
                  int.parse(set) == indexSet &&
                  exercise.split(':').length == indexLevel)
              : !(exercise.split(',').length - 2 == indexExercise &&
                  int.parse(set) == indexSet)
      : false;
}

double getHeight(
  List<Map<String, Object?>> list,
) {
  double height = 0;
  for (int i = 0; i < list.length; i++) {
    height = height +
        AppDimens.dimens_60 +
        AppDimens.dimens_20 *
            (list[i][AppString.exercise].toString().split(',').length - 1);
  }
  return height;
}
