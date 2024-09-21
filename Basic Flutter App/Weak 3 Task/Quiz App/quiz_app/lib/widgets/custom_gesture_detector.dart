import 'package:flutter/material.dart';
import 'package:quiz_app/models/category_model.dart';
import 'package:quiz_app/views/quiz_page.dart';

class CustomGestureDetector extends StatelessWidget {
  const CustomGestureDetector({
    required this.category,
    super.key,
  });
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => QuizPage(category: category),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category.categoryName,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Icon(Icons.question_answer_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
