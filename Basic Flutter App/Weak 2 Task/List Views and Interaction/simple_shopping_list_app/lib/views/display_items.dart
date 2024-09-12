import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_shopping_list_app/model/item_model.dart';

class DisplayShoppingItems extends StatefulWidget {
  const DisplayShoppingItems({super.key});

  @override
  State<DisplayShoppingItems> createState() => _DisplayShoppingItems();
}

class _DisplayShoppingItems extends State<DisplayShoppingItems> {
  final List<ItemModel> shoppingItems = [];
  final TextEditingController textController = TextEditingController();
  File? image;
  final ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text('Shopping List'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter an item name',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      additem();
                    },
                  ),
                  IconButton(
                    onPressed: pickImage,
                    icon: const Icon(Icons.image_outlined),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: shoppingItems.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(shoppingItems[index].toString()),
                    onDismissed: (direction) {
                      removeitem(index);
                    },
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          shoppingItems[index].name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(shoppingItems[index].image),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void additem() {
    if (textController.text.isNotEmpty && image != null) {
      setState(
        () {
          shoppingItems.add(ItemModel(
            name: textController.text,
            image: image!.path,
          ));
          textController.clear();
          image = null;
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added successfully'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void removeitem(int index) {
    setState(() {
      shoppingItems.removeAt(index);
    });
  }

  Future pickImage() async {
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return log('No image selected');
    } else {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }
}
