import 'dart:io';
import 'package:flutter/material.dart';
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
        child: GetMaterialApp(
          title: Global.appName,
          initialBinding: AppPages.initialBinding,
          initialRoute: AppPages.initialRoute,
          getPages: AppPages.pages,
          theme: AppTheme.appTheme,
          debugShowCheckedModeBanner: false,
          locale: appLocale,
          fallbackLocale: appLocale,
          translations: AppTranslation(),
          defaultTransition:
              Platform.isAndroid ? Transition.rightToLeft : Transition.native,
        ),
      ),
    );
  }
}
