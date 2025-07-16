import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_yay_rider_driver/routes/navigation_service.dart';
import 'core/themes/app_theme.dart';
import 'core/utils/app_logger.dart';
import 'core/widgets/app_annotated_region.dart';
import 'constants/global.dart';
import 'repository/local_repository/local_repository.dart';

class MyApp extends StatefulWidget {
  /// Root App View
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // getAppLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppAnnotatedRegion(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler
              .noScaling, // keep font size as it is (not as per system fonts)
        ),
        child: MaterialApp(
          title: Global.appName,
          theme: AppTheme.appTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppPages.generateRoute,
          navigatorKey: NavigationService.navigatorKey,
        ),
      ),
    );
  }
}
