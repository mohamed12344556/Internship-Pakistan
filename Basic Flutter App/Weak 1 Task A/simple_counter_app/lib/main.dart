import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int counter = 0;

  customButton({required Icon icon, required VoidCallback? onPressed}) {
    return SizedBox(
      width: 90,
      height: 90,
      child: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 230, 232, 235),
        onPressed: onPressed,
        elevation: 0,
        child: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Counter App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFD1FF6F),
                      Color(0xFFFFDC83),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Text(
                  'Count : $counter',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => setState(() {
                            counter++;
                          })),
                  customButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => setState(() {
                      counter--;
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
