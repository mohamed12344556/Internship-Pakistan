import 'dart:typed_data';

class Recipe {
  final String name;
  final List<String> ingredients;
  final List<String> steps;
  final Uint8List? image;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.steps,
    required this.image,
  });

 
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredients': ingredients.join(','),
      'steps': steps.join(','),
      'image': image, 
    };
  }

  static Recipe fromMap(Map<String, dynamic> map) {
    return Recipe(
      name: map['name'],
      ingredients: map['ingredients'].split(','),
      steps: map['steps'].split(','),
      image: map['image'],
    );
  }
}