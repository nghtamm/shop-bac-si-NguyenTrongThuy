import 'package:go_router/go_router.dart';

extension GoRouterExtension on GoRouter {
  void popUntil(String path) {
    while (routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        path) {
      if (!canPop()) {
        return;
      }
      pop();
    }
  }
}
