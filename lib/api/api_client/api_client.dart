import 'package:dio/dio.dart';
import 'package:project_structure/api/model/response/userdata/user_data.dart';
import 'package:retrofit/retrofit.dart';

import '../api_constant.dart';
import '../api_response.dart';
import '../model/request/loginRequest.dart';
import '../model/response/init/init_data.dart';
import 'api_interceptor.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  /// initialize api client [SHOULD BE CALLED ONCE BEFORE USE `ApiClient`]
  static ApiClient initApiClient({String? baseUrl}) {
    Dio dio = Dio(
      BaseOptions(
          baseUrl: ApiConstant.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30)),
    )..interceptors.add(ApiInterceptor());

    // Pass the Dio instance with the base URL to ApiClient
    return ApiClient(dio);
  }

  @GET('${ApiConstant.init}/{version}/{device}')
  Future<ApiResponse<InitData>> initApi({
    @Path('version') String? version,
    @Path('device') String? device = ApiConstant.deviceType,
  });

  @POST(ApiConstant.login)
  Future<ApiResponse<UserData>> loginApi({
    @Body() required LoginRequest loginRequest,
  });

  @GET("get_language")
  Future<ApiResponse> getLanguages();
}
