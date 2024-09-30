import 'package:flutter/material.dart';
import 'package:to_do_app/core/themes/styles.dart';
import 'package:to_do_app/models/todo_model.dart'; // Import ToDoModel

class TaskDetailsView extends StatefulWidget {
  final ToDoModel todoItem; // Receive task details
  const TaskDetailsView({super.key, required this.todoItem});
  static const String id = "task_details_view";

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.todoItem.title,
              style: TextStyleHelper.BebasNeuefont26CharcoalGrayRegular,
            ),
            const SizedBox(height: 16),
            Text(
              widget.todoItem.description,
              style: TextStyleHelper.Montserratfont16CharcoalGrayRegular,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Created at: ${widget.todoItem.date.isEmpty ? 'No deadline' : widget.todoItem.date}',
                style: TextStyleHelper.Montserratfont14CharcoalGrayRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  double? size;
  CustomIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.size,
  });
  final onPressed;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon.icon,
        size: size,
      ),
    );
  }
}
