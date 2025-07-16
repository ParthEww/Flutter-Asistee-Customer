import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();

  // App Orientation
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  initDependencies().whenComplete(
    () {
      ProviderScope(child: const MyApp());
    },
  );
}

/// Initialize dependencies
Future<void> initDependencies() async {
  /// Local storage
  /*Get.put<LocalRepository>(LocalRepositoryImpl());

  /// Internet service
  Get.put(InternetService());

  /// Dio API Client
  Get.put<RemoteRepository>(
    RemoteRepositoryImpl(ApiClient.initApiClient(baseUrl: ApiConstant.baseUrl)),
  );

  Get.put(AppLocalizationController());*/
}
