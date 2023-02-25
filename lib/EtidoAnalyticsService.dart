import 'package:firebase_analytics/firebase_analytics.dart';

enum EtidoEvents {
  pageLoad, // event when a page loads
  openApp, // event when the app is opened
  buttonClick, // event when a button is clicked
  newTodo, // event when a new To Do is added
  editTodo, // event when a To Do is edited
  changeStatusToInProgress, // event when a To Do's status is changed to "in progress"
  changeStatusToComplete, // event when a To Do's status is changed to "complete"
}

class EtidoAnalyticsService {
  static Future<void> logEvent({required EtidoEvents etidoEvent, required Map<String, dynamic> parameters}) async {
    await FirebaseAnalytics.instance.logEvent(
      name: etidoEvent.name,
      parameters: parameters,
    );
  }
}
