import 'package:kovalingo/widgets/custom_navigator.dart';
import 'package:kovalingo/pages/main_menu.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login Screen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context, customNavigator(const MainMenu()));
            },
            child: const Text("Main Menu"),
          ),
        ],
      ),
    );
  }
}
