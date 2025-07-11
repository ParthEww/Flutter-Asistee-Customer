import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class NetworkUtils {
  /// Checks for actual internet connection (not just network)
  static Future<bool> isConnectedToInternet() async {
    final List<ConnectivityResult> connectivityResults =
    await Connectivity().checkConnectivity();


    final hasNetwork = connectivityResults.contains(ConnectivityResult.mobile) ||
        connectivityResults.contains(ConnectivityResult.wifi) ||
        connectivityResults.contains(ConnectivityResult.ethernet);

    if (!hasNetwork) return false;

    return await _hasActiveInternet();
  }

  /// Actually pings a known server (Google)
  static Future<bool> _hasActiveInternet() async {
    try {
      final response = await http.get(
        Uri.parse("https://www.google.com"),
      ).timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}