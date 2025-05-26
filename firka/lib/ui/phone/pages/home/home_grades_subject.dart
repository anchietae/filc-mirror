import 'package:firka/helpers/ui/stateless_async_widget.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class HomeGradesSubjectScreen extends StatelessAsyncWidget {
  final AppInitialization data;
  final String subPageUid;

  const HomeGradesSubjectScreen(this.data, this.subPageUid, {super.key});

  @override
  Future<Widget> buildAsync(BuildContext context) async {
    return Text(subPageUid);
  }
}
