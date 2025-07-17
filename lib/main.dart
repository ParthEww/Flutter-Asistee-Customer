import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_yay_rider_driver/routes/route_observer.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();

  // App Orientation
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await initDependencies(); // <-- Wait for dependencies to initialize

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// Initialize dependencies
Future<void> initDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  final RouteObserverService routeObserverService = RouteObserverService();
}
