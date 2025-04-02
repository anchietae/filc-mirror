// ignore_for_file: avoid_print

import 'package:firka/wear_main.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class WearLoginScreen extends StatelessWidget {
  final WearAppInitialization data;
  const WearLoginScreen(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    WakelockPlus.disable();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stub'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
