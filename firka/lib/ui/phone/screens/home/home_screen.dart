import 'package:firka/ui/phone/pages/home/home_grades.dart';
import 'package:firka/ui/phone/pages/home/home_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firka/main.dart';
import 'package:firka/ui/phone/widgets/bottom_nav_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:shake_gesture/shake_gesture.dart';
import '../../pages/home/home_timetable.dart';
import '../debug/debug_screen.dart';
import 'package:majesticons_flutter/majesticons_flutter.dart';
import 'package:firka/ui/model/colors.dart'; 
import '../../pages/extras/extras.dart';

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
      systemNavigationBarColor: appColors.background,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    _updateSystemUI(); // Update system UI on every build, to compensate for the android system being dumb

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
      backgroundColor: appColors.background,
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
                        child: HomeSubPage(page, data),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          appColors.background,
                          appColors.background.withValues(alpha: 0.0),
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
                              if (page != ActiveHomePage.home) HapticFeedback.lightImpact();

                              setState(() {
                                page = ActiveHomePage.home;
                              });
                            },
                            page == ActiveHomePage.home
                              ? Majesticon.homeSolid
                              : Majesticon.homeLine,
                            AppLocalizations.of(context)!.home,
                            page == ActiveHomePage.home
                              ? appColors.accent
                              : appColors.secondary,
                            appColors.textPrimary
                          ),
                          // Grades Button
                          BottomNavIcon(() {
                              if (page != ActiveHomePage.grades) HapticFeedback.lightImpact();

                              setState(() {
                                page = ActiveHomePage.grades;
                              });
                            },
                            page == ActiveHomePage.grades
                              ? Majesticon.bookmarkSolid
                              : Majesticon.bookmarkLine,
                            AppLocalizations.of(context)!.grades,
                            page == ActiveHomePage.grades
                              ? appColors.accent
                              : appColors.secondary,
                            appColors.textPrimary
                          ),
                          // Timetable Button
                          BottomNavIcon(() {
                              if (page != ActiveHomePage.timetable) HapticFeedback.lightImpact();

                              setState(() {
                                page = ActiveHomePage.timetable;
                              });
                            },
                            page == ActiveHomePage.timetable
                              ? Majesticon.calendarSolid
                              : Majesticon.calendarLine,
                            AppLocalizations.of(context)!.timetable,
                            page == ActiveHomePage.timetable
                              ? appColors.accent
                              : appColors.secondary,
                            appColors.textPrimary
                          ),
                          // More Button
                          BottomNavIcon(() {
                              HapticFeedback.lightImpact();
                              showExtrasBottomSheet(context);
                            },
                            Majesticon.globeEarthLine,
                            AppLocalizations.of(context)!.other,
                            appColors.secondary,
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