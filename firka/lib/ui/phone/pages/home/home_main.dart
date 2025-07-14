import 'dart:async';

import 'package:firka/helpers/extensions.dart';
import 'package:firka/ui/phone/widgets/home_main_starting_soon.dart';
import 'package:firka/ui/phone/widgets/lesson_small.dart';
import 'package:firka/ui/widget/delayed_spinner.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/api/model/student.dart';
import '../../../../helpers/api/model/timetable.dart';
import '../../../../helpers/debug_helper.dart';
import '../../../../main.dart';
import '../../widgets/home_main_welcome.dart';

class HomeMainScreen extends StatefulWidget {
  final AppInitialization data;

  const HomeMainScreen(this.data, {super.key});

  @override
  State<HomeMainScreen> createState() => _HomeMainScreen(data);
}

class _HomeMainScreen extends State<HomeMainScreen> {
  final AppInitialization data;

  _HomeMainScreen(this.data);

  DateTime now = timeNow();
  List<Lesson>? lessons;
  Student? student;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    now = timeNow();
    var midnight = now.getMidnight();
    (() async {
      var resp = await data.client.getTimeTable(
          midnight, midnight.add(Duration(hours: 23, minutes: 59)));

      setState(() {
        lessons = resp.response!;
      });
    })();
    (() async {
      var resp = await data.client.getStudent();

      setState(() {
        student = resp.response!;
      });
    })();

    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      setState(() {
        now = timeNow();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Widget startingSoon = SizedBox();
    Widget nextClass = SizedBox();

    if (lessons != null &&
        lessons!.isNotEmpty &&
        now.isBefore(lessons!.first.start)) {
      startingSoon = StartingSoonWidget(now, lessons!);
    }
    if (lessons != null && lessons!.isNotEmpty) {
      var nextLessons = lessons!.where((lesson) => lesson.start.isAfter(now));
      if (nextLessons.isNotEmpty) nextClass = LessonSmallWidget(nextLessons.first);
    }

    if (student != null && lessons != null) {
      return Flexible(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 24.0,
            right: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WelcomeWidget(now, student!, lessons!),
              SizedBox(height: 48),
              startingSoon,
              nextClass
            ],
          ),
        ),
      );
      /*return Column(
        children: [HomeMainWelcome(now, student!, lessons!), SizedBox()],
      );*/
    } else {
      return DelayedSpinner();
    }
  }
}
