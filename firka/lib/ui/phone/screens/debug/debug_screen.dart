// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:firka/helpers/profile_picture.dart';
import 'package:firka/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DebugScreen extends StatefulWidget {
  final AppInitialization data;

  const DebugScreen(this.data, {super.key});

  @override
  State<DebugScreen> createState() => _DebugScreen(data);
}

class _DebugScreen extends State<DebugScreen> {
  final AppInitialization data;
  _DebugScreen(this.data);

  late ImagePicker _picker;
  Uint8List? profilePictureData;

  @override
  void initState() {
    super.initState();

    _picker = ImagePicker();
    profilePictureData = data.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    Widget profilePicture = SizedBox(height: 0);
    if (profilePictureData != null) {
      profilePicture = Image.memory(profilePictureData!);
    }

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
            profilePicture,
            ElevatedButton(
              onPressed: () async {
                await pickProfilePicture(data, _picker);

                setState(() {
                  if (data.profilePicture != null) {
                    profilePictureData = data.profilePicture;
                  }
                });
              },
              child: const Text('Pick pfp'),
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
                print(
                    "getNoticeBoard(): ${await data.client.getNoticeBoard()}");
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

                print(
                    "getLessons(): ${await data.client.getTimeTable(start, end)}");
              },
              child: const Text('getLessons()'),
            ),
            ElevatedButton(
              onPressed: () async {
                print("getOmissions(): ${await data.client.getOmissions()}");
              },
              child: const Text('getOmissions()'),
            ),
          ],
        ),
      ),
    );
  }
}
