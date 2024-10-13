import 'package:flutter/material.dart';
import 'package:recipe_app/databases/create.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/pages/add_recipe_page.dart';
import 'package:recipe_app/pages/recipe_detail_page.dart';
import 'package:recipe_app/pages/recipe_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Recipe>> _recipes;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  void _loadRecipes() {
    setState(() {
      _recipes = DatabaseHelper().getRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Recipes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final recipes = await _recipes;
              showSearch(
                context: context,
                delegate: RecipeSearchDelegate(recipes),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found.'));
          } else {
            final recipes = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // عدد الأعمدة في الشبكة
                crossAxisSpacing: 10, // المسافة الأفقية بين العناصر
                mainAxisSpacing: 10, // المسافة الرأسية بين العناصر
                childAspectRatio: 3 / 4, // النسبة بين العرض والارتفاع لكل عنصر
              ),
              padding: const EdgeInsets.all(10),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(recipe: recipe),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        recipe.image != null
                            ? ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: Image.memory(
                                  recipe.image!,
                                  width: double.infinity,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.image,
                                size: 120,
                                color: Colors.grey,
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recipe.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            recipe.ingredients.join(', '),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newRecipe = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddRecipePage(
                onSave: (recipe) {},
              ),
            ),
          );

          if (newRecipe != null) {
            _loadRecipes();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
