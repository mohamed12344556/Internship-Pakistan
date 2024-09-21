import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_app/models/category_model.dart';
import 'package:quiz_app/services/quiz_category.dart';
import 'package:quiz_app/widgets/custom_gesture_detector.dart';
import 'package:skeletonizer/skeletonizer.dart';

class QuizCategory extends StatefulWidget {
  const QuizCategory({super.key});

  @override
  State<QuizCategory> createState() => _QuizCategoryState();
}

class _QuizCategoryState extends State<QuizCategory> {
  String category = 'linux';
  bool isLoading = true;
  List<CategoryModel> categoryList=[];
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Category'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: FutureBuilder<List<CategoryModel>>(
          future: QuizCategoryService().getQuizService(category: category),
          builder: (
            context,
            snapshot,
          ) {
            if (snapshot.hasData) {
              categoryList = snapshot.data!;
              log('length ${categoryList.length}');
              return Skeletonizer(
                enabled: isLoading,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return CustomGestureDetector(
                      category: categoryList[index],
                    );
                  },
                ),
              );
            } else{
              return const Center(child: Text('Loading...'));
            } 
          },
        ),
      ),
    );
  }
}
