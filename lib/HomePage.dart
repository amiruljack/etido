import 'package:etido/AddNewTodosPage.dart';
import 'package:etido/Models/Todos.dart';
import 'package:etido/Services/TodosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("To-Do-List"),
      ),
      body: Consumer<TodosProvider>(
        builder: (context, provider, child) =>
            ListView.builder(
                itemCount: provider.getTodos.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(provider.getTodos[index].title),
                    )) ??
            Container(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewTodosPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
