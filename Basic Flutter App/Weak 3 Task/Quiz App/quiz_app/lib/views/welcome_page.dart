import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_app/views/quiz_category_page.dart';
import 'package:quiz_app/widgets/custom_text_formField.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextEditingController userNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/Interior_slide_2_mobile.png',
            fit: BoxFit.cover,
          ),
        ),
        Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 28.5),
                child: Text(
                  'Let\'s Play Quiz',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(
                flex: 4,
              ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          text: 'Enter your name',
                          userController: userNameController,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (userNameController.text == 'Admin' ||
                                  userNameController.text == 'admin') {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Admin Login'),
                                    content: const Text(
                                        'Sorry You Don\'t have permission'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                log(userNameController.text);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const QuizCategory(),
                                ));
                              }
                            }
                          },
                          child: const Text(
                            'Start Engine',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 111, 0),
                                fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
