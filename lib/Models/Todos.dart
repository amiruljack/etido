import 'package:intl/intl.dart';

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

  String get startDateString => formatDateTime(DateTime.fromMillisecondsSinceEpoch(startDate));

  String get endDateString => formatDateTime(DateTime.fromMillisecondsSinceEpoch(endDate));

  int get _timeLeft => endDate - DateTime.now().millisecondsSinceEpoch;

  String get timeLeftString {
    final duration = Duration(milliseconds: _timeLeft);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    if (hours == 0 && minutes == 0 && seconds <= 0 || _timeLeft < 0) {
      return "Times up";
    } else if (hours == 0 && minutes == 0) {
      return "${seconds.toString().padLeft(2, '0')}sec";
    } else if (hours == 0) {
      return "${minutes.toString().padLeft(2, '0')}min ${seconds.toString().padLeft(2, '0')}sec";
    }
    return '$hours hrs ${minutes.toString().padLeft(2, '0')} min';
  }

  String get todosStatusString => todosStatus == TodosStatus.complete ? "Completed" : "In Progress";

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

  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat.yMd();
    return formatter.format(dateTime);
  }
}
