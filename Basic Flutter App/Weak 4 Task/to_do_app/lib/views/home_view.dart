import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/core/themes/colors.dart';
import 'package:to_do_app/models/todo_model.dart';
import 'package:to_do_app/services/shared_prefremces_api.dart';
import 'package:to_do_app/views/add_to_do_view.dart';
import 'package:to_do_app/views/task_details_view.dart';
import 'package:to_do_app/widgets/custom_Row.dart';
import 'package:to_do_app/widgets/todocontainer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String id = "home_view";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool? isCheck = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  bool isCompleted = false;
  bool loaded = false;
  bool? editPressed = false;
  List<ToDoModel> todoItems = [];

  @override
  void initState() {
    super.initState();
    populateList();
  }

  Future<void> populateList() async {
    todoItems = await shared_pref_api().getList();
    setState(() {
      loaded = true;
    });
    }

  int _getNextId() {
    return todoItems.isNotEmpty
        ? todoItems.map((item) => item.id).reduce((a, b) => a > b ? a : b) + 1
        : 1;
  }

  void deleteTask(int id) {
    setState(() {
      todoItems.removeWhere((item) => item.id == id);
    });
    shared_pref_api().saveList(todoItems);
  }

  void _openAddOrEditTask({bool isEditing = false, int? editingIndex}) {
    if (isEditing && editingIndex != null) {
      titleController.text = todoItems[editingIndex].title;
      descriptionController.text = todoItems[editingIndex].description;
      dateTimeController.text = todoItems[editingIndex].date;
      editPressed = true;
    } else {
      titleController.clear();
      descriptionController.clear();
      dateTimeController.clear();
      editPressed = false;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: AddToDoView(
                titleController: titleController,
                descriptionController: descriptionController,
                dateTimeController: dateTimeController,
                todoItems: todoItems,
                isCompleted: isCompleted,
                isEditing: isEditing,
                editingIndex: editingIndex,
              ),
            );
          },
        );
      },
    ).then((task) {
      if (task != null && task is ToDoModel) {
        setState(() {
          if (isEditing && editingIndex != null) {
            todoItems[editingIndex] = task;
          } else {
            todoItems.add(task);
          }
          shared_pref_api().saveList(todoItems);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: TextStyle(
            color: ColorsManager.peachPink,
            fontFamily: 'Montserrat',
            fontSize: 25.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_outlined,
              size: 29.sp,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          children: [
            SizedBox(
              height: 55.h,
              child: const CustomRow(),
            ),
            Expanded(
              child: Visibility(
                visible: loaded,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ListView.builder(
                  itemCount: todoItems.length,
                  itemBuilder: (context, index) => Slidable(
                    key: UniqueKey(),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(
                        onDismissed: () {
                          deleteTask(todoItems[index].id);
                        },
                      ),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          icon: Icons.delete,
                          onPressed: (context) {
                            deleteTask(todoItems[index].id);
                          },
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          icon: Icons.edit,
                          onPressed: (context) {
                            _openAddOrEditTask(
                                isEditing: true, editingIndex: index);
                          },
                        ),
                        SlidableAction(
                          backgroundColor: ColorsManager.charcoalGray,
                          borderRadius: BorderRadius.circular(10),
                          icon: Icons.message,
                          onPressed: (context) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskDetailsView(
                                  todoItem: todoItems[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    child: ToDoContainer(
                      todos: todoItems,
                      index: index,
                      value: todoItems[index].isCompleted,
                      onChanged: (val) {
                        setState(() {
                          todoItems[index].isCompleted = val!;
                        });
                        shared_pref_api().saveList(todoItems);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _openAddOrEditTask();
      },
      backgroundColor: ColorsManager.coralPink,
      elevation: 0,
      shape: const CircleBorder(),
      child: Icon(
        Icons.add,
        color: ColorsManager.mainWhite,
        size: 45.sp,
      ),
    );
  }
}
