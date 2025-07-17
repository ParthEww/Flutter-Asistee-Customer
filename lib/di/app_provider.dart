import 'package:flutter_yay_rider_driver/api/api_client/api_client.dart';
import 'package:flutter_yay_rider_driver/api/api_repository.dart';
import 'package:flutter_yay_rider_driver/repository/local_repository/local_repository.dart';
import 'package:flutter_yay_rider_driver/repository/remote_repository/remote_repository.dart';
import 'package:flutter_yay_rider_driver/routes/navigation_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_provider.g.dart';

@Riverpod(keepAlive: true)
NavigationService navigationService(NavigationServiceRef ref) {
  return NavigationService();
}

@Riverpod(keepAlive: true)
LocalRepository localRepository(LocalRepositoryRef ref) {
  return LocalRepositoryImpl();
}

@Riverpod(keepAlive: true)
RemoteRepository remoteRepository(RemoteRepositoryRef ref) {
  return RemoteRepositoryImpl(ApiClient.initApiClient());
}