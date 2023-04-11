import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todos/utils/todo_util.dart';

import '../utils/navigator_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ThemeData theme = Theme.of(context);
  late final Size size = MediaQuery.of(context).size;
  late final double todosWidth = size.width < 600 ? double.infinity : 600;

  void deleteTodo(String docId) {
    TodoUtil().delete(docId);

    // updating future builder
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: TodoUtil().getAll(),
      builder: (
        context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
      ) {
        return Scaffold(
          backgroundColor: theme.colorScheme.primaryContainer,
          body: Column(
            children: [
              if (snapshot.hasData)
                if (snapshot.data!.docs.isEmpty)
                  AddATodoToGetStarted(theme: theme)
                else
                  Todos(
                    theme: theme,
                    docs: snapshot.data!.docs,
                    deleteTodo: deleteTodo,
                  )
              else
                Loading(theme: theme)
            ],
          ),
          floatingActionButton: AddATodo(theme: theme),
        );
      },
    );
  }
}

class AddATodoToGetStarted extends StatelessWidget {
  const AddATodoToGetStarted({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'add a todo to get started',
              style: TextStyle(
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Todos extends StatefulWidget {
  const Todos({
    super.key,
    required this.theme,
    required this.docs,
    required this.deleteTodo,
  });

  final ThemeData theme;
  final List<DocumentSnapshot> docs;
  final Function deleteTodo;

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            for (final doc in widget.docs)
              Card(
                color: widget.theme.colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          doc['text'],
                          style: TextStyle(
                            color: widget.theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      IconButton(
                        color: widget.theme.colorScheme.onPrimary,
                        iconSize: 19,
                        onPressed: () => widget.deleteTodo(doc.id),
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SpinKitPulse(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
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
