// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/clas.dart';
import 'package:http/http.dart' as http;

var data = [];
List<Movies> dataMap = [];
Map<String, bool> keyvalue = {};
List<Movies> data1 = [];
String hat = 'a';

TextEditingController controller = TextEditingController();

class Servi {
  void showSnackbar(BuildContext context, String message, Color abc) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: abc,
      ),
    );
  }

  Future<List<Movies>> fetchBlogs(BuildContext context) async {
    String url = 'https://api.tvmaze.com/search/shows?q=$hat';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> parsedJson = json.decode(response.body);
      for (var jsonMovie in parsedJson) {
        Movies movie = Movies.fromJson(jsonMovie);
        dataMap.add(movie);
      }
      return dataMap;
    } else {
      showSnackbar(
          context,
          'Request failed with status code: ${response.statusCode}',
          Colors.red);
    }

    return [];
  }
}
