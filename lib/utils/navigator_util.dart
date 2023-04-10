import 'package:flutter/material.dart';
import 'package:todos/screens/add_a_todo_screen.dart';
import 'package:todos/screens/home_screen.dart';

class NavigatorUtil {
  void addATodo(BuildContext context, ThemeData theme) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddATodoScreen(
          theme: theme,
        ),
      ),
    );
  }

  void home(BuildContext context, ThemeData theme) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
