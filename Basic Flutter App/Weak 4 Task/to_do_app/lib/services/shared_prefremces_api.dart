import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/models/todo_model.dart';

const key = 'todo_list';

class shared_pref_api {
  //get list Method
  Future<List<ToDoModel>> getList() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    final jsonString = sf.getString(key) ?? '[]';
    final jsonDecoded = json.decode(jsonString) as List;

    return jsonDecoded
        .map(
          (e) => ToDoModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  //save list
  void saveList(List<ToDoModel> todos) async {
    final stringJson = json.encode(todos);
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.setString(key, stringJson);
  }

  //update List
  void updateList(List<ToDoModel> todos, int id, String title, String date,
      String description) async {
    for (var i in todos) {
      if (i.id == id) {
        i.title = title;
        i.date = date;
        i.description = description;
      }
    }
    saveList(todos);
  }
}
