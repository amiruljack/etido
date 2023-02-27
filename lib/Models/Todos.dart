import 'package:intl/intl.dart';

enum TodosStatus {
  inProgress, // represents the task is in progress
  complete, // represents the task is complete
}

/// A class that represents a to do item.
class TodoObject {
  /// The ID of the to do item.
  String todoID;

  /// The title of the to do item.
  String title;

  /// The start date of the to do item, in milliseconds since the epoch.
  int startDate;

  /// The end date of the to do item, in milliseconds since the epoch.
  int endDate;

  /// The status of the to do item.
  TodosStatus todosStatus;

  /// Creates a new instance of [TodoObject].
  TodoObject({
    required this.todoID,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.todosStatus,
  });

  /// Returns a JSON-compatible representation of the [TodoObject].
  Map<String, dynamic> toMap() {
    return {
      "todoID": todoID,
      "title": title,
      "startDate": startDate,
      "endDate": endDate,
      "todosStatus": todosStatus.index,
    };
  }

  /// Creates a new instance of [TodoObject] from a JSON-compatible map.
  static TodoObject fromMap(Map<String, dynamic> json) {
    return TodoObject(
      todoID: json["todoID"],
      title: json["title"],
      startDate: int.tryParse(json["startDate"].toString()) ?? 0,
      endDate: int.tryParse(json["endDate"].toString()) ?? 0,
      todosStatus: TodosStatus.values[int.tryParse(json["todosStatus"].toString()) ?? 0],
    );
  }

  /// Returns a formatted string representation of the [startDate], using the [DateFormat.yMd] format.
  String get startDateString => formatDateTime(DateTime.fromMillisecondsSinceEpoch(startDate));

  /// Returns a formatted string representation of the [endDate], using the [DateFormat.yMd] format.
  String get endDateString => formatDateTime(DateTime.fromMillisecondsSinceEpoch(endDate));

  /// Returns the time left until the [endDate] of the to do item, as a formatted string.
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

  /// Returns the time left until the [endDate] of the to do item, in milliseconds.
  int get _timeLeft => endDate - DateTime.now().millisecondsSinceEpoch;

  /// Returns the status of the to do item as a string.
  String get todosStatusString => todosStatus == TodosStatus.complete ? "Completed" : "In Progress";

  /// Returns a formatted string representation of the given [dateTime], using the [DateFormat.yMd] format.
  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat.yMd();
    return formatter.format(dateTime);
  }
}
