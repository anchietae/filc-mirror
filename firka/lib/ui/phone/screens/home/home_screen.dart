import 'package:firka/main.dart';
import 'package:firka/ui/model/style.dart';
import 'package:firka/ui/phone/pages/home/home_grades.dart';
import 'package:firka/ui/phone/pages/home/home_main.dart';
import 'package:firka/ui/phone/widgets/bottom_nav_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';
import 'package:shake_gesture/shake_gesture.dart';

import '../../pages/extras/extras.dart';
import '../../pages/home/home_timetable.dart';
import '../debug/debug_screen.dart';

class HomeScreen extends StatefulWidget {
  final AppInitialization data;

  const HomeScreen(this.data, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState(data);
}

enum ActiveHomePage { home, grades, timetable }

class _HomeScreenState extends State<HomeScreen> {
  final AppInitialization data;

  _HomeScreenState(this.data);

  ActiveHomePage page = ActiveHomePage.home;
  late ActiveHomePage previousPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSystemUI();
    });

    // TODO: move this to a button inside the settings page when it's implemented
    if (kDebugMode) {
      ShakeGesture.registerCallback(onShake: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DebugScreen(data)));
      });
    }
  }

  void _updateSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: appStyle.colors.background,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    _updateSystemUI(); // Update system UI on every build, to compensate for the android system being dumb

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: appStyle.colors.background,
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
                      children: [HomeSubPage(page, data)],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            appStyle.colors.background,
                            appStyle.colors.background.withValues(alpha: 0.0),
                          ],
                          stops: const [0.0, 1.0],
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Home Button
                            BottomNavIcon(() {
                              if (page != ActiveHomePage.home) {
                                HapticFeedback.lightImpact();
                              }

                              setState(() {
                                previousPage = page;
                                page = ActiveHomePage.home;
                              });
                            },
                                page == ActiveHomePage.home
                                    ? Majesticon.homeSolid
                                    : Majesticon.homeLine,
                                AppLocalizations.of(context)!.home,
                                page == ActiveHomePage.home
                                    ? appStyle.colors.accent
                                    : appStyle.colors.secondary,
                                appStyle.colors.textPrimary),
                            // Grades Button
                            BottomNavIcon(() {
                              if (page != ActiveHomePage.grades) {
                                HapticFeedback.lightImpact();
                              }

                              setState(() {
                                previousPage = page;
                                page = ActiveHomePage.grades;
                              });
                            },
                                page == ActiveHomePage.grades
                                    ? Majesticon.bookmarkSolid
                                    : Majesticon.bookmarkLine,
                                AppLocalizations.of(context)!.grades,
                                page == ActiveHomePage.grades
                                    ? appStyle.colors.accent
                                    : appStyle.colors.secondary,
                                appStyle.colors.textPrimary),
                            // Timetable Button
                            BottomNavIcon(() {
                              if (page != ActiveHomePage.timetable) {
                                HapticFeedback.lightImpact();
                              }

                              setState(() {
                                previousPage = page;
                                page = ActiveHomePage.timetable;
                              });
                            },
                                page == ActiveHomePage.timetable
                                    ? Majesticon.calendarSolid
                                    : Majesticon.calendarLine,
                                AppLocalizations.of(context)!.timetable,
                                page == ActiveHomePage.timetable
                                    ? appStyle.colors.accent
                                    : appStyle.colors.secondary,
                                appStyle.colors.textPrimary),
                            // More Button
                            BottomNavIcon(() {
                              HapticFeedback.lightImpact();
                              showExtrasBottomSheet(context);
                            },
                                Majesticon.globeEarthLine,
                                AppLocalizations.of(context)!.other,
                                appStyle.colors.secondary,
                                appStyle.colors.textPrimary),
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
      ),
      onPopInvokedWithResult: (_, __) => {
        if (page != previousPage)
          {
            setState(() {
              page = previousPage;
            })
          }
      },
    );
  }
}

class HomeSubPage extends StatelessWidget {
  final ActiveHomePage page;
  final AppInitialization data;

  const HomeSubPage(this.page, this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case ActiveHomePage.home:
        return HomeMainScreen(data);
      case ActiveHomePage.grades:
        return HomeGradesScreen(data);
      case ActiveHomePage.timetable:
        return HomeTimetableScreen(data);
    }
  }
}
