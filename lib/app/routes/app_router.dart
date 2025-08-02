import 'package:flutter/material.dart';
import '../presentation/screens/add_edit_todo_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/settings_screen.dart';
import '../presentation/screens/stats_screen.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String addEditTodoRoute = '/add_edit_todo';
  static const String settingsRoute = '/settings';
  static const String statsRoute = '/stats';

  // This is a simple placeholder to demonstrate the routing structure.
  // A real implementation would use a navigator or a routing package.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
       return MaterialPageRoute(builder: (_) => const HomeScreen());
      case addEditTodoRoute:
       return MaterialPageRoute(builder: (_) => const AddEditTodoScreen());
      case settingsRoute:
       return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case statsRoute:
       return MaterialPageRoute(builder: (_) => const StatsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Error: Unknown route'))));
    }
  }
}