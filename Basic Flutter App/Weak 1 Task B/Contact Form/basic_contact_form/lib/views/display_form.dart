import 'package:flutter/material.dart';

class DisplayForm extends StatelessWidget {
  const DisplayForm(
      {super.key,
      required this.name,
      required this.email,
      required this.message});

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Form Data'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: Container(
        width: 300,
        height: 300,
        color: Colors.blue[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name is: ${name.text}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Email is: ${email.text}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Message is: ${message.text}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )),
    );
  }
}
