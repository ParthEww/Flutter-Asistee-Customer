/// A generic abstract class that represents the state of a network/API response.
///
/// It helps you track different states like:
/// - Loading
/// - Success
/// - Error
/// - No Internet
/// - Auth Exception
/// - Force Update
///
/// This is similar to Kotlin's sealed class pattern for managing API state in a clean way.
abstract class Resource<T> {
  /// The actual data returned from the API (if any).
  final T? data;

  /// An optional message (used in error or informational states).
  final String? message;

  /// Whether a loader should be shown on the UI.
  final bool? isLoadingShow;

  const Resource({this.data, this.message, this.isLoadingShow});
}

/// Represents a successful API call with the returned data.
class Success<T> extends Resource<T> {
  const Success(T data) : super(data: data);
}

/// Represents a loading state. Used to show/hide loaders on the UI.
class Loading<T> extends Resource<T> {
  /// [isLoading] - true to show loader, false to hide.
  const Loading(bool isLoading) : super(isLoadingShow: isLoading);
}

/// Represents a generic error (e.g., API failed, unknown error).
class Error<T> extends Resource<T> {
  /// [message] - error message to display.
  const Error(String message) : super(message: message);
}

/// Represents a 401 Unauthorized response from the API.
/// You can use this to log out the user and redirect to login.
class AuthException<T> extends Resource<T> {
  const AuthException({super.data, super.message});
}

/// Represents a 426 Force Update response from the API.
/// You can use this to show a dialog to update the app.
class ForceUpdate<T> extends Resource<T> {
  const ForceUpdate({super.data, super.message});
}

/// Represents an error where the API responded with a payload (like validation errors).
class ErrorWithData<T> extends Resource<T> {
  const ErrorWithData(T data, String message)
      : super(data: data, message: message);
}

/// Represents a failure due to lack of internet connectivity.
class NoInternetError<T> extends Resource<T> {
  const NoInternetError(String message) : super(message: message);
}
