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

/// A service class for logging analytics events using Firebase Analytics.
class EtidoAnalyticsService {
  /// Logs an analytics event with the specified [etidoEvent] and [parameters].
  ///
  /// This method logs the event using Firebase Analytics.
  ///
  /// The [etidoEvent] parameter specifies the type of event to be logged.
  ///
  /// The [parameters] parameter is a map of key-value pairs that provide additional
  /// context and information for the event. The keys and values must be of type [String]
  /// and [dynamic], respectively.
  ///
  /// Throws an exception if logging the event fails.
  static Future<void> logEvent({required EtidoEvents etidoEvent, required Map<String, dynamic> parameters}) async {
    await FirebaseAnalytics.instance.logEvent(
      name: etidoEvent.name,
      parameters: parameters,
    );
  }
}
