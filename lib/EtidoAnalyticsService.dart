import 'package:firebase_analytics/firebase_analytics.dart';

enum EtidoEvents {
  pageLoad,
  openApp,
  buttonClick,
  newTodo,
  editTodo,
  changeStatusToInProgress,
  changeStatusToComplete,
}

class EtidoAnalyticsService {
  static Future<void> logEvent({required EtidoEvents etidoEvent, required Map<String, dynamic> parameters}) async {
    await FirebaseAnalytics.instance.logEvent(
      name: etidoEvent.name,
      parameters: parameters,
    );
  }
}
