import 'package:etido/Models/Todos.dart';
import 'package:etido/Services/EtidoAnalyticsService.dart';
import 'package:etido/Services/TodosProvider.dart';
import 'package:etido/TodosEditorPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

/// A widget that displays a to do object in a tile format. The tile displays
/// the to do's title, start date, end date, time left, status and a checkbox
/// to mark the to do as complete.
class TodoListTile extends StatelessWidget {
  final TodoObject todoObject;

  TodoListTile({super.key, required this.todoObject});

  TextStyle dateTextStyle = const TextStyle(
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Provider.of<TodosProvider>(context, listen: false).removeTodo(todoObject.todoID);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  EtidoAnalyticsService.logEvent(etidoEvent: EtidoEvents.buttonClick, parameters: {"buttonName": "TodoListTile"});
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TodosEditorPage(
                            todoObject: todoObject,
                          )));
                },
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    todoObject.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("Start Date"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                todoObject.startDateString,
                                style: dateTextStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("End Date"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                todoObject.endDateString,
                                style: dateTextStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text("Time Left"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                todoObject.timeLeftString,
                                style: dateTextStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0)),
                  color: Color(0xFFe7e3cf),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Status: ",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              todoObject.todosStatusString,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Tick if completed"),
                            CheckboxTheme(
                              data: CheckboxThemeData(
                                fillColor: MaterialStateProperty.all(Colors.white),
                                checkColor: MaterialStateProperty.all(Colors.blue),
                                overlayColor: MaterialStateProperty.all(Colors.white),
                              ),
                              child: Checkbox(
                                value: todoObject.todosStatus == TodosStatus.complete,
                                onChanged: (newValue) {
                                  if (newValue == true) {
                                    EtidoAnalyticsService.logEvent(etidoEvent: EtidoEvents.changeStatusToComplete, parameters: todoObject.toMap());
                                  } else {
                                    EtidoAnalyticsService.logEvent(etidoEvent: EtidoEvents.changeStatusToInProgress, parameters: todoObject.toMap());
                                  }
                                  todoObject.todosStatus = (newValue ?? false) ? TodosStatus.complete : TodosStatus.inProgress;
                                  Provider.of<TodosProvider>(context, listen: false).setTodo(todoObject);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
