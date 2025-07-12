import 'dart:async';

import 'package:firka/helpers/extensions.dart';
import 'package:firka/ui/phone/widgets/home_main_welcome.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/api/model/student.dart';
import '../../../../helpers/api/model/timetable.dart';
import '../../../../main.dart';

class HomeMainScreen extends StatefulWidget {
  final AppInitialization data;

  const HomeMainScreen(this.data, {super.key});

  @override
  State<HomeMainScreen> createState() => _HomeMainScreen(data);
}

class _HomeMainScreen extends State<HomeMainScreen> {
  final AppInitialization data;

  _HomeMainScreen(this.data);

  DateTime now = DateTime.now();
  List<Lesson>? lessons;
  Student? student;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    now = DateTime.now();
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
        now = DateTime.now();
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
    if (student != null && lessons != null) {
      return HomeMainWelcome(now, student!, lessons!);
    } else {
      return SizedBox();
    }
  }
}
