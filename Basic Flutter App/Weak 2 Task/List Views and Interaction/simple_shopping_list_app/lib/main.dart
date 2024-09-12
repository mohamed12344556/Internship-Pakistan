import 'package:flutter/material.dart';

import 'views/display_items.dart';

void main() {
  runApp(const ShoppingListApp());
}

class ShoppingListApp extends StatelessWidget {
  const ShoppingListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List App',
      home: DisplayShoppingItems(),
    );
  }
}
