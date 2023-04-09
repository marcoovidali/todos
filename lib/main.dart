import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/screens/add_a_todo_screen.dart';
import 'utils/firebase_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseUtil().connect();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'todos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          fontFamily: 'Quicksand',
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const AddATodoScreen(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {}
