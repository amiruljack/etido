import 'package:etido/HomePage.dart';
import 'package:etido/Services/TodosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(const MyApp());
}

final TodosProvider _todosProvider = TodosProvider();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
