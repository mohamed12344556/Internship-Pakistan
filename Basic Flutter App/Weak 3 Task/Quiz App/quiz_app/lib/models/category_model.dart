class CategoryModel {
  final int id;
  final String categoryName;

  CategoryModel({required this.id, required this.categoryName});

  factory CategoryModel.fromJson(json) {
    
    return CategoryModel(
      id: json['id'],
      categoryName: json['name'],
    );
  }
}
