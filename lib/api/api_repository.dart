import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_yay_rider_driver/api/api_constant.dart';
import 'package:flutter_yay_rider_driver/api/resource.dart';
import '../api/api_response.dart';
import '../core/utils/network_utils.dart';

/// Base class to manage API calls with consistent loading, success, and error states.
/// It emits [Resource] to represent different states like loading, success, error, etc.
abstract class ApiRepository {
  const ApiRepository();

  /// Wraps an API call into a Stream that emits loading, success, and error states.
  /// Usage: callApi(() => apiClient.getSomething());
  Stream<Resource<ApiResponse<T>>> callApi<T>({
    required Future<ApiResponse<T>> Function() apiCall,
  }) async* {
    // Emit loading state (start)
    yield const Loading(true);

    // Check internet connectivity
    final isConnected = await NetworkUtils.isConnectedToInternet();
    if (!isConnected) {
      // Emit loading false before error
      yield const Loading(false);
      yield const NoInternetError("No Internet Connection");
      return;
    }

    // Make the actual API call
    final response = await apiCall();

    // Emit loading state (stop)
    yield const Loading(false);

    // Handle success case
    if (response.status) {
      yield Success(response);
    } else {
      switch (response.code) {
        case ApiConstant.API_NO_INTERNET_EXCEPTION:
          print("else: NoInternetError");
          yield NoInternetError(response.message);
          break;

        case ApiConstant.API_AUTH_EXCEPTION:
          print("else: AuthException");
          yield AuthException(data: response, message: response.message);
          break;

        default:
          if (response.jsonData != null) {
            print("else: ErrorWithData");
            yield ErrorWithData(response, response.message);
          } else {
            print("else: Error");
            yield Error(response.message);
          }
      }
    }
  }

  /// Converts Dio-specific errors into custom [Resource] types.
  Resource<ApiResponse<T>> _handleDioException<T>(DioException e) {
    // Handle no internet at the socket level
    if (e.type == DioExceptionType.connectionError ||
        e.error is SocketException) {
      return const NoInternetError("No Internet Connection");
    }

    // Try extracting a useful message from Dio response
    final statusCode = e.response?.statusCode;
    final message = e.response?.data['message']?.toString() ??
        e.message ??
        "Something went wrong";

    // Handle specific error codes
    if (statusCode == 401) {
      // Unauthorized (force logout)
      return AuthException(message: message);
    } else if (statusCode == 426) {
      // App needs to be updated
      return ForceUpdate(message: message);
    }

    // Handle all other errors
    return Error("Something went wrong: $message");
  }
}
