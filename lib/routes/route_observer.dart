import 'package:flutter/cupertino.dart';

class RouteObserverService extends RouteObserver<PageRoute<dynamic>> {
  static String? currentRoute;

  void _sendScreenView(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? currentScreenName = route.settings.name;
    final String? previousScreenName = route.settings.name;
    currentRoute = currentScreenName;
    print(
        '👉 User visited: $currentScreenName screen from: $previousScreenName');
    // Send to Firebase Analytics here if needed
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _sendScreenView(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _sendScreenView(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) _sendScreenView(newRoute, oldRoute);
  }
}
