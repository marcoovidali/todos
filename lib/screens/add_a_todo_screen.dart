import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todos/utils/todos_util.dart';

final todoFormKey = GlobalKey<FormState>();
final TextEditingController newTodo = TextEditingController();

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
      floatingActionButton: const Confirm(),
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

  String? validate(value) {
    if (value == null || value.isEmpty) {
      return 'please enter some text';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: todoFormKey,
      child: TextFormField(
        controller: newTodo,
        validator: (value) => validate(value),
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

class Confirm extends StatefulWidget {
  const Confirm({super.key});

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  bool isLoading = false;

  void addTodo() async {
    if (todoFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await TodosUtil().add(newTodo.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return FloatingActionButton(
      onPressed: addTodo,
      backgroundColor: theme.colorScheme.primary,
      child: isLoading
          ? SpinKitPulse(
              color: theme.colorScheme.onPrimary,
              size: 24,
            )
          : Icon(
              Icons.check,
              color: theme.colorScheme.onPrimary,
            ),
    );
  }
}
