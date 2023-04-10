import 'package:flutter/material.dart';
import 'package:todos/utils/navigator_util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: AddATodo(
        theme: theme,
      ),
    );
  }
}

class AddATodo extends StatelessWidget {
  const AddATodo({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => NavigatorUtil().addATodo(context, theme),
      backgroundColor: theme.colorScheme.primary,
      child: Icon(
        Icons.add,
        color: theme.colorScheme.onPrimary,
      ),
    );
  }
}
