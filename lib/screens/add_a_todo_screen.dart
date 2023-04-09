import 'package:flutter/material.dart';

class AddATodoScreen extends StatefulWidget {
  const AddATodoScreen({super.key});

  @override
  State<AddATodoScreen> createState() => _AddATodoScreenState();
}

class _AddATodoScreenState extends State<AddATodoScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    double todoFormWidth = size.width < 600 ? double.infinity : 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NavBar(theme: theme),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: todoFormWidth,
                child: const TodoForm(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Confirm(
        theme: theme,
      ),
    );
  }
}

class NavBar extends AppBar {
  final ThemeData theme;

  NavBar({super.key, required this.theme})
      : super(
            leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                  color: theme.colorScheme.primary,
                )));
}

class TodoForm extends StatelessWidget {
  const TodoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'write a new todo',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}

class Confirm extends FloatingActionButton {
  final ThemeData theme;

  Confirm({super.key, required this.theme})
      : super(
          onPressed: () {},
          backgroundColor: theme.colorScheme.primary,
          child: Icon(
            Icons.check,
            color: theme.colorScheme.onPrimary,
          ),
        );
}
