import 'package:etido/Models/RandomID.dart';
import 'package:etido/Models/Todos.dart';
import 'package:etido/Services/EtidoAnalyticsService.dart';
import 'package:etido/Services/TodosProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A form widget to add or edit a to-do item.
class TodosEditorPage extends StatefulWidget {
  const TodosEditorPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return TodosEditorPageState();
  }
}

/// The [State] object for the [TodosEditorPage] widget.
class TodosEditorPageState extends State<TodosEditorPage> {
  DateTime? startDate;
  DateTime? endDate;
  TextEditingController titleTextController = TextEditingController();

  /// Shows the date picker dialog and returns the selected date.
  Future<DateTime?> _selectDate(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: startDate != null ? startDate! : DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  /// Checks if the form is completed or not.
  bool isFormCompleted() {
    return titleTextController.text.isNotEmpty && startDate != null && endDate != null;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        TodoObject? todoObject = ModalRoute.of(context)!.settings.arguments as TodoObject?;
        if (todoObject != null) {
          EtidoAnalyticsService.logEvent(etidoEvent: EtidoEvents.pageLoad, parameters: {"pageName": "TodosEditorPage", "todoPageLoadType": "Edit todo"});
          titleTextController.text = todoObject.title;
          startDate = DateTime.fromMillisecondsSinceEpoch(todoObject.startDate);
          endDate = DateTime.fromMillisecondsSinceEpoch(todoObject.endDate);
        } else {
          EtidoAnalyticsService.logEvent(etidoEvent: EtidoEvents.pageLoad, parameters: {"pageName": "TodosEditorPage", "todoPageLoadType": "New todo"});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoObject? todoObject = ModalRoute.of(context)?.settings.arguments as TodoObject?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new To-Do"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: Text("To-Do Title"),
              ),
              TextFormField(
                maxLines: null, // enables multiline input
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Please key in your to do title here",
                ),
                controller: titleTextController,
                onChanged: (text) {
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: Text("Start Date"),
              ),
              InkWell(
                onTap: () {
                  EtidoAnalyticsService.logEvent(etidoEvent: EtidoEvents.buttonClick, parameters: {"buttonName": "Select start date"});
                  _selectDate(context).then((value) {
                    if (value != null) {
                      setState(() {
                        startDate = value;
                        if (startDate != null && endDate != null) {
                          if (startDate!.millisecondsSinceEpoch > endDate!.millisecondsSinceEpoch) {
                            startDate = null;
                          }
                        }
                      });
                    }
                  });
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(startDate == null ? "Select a date" : TodoObject.formatDateTime(startDate!)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: Text("End Date"),
              ),
              InkWell(
                onTap: () {
                  EtidoAnalyticsService.logEvent(etidoEvent: EtidoEvents.buttonClick, parameters: {"buttonName": "Select end date"});
                  _selectDate(context).then((value) {
                    if (value != null) {
                      setState(() {
                        endDate = value;
                      });
                    }
                  });
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(endDate == null ? "Select a date" : TodoObject.formatDateTime(endDate!)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              EtidoAnalyticsService.logEvent(etidoEvent: EtidoEvents.buttonClick, parameters: {"buttonName": "Save todo"});
              Provider.of<TodosProvider>(context, listen: false).setTodo(TodoObject(
                todoID: todoObject?.todoID ?? RandomID.generateRandomID(),
                title: titleTextController.text,
                startDate: startDate!.millisecondsSinceEpoch,
                endDate: endDate!.millisecondsSinceEpoch,
                todosStatus: TodosStatus.inProgress,
              ));
              Navigator.of(context).pop();
            },
            child: Container(
              height: 60,
              color: isFormCompleted() ? Colors.black : Colors.grey,
              child: Center(
                child: Text(
                  todoObject == null ? "Create Now" : "Save",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
