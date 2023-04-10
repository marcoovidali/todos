import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todos/utils/navigator_util.dart';
import 'package:todos/utils/todo_util.dart';

class AddATodoScreen extends StatefulWidget {
  const AddATodoScreen({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<AddATodoScreen> createState() => _AddATodoScreenState();
}

class _AddATodoScreenState extends State<AddATodoScreen> {
  late final Size size = MediaQuery.of(context).size;
  late final double todoFormWidth = size.width < 600 ? double.infinity : 600;
  final GlobalKey<FormState> todoFormKey = GlobalKey();
  final TextEditingController newTodo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NavBar(
        theme: widget.theme,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: todoFormWidth,
                child: TodoForm(
                  todoFormKey: todoFormKey,
                  newTodo: newTodo,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Confirm(
        todoFormKey: todoFormKey,
        newTodo: newTodo,
        theme: widget.theme,
      ),
    );
  }
}

class NavBar extends AppBar {
  final ThemeData theme;
  final BuildContext context;

  NavBar({super.key, required this.theme, required this.context})
      : super(
          leading: IconButton(
            onPressed: () => NavigatorUtil().home(context, theme),
            icon: Icon(
              Icons.arrow_back,
              color: theme.colorScheme.primary,
            ),
          ),
        );
}

class TodoForm extends StatelessWidget {
  const TodoForm({
    super.key,
    required this.todoFormKey,
    required this.newTodo,
  });

  final GlobalKey<FormState> todoFormKey;
  final TextEditingController newTodo;

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
  const Confirm({
    super.key,
    required this.todoFormKey,
    required this.newTodo,
    required this.theme,
  });

  final GlobalKey<FormState> todoFormKey;
  final TextEditingController newTodo;
  final ThemeData theme;

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  bool isLoading = false;

  void addTodo() async {
    if (widget.todoFormKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await TodoUtil().add(widget.newTodo.text);
      if (!mounted) return;
      NavigatorUtil().home(context, widget.theme);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: addTodo,
      backgroundColor: widget.theme.colorScheme.primary,
      child: isLoading
          ? SpinKitPulse(
              color: widget.theme.colorScheme.onPrimary,
              size: 24,
            )
          : Icon(
              Icons.check,
              color: widget.theme.colorScheme.onPrimary,
            ),
    );
  }
}
