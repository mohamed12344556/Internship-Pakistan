import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/models/todo_model.dart'; 
import 'package:to_do_app/views/home_view.dart';
import 'package:to_do_app/views/task_details_view.dart';

void main() {
  runApp(const ToDoList());
} 

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => SafeArea(
        child: MaterialApp(
          routes: {
            HomeView.id: (context) => const HomeView(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == TaskDetailsView.id) {
              final todoItem = settings.arguments as ToDoModel;
              return MaterialPageRoute(
                builder: (context) {
                  return TaskDetailsView(todoItem: todoItem);
                },
              );
            }
            return null;
          },
          initialRoute: HomeView.id,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
