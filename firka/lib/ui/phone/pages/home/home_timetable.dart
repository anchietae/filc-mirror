import 'package:flutter/material.dart';

import '../../../../main.dart';

class HomeTimetableScreen extends StatefulWidget {
  final AppInitialization data;
  const HomeTimetableScreen(this.data, {super.key});

  @override
  State<HomeTimetableScreen> createState() => _HomeTimetableScreen(data);
}

class _HomeTimetableScreen extends State<HomeTimetableScreen> {
  final AppInitialization data;
  _HomeTimetableScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Text("Timetable");
  }

}