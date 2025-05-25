import 'package:flutter/cupertino.dart';

import '../../../../main.dart';

class HomeGradesScreen extends StatefulWidget {
  final AppInitialization data;
  const HomeGradesScreen(this.data, {super.key});

  @override
  State<HomeGradesScreen> createState() => _HomeGradesScreen(data);
}

class _HomeGradesScreen extends State<HomeGradesScreen> {
  final AppInitialization data;
  _HomeGradesScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Text("Grades");
  }

}