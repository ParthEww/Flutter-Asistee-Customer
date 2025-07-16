part of 'remote_repository.dart';

class RemoteRepositoryImpl extends ApiRepository implements RemoteRepository {
  final ApiClient _apiClient;

  RemoteRepositoryImpl(this._apiClient);

  @override
  Stream<Resource<ApiResponse<InitData>>> initApi() async* {
    final packageInfo = await PackageInfo.fromPlatform();
    yield* callApi<InitData>(
      apiCall: () => _apiClient.initApi(version: packageInfo.version),
    );
  }

  @override
  Stream<Resource<ApiResponse<UserData>>> loginApi(
      LoginRequest loginRequest) async* {
    yield* callApi<UserData>(
      apiCall: () => _apiClient.loginApi(loginRequest: loginRequest),
    );
  }
}
