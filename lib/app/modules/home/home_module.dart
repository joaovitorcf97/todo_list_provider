import 'package:todo_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_provider/app/modules/home/home_page.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          //bindings: [],
          routers: {
            '/home': (context) => const HomePage(),
          },
        );
}
