enum TodosStatus {
  inProgress,
  complete,
}

class TodoObject {
  String todoID;
  String title;
  int startDate;
  int endDate;
  TodosStatus todosStatus;

  TodoObject({required this.todoID, required this.title, required this.startDate, required this.endDate, required this.todosStatus});

  Map<String, dynamic> toMap() {
    return {
      "todoID": todoID,
      "title": title,
      "startDate": startDate,
      "endDate": title,
      "todosStatus": todosStatus.index,
    };
  }

  static TodoObject fromMap(var json) {
    return TodoObject(
      todoID: json["todoID"],
      title: json["title"],
      startDate: int.tryParse(json["startDate"].toString()) ?? 0,
      endDate: int.tryParse(json["endDate"].toString()) ?? 0,
      todosStatus: TodosStatus.values[int.tryParse(json["todosStatus"].toString()) ?? 0],
    );
  }
}
