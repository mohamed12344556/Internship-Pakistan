// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:basic_contact_form/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:basic_contact_form/views/display_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Basic Contact Form'),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Contact Form',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 50),
            Form(
              key: formstate,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomTextFormField(
                      text: 'Name',
                      icon: const Icon(Icons.person),
                      maxLines: 1,
                      controller: nameController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      text: 'Email',
                      icon: const Icon(Icons.email),
                      maxLines: 1,
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      text: 'message',
                      icon: const Icon(Icons.message),
                      maxLines: 3,
                      controller: messageController,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: ElevatedButton(
                onPressed: () {
                  if (formstate.currentState!.validate()) {
                    log(nameController.text);
                    log(emailController.text);
                    log(messageController.text);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayForm(
                          name: nameController,
                          email: emailController,
                          message: messageController,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            )
          ],
        ));
  }
}
