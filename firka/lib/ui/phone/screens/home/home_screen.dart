import 'package:firka/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:shake_gesture/shake_gesture.dart';
import '../debug/debug_screen.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';
import 'package:firka/ui/phone/model/colors.dart' as appcolors;

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          page = ActiveHomePage.home;
                                        });
                                      },
                                      icon: page == ActiveHomePage.home
                                          ? Majesticon(Majesticon.homeSolid,
                                                  color:
                                                      appcolors.colors.accent)
                                              .build(context)
                                          : Majesticon(Majesticon.homeLine,
                                                  color: appcolors
                                                      .colors.accentSecondary)
                                              .build(context)),
                                  Text("Fasz mhh nyami")
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      page = ActiveHomePage.grades;
                                    });
                                  },
                                  icon: page == ActiveHomePage.grades
                                      ? Majesticon(Majesticon.bookmarkSolid,
                                              color: appcolors.colors.accent)
                                          .build(context)
                                      : Majesticon(Majesticon.bookmarkLine,
                                              color: appcolors
                                                  .colors.accentSecondary)
                                          .build(context)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      page = ActiveHomePage.timetable;
                                    });
                                  },
                                  icon: page == ActiveHomePage.timetable
                                      ? Majesticon(Majesticon.calendarSolid,
                                              color: appcolors.colors.accent)
                                          .build(context)
                                      : Majesticon(Majesticon.calendarLine,
                                              color: appcolors
                                                  .colors.accentSecondary)
                                          .build(context)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      page = ActiveHomePage.other;
                                    });
                                  },
                                  icon: page == ActiveHomePage.other
                                      ? Majesticon(Majesticon.homeSolid,
                                              color: appcolors.colors.accent)
                                          .build(context)
                                      : Majesticon(Majesticon.homeLine,
                                              color: appcolors
                                                  .colors.accentSecondary)
                                          .build(context)),
                            ],
                          ),
                        ),
                      ],
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
