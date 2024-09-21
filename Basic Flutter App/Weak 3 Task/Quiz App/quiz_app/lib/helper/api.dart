import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required String url,required String category ,@required String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({
        'X-Api-Key': 'SVC3w7mzyyfxge1yySKkxl4zD7tTY3GGvlqwigmP',
        'Cookie':
            'XSRF-TOKEN=$token; quziapi_session=eyJpdiI6IjhkSE5MQlhrbkNpQTdsSjREd0c1YlE9PSIsInZhbHVlIjoiQ21IR0Jtd3pjZ1A2ZGxIdHdDeUROZFFpa0I5cjBiM3ZUdHd0cXlpcGlsWHBqblwvUHN3NTc4YkpiNndvY3RlUEs5elNOOUNTTlFLNWVnS255SGJubHJodE9BbE1hUFZPYUFFMUVQUUsyRXo3NDIrS2FSc1RWRU1SOXJDMVIzXC9wTSIsIm1hYyI6Ijk0OTNkYzJmMjMzZWU2ODFjY2Y5YmVjZDc0YzZlNmNkNGM3M2RkMGZjZDIwNzc0OGZhMDE2ZWY3YzJhMTc3MDIifQ%3D%3D',
        'category': category,
      });
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response =
        await http.post(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    print('url = $url body = $body token = $token ');
    http.Response response =
        await http.put(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }
}
