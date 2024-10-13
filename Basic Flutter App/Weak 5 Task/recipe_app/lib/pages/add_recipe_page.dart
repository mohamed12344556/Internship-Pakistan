import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/databases/create.dart';
import 'package:recipe_app/model/recipe.dart';

class AddRecipePage extends StatefulWidget {
  final Function(Recipe) onSave;

  const AddRecipePage({super.key, required this.onSave});

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  final List<String> _ingredients = [];
  final List<String> _steps = [];
  Uint8List? _imageBytes;

  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _stepController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  bool _imageSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // بطاقة اسم الوصفة
              Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Recipe Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the recipe name';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value!,
                  ),
                ),
              ),

              // حقل إضافة المكونات
              Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _ingredientController,
                        decoration: const InputDecoration(
                          labelText: 'Ingredient',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_ingredientController.text.isNotEmpty) {
                            setState(() {
                              _ingredients.add(_ingredientController.text);
                            });
                            _ingredientController.clear();
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Ingredient'),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        children: _ingredients
                            .map((ingredient) => Chip(
                                  label: Text(ingredient),
                                  onDeleted: () {
                                    setState(() {
                                      _ingredients.remove(ingredient);
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      if (_ingredients.isEmpty)
                        const Text(
                          'Please add at least one ingredient',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),

              // حقل إضافة الخطوات
              Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _stepController,
                        decoration: const InputDecoration(
                          labelText: 'Step',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_stepController.text.isNotEmpty) {
                            setState(() {
                              _steps.add(_stepController.text);
                            });
                            _stepController.clear();
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Step'),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        children: _steps
                            .map((step) => Chip(
                                  label: Text(step),
                                  onDeleted: () {
                                    setState(() {
                                      _steps.remove(step);
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                      if (_steps.isEmpty)
                        const Text(
                          'Please add at least one step',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),

              // عرض الصورة
              Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _imageBytes != null
                          ? Image.memory(
                              _imageBytes!,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            )
                          : const Text('No image selected'),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.image),
                        label: const Text('Pick Image'),
                      ),
                      if (!_imageSelected)
                        const Text(
                          'Please select an image',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // زر حفظ الوصفة
              ElevatedButton(
                onPressed: _saveRecipe,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:
                    const Text('Save Recipe', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await File(pickedFile.path).readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _imageSelected = true;
      });
    }
  }

  void _saveRecipe() async {
    setState(() {
      _imageSelected = _imageBytes != null;
    });

    if (_formKey.currentState!.validate() && _imageSelected) {
      _formKey.currentState!.save();
      final newRecipe = Recipe(
        name: _name,
        ingredients: _ingredients,
        steps: _steps,
        image: _imageBytes,
      );
      await DatabaseHelper().insertRecipe(newRecipe);
      widget.onSave(newRecipe);
      Navigator.pop(context, newRecipe);
    }
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    _stepController.dispose();
    super.dispose();
  }
}
