import 'package:etido/HomePage.dart';
import 'package:etido/Services/TodosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final TodosProvider _todosProvider = TodosProvider();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todosProvider.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TodosProvider>.value(value: _todosProvider),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.amber, titleTextStyle: TextStyle(color: Colors.black, fontSize: 20)),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.redAccent),
          ),
          home: MyHomePage(),
        ));
  }
}
