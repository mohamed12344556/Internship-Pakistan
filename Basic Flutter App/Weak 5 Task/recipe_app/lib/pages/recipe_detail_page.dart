import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            recipe.image != null && recipe.image!.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Image.memory(
                      recipe.image!,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No image available',
                        style: TextStyle(fontSize: 18)),
                  ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Text('Ingredients',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: recipe.ingredients
                        .map((ingredient) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                '- $ingredient',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child:
                  Text('Steps', style: Theme.of(context).textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: recipe.steps
                        .map((step) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                '- $step',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
