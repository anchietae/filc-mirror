import 'package:firka/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:shake_gesture/shake_gesture.dart';
import '../../screens/debug/debug_screen.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';

class HomeScreen extends StatefulWidget {
  final AppInitialization data;
  const HomeScreen(this.data, {super.key});

  @override
  // ignore: no_logic_in_create_state, will fix this later
  State<HomeScreen> createState() => _HomeScreenState(data);
}

class _HomeScreenState extends State<HomeScreen> {
  final AppInitialization data;
  _HomeScreenState(this.data);

  @override
  void initState() {
    super.initState();
    // TODO: move this to a button inside the settings page when it's implemented
    if (kDebugMode) {
      ShakeGesture.registerCallback(onShake: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DebugScreen(data)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xFFDAE4F7),
    ));
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [Row()],
        )
      ],
    ));
  }
}
