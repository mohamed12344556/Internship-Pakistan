import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/pages/recipe_detail_page.dart';

class RecipeSearchDelegate extends SearchDelegate {
  final List<Recipe> recipes;

  RecipeSearchDelegate(this.recipes);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = recipes
        .where(
            (recipe) => recipe.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(
        child: Text(
          'No recipes found.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final recipe = results[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(
              recipe.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                recipe.ingredients.join(', '),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: recipe.image != null
                  ? Image.memory(
                      recipe.image!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.image, size: 50),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailPage(recipe: recipe),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = recipes
        .where(
            (recipe) => recipe.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final recipe = suggestions[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(
              recipe.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: recipe.image != null
                  ? Image.memory(
                      recipe.image!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.image, size: 50),
            ),
            onTap: () {
              query = recipe.name;
              showResults(context);
            },
          ),
        );
      },
    );
  }
}
