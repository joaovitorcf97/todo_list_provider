import 'package:flutter/material.dart';
import 'package:todo_provider/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_provider/app/core/ui/todo_list_ui_config.dart';
import 'package:todo_provider/app/modules/auth/auth_module.dart';
import 'package:todo_provider/app/modules/splash/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliAdmConnection = SqliteAdmConnetion();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(sqliAdmConnection);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      routes: {
        ...AuthModule().routers,
      },
      initialRoute: '/login',
      home: const SplashPage(),
      theme: TodoListUiConfig.theme,
    );
  }
}
