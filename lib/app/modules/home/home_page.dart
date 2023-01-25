import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/app/core/auth/auth_provider.dart';
import 'package:todo_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_provider/app/modules/home/widgets/home_filters.dart';
import 'package:todo_provider/app/modules/home/widgets/home_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: context.primaryColor),
          elevation: 0,
          actions: [
            PopupMenuButton(
              icon: Icon(
                Icons.filter_alt,
                color: context.primaryColor,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem<bool>(
                  child: Text('Mostrar tarefas concluidas'),
                ),
              ],
            ),
          ],
        ),
        drawer: HomeDrawer(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.minWidth,
                ),
                child: Container(
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        HomeHeader(),
                        HomeFilters(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
