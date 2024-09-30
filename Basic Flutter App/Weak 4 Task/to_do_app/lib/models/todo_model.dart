import 'dart:convert';

List<ToDoModel> postModelFromJson(String str) =>
    List<ToDoModel>.from(json.decode(str).map((x) => ToDoModel.fromJson(x)));

String postModelToJson(List<ToDoModel> data) =>
    json.encode(List<dynamic>.from(data.map((e) => e.toJson())));

class ToDoModel {
  ToDoModel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.isCompleted,
  });
  int id;
  String title;
  String date;
  String description;
  bool? isCompleted;

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
        id: json['id'],
        title: json['title'],
        date: json['date'],
        description: json['description'],
        isCompleted: json['isCompleted'] = false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date": date,
        "description": description,
      };
}
