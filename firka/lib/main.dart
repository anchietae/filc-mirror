import 'dart:async';
import 'dart:io';

import 'package:firka/helpers/api/client/kreta_client.dart';
import 'package:firka/helpers/db/models/generic_cache_model.dart';
import 'package:firka/helpers/db/models/timetable_cache_model.dart';
import 'package:firka/helpers/db/models/token_model.dart';
import 'package:firka/helpers/extensions.dart';
import 'package:firka/screens/phone/debug/debug_screen.dart';
import 'package:firka/screens/phone/home/home_screen.dart';
import 'package:firka/screens/phone/login/login_screen.dart';
import 'package:firka/screens/phone/wear_login/wear_login_screen.dart';
import 'package:firka/wear_main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

import 'pages/error/error_page.dart';

late Isar isar;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppInitialization {
  final Isar isar;
  late KretaClient client;
  final int tokenCount;
  final watch = WatchConnectivity();
  bool hasWatchListener = false;

  AppInitialization({
    required this.isar,
    required this.tokenCount,
  });
}

Future<Isar> initDB() async {
  final dir = await getApplicationDocumentsDirectory();

  return Isar.open(
    [TokenModelSchema, GenericCacheModelSchema, TimetableCacheModelSchema],
    inspector: true,
    directory: dir.path,
  );
}

Future<AppInitialization> initializeApp() async {
  final isar = await initDB();
  final tokenCount = await isar.tokenModels.count();

  if (kDebugMode) {
    print('Token count: $tokenCount');
  }

  var init = AppInitialization(
    isar: isar,
    tokenCount: tokenCount,
  );

  resetOldTimeTableCache(isar);

  // TODO: Account selection
  if (tokenCount > 0) {
    init.client = KretaClient(
      (await isar.tokenModels.where().findFirst())!,
      isar
    );
  }

  return init;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const platform = MethodChannel('firka.app/main');
  if (Platform.isAndroid) {
    var isWear = (await platform.invokeMethod("isWear")) as bool;

    if (isWear) {
      wearMain(platform);
      return;
    }
  }

  //TODO: fix the error handling currently not pushing to the error page
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Run App Initialization
    runApp(InitializationScreen());

  }, (error, stackTrace) {
    debugPrint('Caught error: $error');
    debugPrint('Stack trace: $stackTrace');

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => ErrorPage(exception: error.toString()),
      ),
    );
  });
}

class InitializationScreen extends StatelessWidget {
  InitializationScreen({super.key});

  // Place to store the initialization future
  final Future<AppInitialization> _initialization = initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppInitialization>(
      future: _initialization,
      builder: (context, snapshot) {
        // Check if initialization is complete
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // Handle initialization error
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text(
                    'Error initializing app: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            );
          }

          // Initialization successful, determine which screen to show
          Widget screen;

          assert(snapshot.data != null);
          var data = snapshot.data!;
          var watch = data.watch;

          if (!data.hasWatchListener) {
            data.hasWatchListener = true;

            watch.messageStream.listen((e) {
              var msg = e.entries.toMap();

              debugPrint("[Watch -> Phone]: ${msg["id"]}");

              switch (msg["id"]) {
                case "ping":
                  debugPrint("[Phone -> Watch]: pong");
                  watch.sendMessage({
                    "id": "pong"
                  });
                  navigatorKey.currentState?.push(
                    MaterialPageRoute(
                      builder: (context) => WearLoginScreen(data),
                    ),
                  );
              }
            });
          }

          if (snapshot.data!.tokenCount == 0) {
            screen = LoginScreen(data);
          } else {
            screen = HomeScreen(data);
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
              '/login': (context) => LoginScreen(data),
              '/debug': (context) => DebugScreen(data),
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
