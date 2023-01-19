import 'package:flutter/cupertino.dart';
import 'package:todo_provider/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnetion with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final connection = SqliteConnectionFactory();

    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        connection.closeConnection();
        break;
      default:
    }
    super.didChangeAppLifecycleState(state);
  }
}
