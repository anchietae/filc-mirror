// ignore_for_file: avoid_print

import 'package:firka/wear_main.dart';
import 'package:flutter/material.dart';

class WearHomeScreen extends StatelessWidget {
  final WearAppInitialization data;
  const WearHomeScreen(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
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
              'Home',
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
