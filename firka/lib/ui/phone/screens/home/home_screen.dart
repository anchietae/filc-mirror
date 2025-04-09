import 'package:firka/main.dart';
import 'package:firka/ui/phone/widgets/bottom_nav_icon.dart';
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
                          BottomNavIcon(() {
                              setState(() {
                                page = ActiveHomePage.home;
                              });
                            },
                            page == ActiveHomePage.home
                              ? Majesticon.homeSolid
                              : Majesticon.homeLine,
                            "Kezdőlap",
                            page == ActiveHomePage.home
                              ? appColors.accent
                              : appColors.secondary,
                            appColors.textPrimary
                          ),
                          // Grades Button
                          BottomNavIcon(() {
                              setState(() {
                                page = ActiveHomePage.grades;
                              });
                            },
                            page == ActiveHomePage.grades
                              ? Majesticon.bookmarkSolid
                              : Majesticon.bookmarkLine,
                            "Jegyek",
                            page == ActiveHomePage.grades
                              ? appColors.accent
                              : appColors.secondary,
                            appColors.textPrimary
                          ),
                          // Timetable Button
                          BottomNavIcon(() {
                              setState(() {
                                page = ActiveHomePage.timetable;
                              });
                            },
                            page == ActiveHomePage.timetable
                              ? Majesticon.calendarSolid
                              : Majesticon.calendarLine,
                            "Órarend",
                            page == ActiveHomePage.timetable
                              ? appColors.accent
                              : appColors.secondary,
                            appColors.textPrimary
                          ),
                          // More Button
                          BottomNavIcon(() {
                              setState(() {
                                page = ActiveHomePage.other;
                              });
                            },
                            page == ActiveHomePage.other
                              ? Majesticon.globeEarthSolid
                              : Majesticon.globeEarthLine,
                            "Több",
                            page == ActiveHomePage.other
                              ? appColors.accent
                              : appColors.secondary,
                            appColors.textPrimary
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
