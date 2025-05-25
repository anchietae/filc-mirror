import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Text("Main");
  }

}