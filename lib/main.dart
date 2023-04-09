import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'todos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        fontFamily: 'Quicksand',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
