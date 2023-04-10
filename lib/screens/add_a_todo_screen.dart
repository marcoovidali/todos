import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todos/utils/navigator_util.dart';
import 'package:todos/utils/todos_util.dart';

class AddATodoScreen extends StatefulWidget {
  const AddATodoScreen({super.key});

  @override
  State<AddATodoScreen> createState() => _AddATodoScreenState();
}

class _AddATodoScreenState extends State<AddATodoScreen> {
  GlobalKey<FormState> todoFormKey = GlobalKey();
  final TextEditingController newTodo = TextEditingController();

  GlobalKey<FormState> getTodoFormKey() {
    return todoFormKey;
  }

  TextEditingController getNewTodo() {
    return newTodo;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    double todoFormWidth = size.width < 600 ? double.infinity : 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: NavBar(
        theme: theme,
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
                  getTodoFormKey: getTodoFormKey,
                  getNewTodo: getNewTodo,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Confirm(
        getNewTodo: getNewTodo,
        getTodoFormKey: getTodoFormKey,
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
                onPressed: () => NavigatorUtil().home(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: theme.colorScheme.primary,
                )));
}

class TodoForm extends StatelessWidget {
  final Function getTodoFormKey;
  final Function getNewTodo;

  const TodoForm(
      {super.key, required this.getTodoFormKey, required this.getNewTodo});

  String? validate(value) {
    if (value == null || value.isEmpty) {
      return 'please enter some text';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: getTodoFormKey(),
      child: TextFormField(
        controller: getNewTodo(),
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
  final Function getTodoFormKey;
  final Function getNewTodo;

  const Confirm(
      {super.key, required this.getNewTodo, required this.getTodoFormKey});

  @override
  State<Confirm> createState() => _ConfirmState(getTodoFormKey, getNewTodo);
}

class _ConfirmState extends State<Confirm> {
  final Function getTodoFormKey;
  final Function getNewTodo;

  bool isLoading = false;

  _ConfirmState(this.getTodoFormKey, this.getNewTodo);

  void addTodo() async {
    if (getTodoFormKey().currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await TodosUtil().add(getNewTodo().text);
      NavigatorUtil().home(context);
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
