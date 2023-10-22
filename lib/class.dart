// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/clas.dart';
import 'package:http/http.dart' as http;

var data = [];
List<Bloc> dataMap = [];
Map<String, bool> keyvalue = {};
List<Bloc> data1 = [];

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

  Future<List<Bloc>> fetchBlogs(BuildContext context) async {
    const url = 'https://api.escuelajs.co/api/v1/products';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);

        dataMap = data.map((e) {
          return Bloc.fromMap(e);
        }).toList();
        return dataMap;
      } else {
        showSnackbar(
            context,
            'Request failed with status code: ${response.statusCode}',
            Colors.red);
      }
    } catch (e) {
      showSnackbar(context, 'Error: $e', Colors.red);
    }
    return [];
  }
}
