import 'package:flutter/material.dart';
import 'package:to_do_app/core/themes/colors.dart';
import 'package:to_do_app/core/themes/styles.dart';
import 'package:to_do_app/models/todo_model.dart';

class AddToDoView extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController dateTimeController;
  final bool isCompleted;
  final List<ToDoModel> todoItems;
  final bool isEditing;
  final int? editingIndex;

  const AddToDoView({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.dateTimeController,
    required this.todoItems,
    required this.isCompleted,
    this.isEditing = false,
    this.editingIndex,
  });

  @override
  _AddToDoViewState createState() => _AddToDoViewState();
}

class _AddToDoViewState extends State<AddToDoView> {
  int generateId() {
    return widget.todoItems.isEmpty
        ? 1
        : widget.todoItems.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  void handleSubmit() {
    if (widget.titleController.text.isNotEmpty &&
        widget.descriptionController.text.isNotEmpty) {
      ToDoModel task = ToDoModel(
        id: widget.isEditing && widget.editingIndex != null
            ? widget.todoItems[widget.editingIndex!].id
            : generateId(),
        title: widget.titleController.text,
        description: widget.descriptionController.text,
        date: widget.dateTimeController.text.isNotEmpty
            ? widget.dateTimeController.text
            : '',
        isCompleted: widget.isCompleted,
      );

      Navigator.pop(context, task);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in the required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorsManager.mainWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHandleBar(),
            _buildTextField(
              controller: widget.titleController,
              labelText: 'Title',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: widget.descriptionController,
              labelText: 'Description',
              maxLines: 14,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: widget.dateTimeController,
              labelText: 'Deadline (Optional)',
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            const SizedBox(height: 16),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHandleBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Center(
        child: Container(
          width: 100,
          height: 5,
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    int maxLines = 1,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyleHelper.Montserratfont16CharcoalGrayRegular,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: handleSubmit,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: ColorsManager.mainWhite,
        padding: EdgeInsets.only(
            top: 12, bottom: MediaQuery.of(context).viewInsets.bottom),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: Text(
        widget.isEditing ? 'UPDATE TODO' : 'ADD TODO',
        style: TextStyleHelper.Montserratfont14PeachPinkMedium,
      ),
    );
  }
}
