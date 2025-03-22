import 'dart:async';

import 'package:firka/helpers/db/models/token_model.dart';
import 'package:firka/pages/error/wear_error_page.dart';
import 'package:firka/screens/wear/home/home_screen.dart';
import 'package:firka/screens/wear/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wear_plus/wear_plus.dart';

late Isar isar;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class WearAppInitialization {
  final Isar isar;
  final int tokenCount;

  WearAppInitialization({
    required this.isar,
    required this.tokenCount
  });
}

Future<Isar> initDB() async {
  final dir = await getApplicationDocumentsDirectory();

  return Isar.open(
    [TokenModelSchema],
    inspector: true,
    directory: dir.path,
  );
}

Future<WearAppInitialization> initializeApp() async {
  final isar = await initDB();

  var init = WearAppInitialization(
    isar: isar,
    tokenCount: await isar.tokenModels.count()
  );

  return init;
}

void wearMain(MethodChannel platform) async {
  // TODO: fix the error handling currently not pushing to the error page
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Run App Initialization
    runApp(WearInitializationScreen());

  }, (error, stackTrace) {
    debugPrint('Caught error: $error');
    debugPrint('Stack trace: $stackTrace');

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => WearErrorPage(exception: error.toString()),
      ),
    );
  });
}

class WearInitializationScreen extends StatelessWidget {
  WearInitializationScreen({super.key});

  // Place to store the initialization future
  final Future<WearAppInitialization> _initialization = initializeApp();

  @override
  Widget build(BuildContext context) {
    /*
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: WatchShape(
            builder: (context, shape, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Shape: ${shape == WearShape.round ? 'round' : 'square'}',
                  ),
                  child!,
                ],
              );
            },
            child: SizedBox(),
          ),
        ),
      ),
    );
     */

    return FutureBuilder<WearAppInitialization>(
      future: _initialization,
      builder: (context, snapshot) {
        // Check if initialization is complete
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // Handle initialization error

            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: WatchShape(
                    builder: (context, shape, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Error initializing app: ${snapshot.error}',
                            style: TextStyle(color: Colors.red),
                          ),
                          child!,
                        ],
                      );
                    },
                    child: SizedBox(),
                  ),
                ),
              ),
            );
          }

          // Initialization successful, determine which screen to show
          Widget screen;

          assert(snapshot.data != null);
          var data = snapshot.data!;

          if (snapshot.data!.tokenCount == 0) {
            screen = WearLoginScreen(data);
          } else {
            screen = WearHomeScreen(data);
          }

          return MaterialApp(
            title: 'Firka',
            navigatorKey: navigatorKey, // Use the global navigator key
            theme: ThemeData(
              primarySwatch: Colors.lightGreen,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: screen,
            routes: {
              '/login': (context) => WearLoginScreen(data),
              '/home': (context) => WearHomeScreen(data)
            },
          );
        }

        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: const Color(0xFF7CA021),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
