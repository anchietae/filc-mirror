import 'dart:async';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firka/helpers/api/model/timetable.dart';
import 'package:firka/helpers/extensions.dart';
import 'package:firka/wear_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zear_plus/wear_plus.dart';

import '../../../model/colors.dart';
import '../../widgets/circular_progress_indicator.dart';

class WearHomeScreen extends StatefulWidget {
  final WearAppInitialization data;
  const WearHomeScreen(this.data, {super.key});

  @override
  State<WearHomeScreen> createState() => _WearHomeScreenState(data);
}

class _WearHomeScreenState extends State<WearHomeScreen> {
  final WearAppInitialization data;
  _WearHomeScreenState(this.data);

  List<Lesson> today = List.empty(growable: true);
  String apiError = "";
  DateTime now = DateTime.now();
  Timer? timer;
  bool init = false;
  WearMode mode = WearMode.active;
  final platform = MethodChannel('firka.app/main');

  bool disposed = false;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();

    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() {
        now = DateTime.now();
      });
    });
    initStateAsync();
  }

  Future<void> initStateAsync() async {
    var kreta = data.client;

    now = DateTime.now();
    var todayStart = now.subtract(Duration(hours: now.hour, minutes: now.minute
        , seconds: now.second));
    var todayEnd = todayStart.add(Duration(hours: 23, minutes: 59));
    var classes = await kreta.getTimeTable(todayStart, todayEnd);

    if (disposed) return;
    setState(() {
      if (classes.response != null) today = classes.response!;
      if (classes.statusCode != 200) {
        apiError = "Unexpected status : ${classes.statusCode}";
      }
      if (classes.err != null) apiError = classes.err!;

      init = true;
    });
  }

  List<Widget> buildBody(BuildContext context, WearMode mode) {
    var body = List<Widget>.empty(growable: true);
    if (!init) {
      return body;
    }

    if (today.isEmpty && apiError != "") {
      body.add(Text(
        apiError,
        style: TextStyle(color: wearColors.textPrimary, fontSize: 18),
        textAlign: TextAlign.center,
      ));

      return body;
    }
    if (today.isEmpty) {
      body.add(Text(
        AppLocalizations.of(context)!.noClasses,
        style: TextStyle(color: wearColors.textPrimary, fontSize: 18),
        textAlign: TextAlign.center,
      ));

      platform.invokeMethod('activity_cancel');
      return body;
    }
    if (now.isAfter(today.last.end)) {
      body.add(Text(
        AppLocalizations.of(context)!.noMoreClasses,
        style: TextStyle(color: wearColors.textPrimary, fontSize: 18),
        textAlign: TextAlign.center,
      ));

      platform.invokeMethod('activity_cancel');
      return body;
    }
    if (now.isBefore(today.first.start)) {
      var untilFirst = today.first.start.difference(now);

      body.add(Text(
        AppLocalizations.of(context)!.firstIn(untilFirst.formatDuration()),
        style: TextStyle(color: wearColors.textPrimary, fontSize: 18),
        textAlign: TextAlign.center,
      ));

      platform.invokeMethod('activity_update');
      return body;
    }
    if (now.isAfter(today.first.start)
        && now.isBefore(today.last.end)) {
      Lesson? currentLesson;
      Lesson? lastLesson; // last as in the last lesson that you've been to
      Lesson? next;
      Duration? currentBreak;
      Duration? currentBreakProgress;
      for (int i = 0; i < today.length; i++) {
        var lesson = today[i];
        if (now.isAfter(lesson.start) && now.isBefore(lesson.end)) {
          currentLesson = lesson;
          break;
        }
        if (now.isAfter(lesson.end)) {
          if (lastLesson == null) {
            lastLesson = lesson;
            if (i < today.length) next = today[i+1];
          } else {
            if (lesson.end.isAfter(lastLesson.end)) {
              lastLesson = lesson;
              if (i < today.length) next = today[i+1];
            }
          }
        }
      }

      if (lastLesson != null && next != null) {
        currentBreak = next.start.difference(lastLesson.end);
        currentBreakProgress = next.start.difference(now);
      }

      if (currentLesson == null) {
        if (currentBreak == null) {
          throw Exception("currentBreak == null");
        }
        if (currentBreakProgress == null) {
          throw Exception("currentBreakProgress == null");
        }

        var minutes = currentBreakProgress.inMinutes + 1;

        body.add(CustomPaint(
            painter: CircularProgressPainter(
                progress: currentBreakProgress.inMilliseconds / currentBreak.inMilliseconds,
                screenSize: MediaQuery.of(context).size,
                strokeWidth: 4,
                color: wearColors.accent
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.breakTxt,
                      style: TextStyle(
                        color: wearColors.textPrimary,
                        fontSize: 20
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                    AppLocalizations.of(context)!.timeLeft(minutes),
                      style: TextStyle(
                        color: wearColors.textPrimary,
                        fontSize: 16
                      ),
                    ),
                  ),
                ]
            )
        ));

        platform.invokeMethod('activity_update');
        return body;
      } else {
        var duration = currentLesson.start.difference(currentLesson.end);
        var elapsed = currentLesson.start.difference(now);
        var timeLeft = currentLesson.end.difference(now);

        var minutes = timeLeft.inMinutes + 1;

        body.add(CustomPaint(
            painter: CircularProgressPainter(
                progress: elapsed.inMilliseconds / duration.inMilliseconds,
                screenSize: MediaQuery
                    .of(context)
                    .size,
                strokeWidth: 4,
                color: wearColors.accent
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      currentLesson.name,
                      style: TextStyle(
                          color: wearColors.textPrimary, fontSize: 20),
                    ),
                  ),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.timeLeft(minutes),
                      style: TextStyle(
                        color: wearColors.textPrimary,
                        fontSize: 16
                      ),
                    ),
                  ),
                ]
            )
        ));

        platform.invokeMethod('activity_update');
        return body;
      }
    }

    platform.invokeMethod('activity_cancel');
    throw Exception("unexpected state");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mode == WearMode.active
          ? wearColors.background
          : wearColors.backgroundAmoled,
      body: Center(
        child: Column(
          children: [
            WatchShape(builder: (context, shape, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  child!,
                ],
              );
            },
            child: AmbientMode(
              builder: (context, mode, child) {
                if (this.mode != mode) {
                  Timer(Duration(milliseconds: 100), () {
                    setState(() {
                      this.mode = mode;
                    });
                  });
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // children: buildBody(context, mode),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 75),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buildBody(context, mode),
                      )
                    ),
                  ],
                );
              },
            ),)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    disposed = true;
  }
}
