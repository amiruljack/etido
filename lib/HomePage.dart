import 'package:etido/Services/TodosProvider.dart';
import 'package:etido/TodoListTile.dart';
import 'package:etido/TodosEditorPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("To-Do-List"),
      ),
      body: Consumer<TodosProvider>(
        builder: (context, provider, child) => ListView(
          controller: _scrollController,
          children: [
            ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: provider.getTodos.length,
                itemBuilder: (context, index) => ListTile(
                      title: TodoListTile(todoObject: provider.getTodos[index]),
                    )),
            const SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const TodosEditorPage(
                    todoObject: null,
                  )));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
