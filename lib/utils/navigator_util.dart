import 'package:flutter/material.dart';
import 'package:todos/screens/add_a_todo_screen.dart';
import 'package:todos/screens/home_screen.dart';

class NavigatorUtil {
  addATodo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddATodoScreen(),
      ),
    );
  }

  home(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
