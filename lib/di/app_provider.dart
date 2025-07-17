import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_yay_rider_driver/api/api_client/api_client.dart';
import 'package:flutter_yay_rider_driver/repository/local_repository/local_repository.dart';
import 'package:flutter_yay_rider_driver/repository/remote_repository/remote_repository.dart';
import 'package:flutter_yay_rider_driver/routes/navigation_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_provider.g.dart';

@Riverpod(keepAlive: true)
NavigationService navigationService(Ref ref) {
  return NavigationService();
}

@Riverpod(keepAlive: true)
LocalRepository localRepository(Ref ref) {
  return LocalRepositoryImpl();
}

@Riverpod(keepAlive: true)
RemoteRepository remoteRepository(Ref ref) {
  return RemoteRepositoryImpl(ApiClient.initApiClient());
}