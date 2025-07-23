import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_yay_rider_driver/core/utils/app_methods.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/utils/app_logger.dart';
import '../../repository/local_repository/local_repository.dart';
import '../api_constant.dart';

class ApiInterceptor extends InterceptorsWrapper {

  LocalRepository? localRepository;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!await InternetConnectionChecker.instance.hasConnection) {
      final customResponse = {
        'status': false,
        'message': "No internet found",
        'code': 503
      };
      return handler.resolve(
        Response(
          requestOptions: options,
          data: customResponse,
          statusCode: 200,
        ),
      );
    }
    final method = options.method;
    final uri = options.uri;
    final data = options.data;

    String? token = await localRepository?.getData(LocalStorageKey.bearerToken);
    /*String? lang =
        await localRepository?.getData(LocalStorageKey.languageCode) ??
            AppTranslation.fallbackLocale.languageCode;*/

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = "Bearer $token";
    }

    options.headers['Accept'] = 'application/json';
    options.headers['KEY'] = ApiConstant.key;
    options.headers['App-Type'] = ApiConstant.deviceType;
    options.headers['App-Version'] = AppMethods.getAppVersion();
    // options.headers['Accept-Language'] = lang;

    try {
      logger.log(
        "✈️ REQUEST[$method] => PATH: $uri \n Token:${options.headers} \n DATA: ${jsonEncode(data)}",
      );
    } catch (e) {
      logger.log(
        "✈️ REQUEST[$method] => PATH: $uri \n Token: ${options.headers} \n DATA: ${data.files.toString()}",
      );
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;
    final data = jsonEncode(response.data);
    logger.log("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data");

    // Todo: Handle session expired
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    String message = 'Something went wrong. Please try again later.';
    final statusCode = err.response?.statusCode!;
    final uri = err.requestOptions.path;
    var data = "";
    try {
      data = jsonEncode(err.response!.data);
    } catch (e) {
      logger.log(e.toString());
    }
    logger.log("⚠️ ERROR[$statusCode] => PATH: $uri\n DATA: $data");

    // Handle DioError types (network-related)
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      message = 'Request timed out. Please check your internet connection.';
      return handler.resolve(
        Response(
          data: {
            'status': false,
            'message': message,
            'code': 408
          },
          statusCode: 408,
          requestOptions: err.requestOptions,
        ),
      );
    }

    // Unauthenticated
    if (err.type == DioExceptionType.badCertificate) {
      message = 'SSL certificate issue detected.';
    } else if (err.type == DioExceptionType.badResponse) {
      // Handle HTTP errors
      switch (statusCode) {
        case 400:
          message = _extractMessage(data, defaultMsg: 'Bad Request');
          break;
        case 401:
        case 403:
          /*await get_x.Get.find<LocalRepository>().clearLoginData();*/

          // todo: navigation after logout
          return handler.resolve(
            Response(
              data: {'status': false, 'message': message, 'code': statusCode},
              statusCode: statusCode,
              requestOptions: err.requestOptions,
            ),
          );
        case 404:
          message = 'The requested resource was not found.';
          break;
        case 422:
          message = _extractMessage(data, defaultMsg: 'Validation failed');
          break;
        case 429:
          message = 'Too many requests. Please slow down.';
          break;
        case 500:
          message = 'Internal server error.';
          break;
        case 502:
          message = 'Bad Gateway.';
          break;
        case 503:
          message = 'Service unavailable.';
          break;
        case 504:
          message = 'Gateway timeout.';
          break;
        default:
          message = _extractMessage(data, defaultMsg: message);
      }
    } else if (err.type == DioExceptionType.cancel) {
      message = 'Request was cancelled.';
    } else if (err.type == DioExceptionType.unknown) {
      message = 'Unexpected error occurred.';
    }
    print("statusCode $statusCode");
    return handler.resolve(
      Response(
        data: {'status': false, 'message': message, 'code': statusCode},
        statusCode: statusCode ?? 500,
        requestOptions: err.requestOptions,
      ),
    );
  }

  String _extractMessage(dynamic responseData, {required String defaultMsg}) {
    try {
      if (responseData is Map) {
        if (responseData.containsKey('message')) {
          return responseData['message'].toString();
        } else if (responseData.containsKey('error')) {
          return responseData['error'].toString();
        } else if (responseData.containsKey('errors')) {
          final errors = responseData['errors'];
          if (errors is Map && errors.isNotEmpty) {
            final firstError = errors.values.first;
            if (firstError is List && firstError.isNotEmpty) {
              return firstError.first.toString();
            } else {
              return firstError.toString();
            }
          }
        }
      }
    } catch (_) {}
    return defaultMsg;
  }
}
