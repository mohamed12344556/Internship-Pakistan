import 'package:path/path.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE recipes(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, ingredients TEXT, steps TEXT, image BLOB)', // تخزين الصورة كـ BLOB
        );
      },
    );
  }

  Future<void> insertRecipe(Recipe recipe) async {
    final db = await database;
    await db.insert(
      'recipes',
      recipe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Recipe>> getRecipes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('recipes');

    return List.generate(maps.length, (i) {
      return Recipe.fromMap(maps[i]);
    });
  }
}