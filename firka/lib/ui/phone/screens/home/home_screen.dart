import 'package:firka/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:shake_gesture/shake_gesture.dart';
import '../debug/debug_screen.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';
import 'package:firka/ui/model/colors.dart';

class HomeScreen extends StatefulWidget {
  final AppInitialization data;
  const HomeScreen(this.data, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState(data);
}

enum ActiveHomePage { home, grades, timetable, other }

class _HomeScreenState extends State<HomeScreen> {
  final AppInitialization data;
  _HomeScreenState(this.data);

  ActiveHomePage page = ActiveHomePage.home;

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
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Top Text"),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0.0),
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Home Button
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  page = ActiveHomePage.home;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    page == ActiveHomePage.home
                                        ? Majesticon(Majesticon.homeSolid,
                                                color: appColors.accent,
                                                size: 24)
                                            .build(context)
                                        : Majesticon(Majesticon.homeLine,
                                                color: appColors.secondary,
                                                size: 24)
                                            .build(context),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Kezdőlap',
                                      style: TextStyle(
                                        color: appColors.textPrimary,
                                        fontSize: 13,
                                        fontFamily: 'Figtree',
                                        fontVariations: const [
                                          FontVariation('wght', 640),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Grades Button
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  page = ActiveHomePage.grades;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    page == ActiveHomePage.grades
                                        ? Majesticon(Majesticon.bookmarkSolid,
                                                color: appColors.accent,
                                                size: 24)
                                            .build(context)
                                        : Majesticon(Majesticon.bookmarkLine,
                                                color: appColors.secondary,
                                                size: 24)
                                            .build(context),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Jegyek',
                                      style: TextStyle(
                                        color: appColors.textPrimary,
                                        fontSize: 13,
                                        fontFamily: 'Figtree',
                                        fontVariations: const [
                                          FontVariation('wght', 640),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Timetable Button
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  page = ActiveHomePage.timetable;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    page == ActiveHomePage.timetable
                                        ? Majesticon(Majesticon.calendarSolid,
                                                color: appColors.accent,
                                                size: 24)
                                            .build(context)
                                        : Majesticon(Majesticon.calendarLine,
                                                color: appColors.secondary,
                                                size: 24)
                                            .build(context),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Órarend',
                                      style: TextStyle(
                                        color: appColors.textPrimary,
                                        fontSize: 13,
                                        fontFamily: 'Figtree',
                                        fontVariations: const [
                                          FontVariation('wght', 640),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // More Button
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  page = ActiveHomePage.other;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    page == ActiveHomePage.other
                                        ? Majesticon(Majesticon.globeEarthSolid,
                                                color: appColors.accent,
                                                size: 24)
                                            .build(context)
                                        : Majesticon(Majesticon.globeEarthLine,
                                                color: appColors.secondary,
                                                size: 24)
                                            .build(context),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Több',
                                      style: TextStyle(
                                        color: appColors.textPrimary,
                                        fontSize: 13,
                                        fontFamily: 'Figtree',
                                        fontVariations: const [
                                          FontVariation('wght', 640),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
