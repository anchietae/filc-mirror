// ignore_for_file: avoid_print

import 'package:firka/main.dart';
import 'package:flutter/material.dart';

class DebugScreen extends StatelessWidget {
  final AppInitialization data;
  const DebugScreen(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Debug Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                throw 0 / 0;
              },
              child: const Text('Throw Exception'),
            ),
            ElevatedButton(
              onPressed: () async {
                print("getStudent(): ${await data.client.getStudent()}");
              },
              child: const Text('getStudent()'),
            ),
            ElevatedButton(
              onPressed: () async {
                print("getNoticeBoard(): ${await data.client.getNoticeBoard()}");
              },
              child: const Text('getNoticeBoard()'),
            ),
            ElevatedButton(
              onPressed: () async {
                print("getGrades(): ${await data.client.getGrades()}");
              },
              child: const Text('getGrades()'),
            ),
            ElevatedButton(
              onPressed: () async {
                var now = DateTime.now();

                var start = now.subtract(Duration(days: 14));
                var end = now.add(Duration(days: 7));

                print("getLessons(): ${await data.client.getTimeTable(start, end)}");
              },
              child: const Text('getLessons()'),
            ),
          ],
        ),
      ),
    );
  }
}
