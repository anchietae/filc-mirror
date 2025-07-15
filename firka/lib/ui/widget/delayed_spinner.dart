import 'dart:async';

import 'package:flutter/material.dart';

class DelayedSpinner extends StatefulWidget {
  const DelayedSpinner({super.key});

  @override
  State<DelayedSpinner> createState() => _DelayedSpinner();
}

class _DelayedSpinner extends State<DelayedSpinner> {
  Timer? timer;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();

    timer = Timer(Duration(milliseconds: 50), () {
      setState(() {
        showSpinner = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSpinner) {
      return CircularProgressIndicator();
    } else {
      return SizedBox();
    }
  }

  @override
  void dispose() {
    super.dispose();

    timer?.cancel();
  }
}
