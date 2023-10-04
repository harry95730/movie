import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/clas.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

var data = {};
List<Bloc> dataMap = [];
bool sea = true;
Map<String, bool> keyvalue = {};

class Design {
  Widget titl() {
    return RichText(
      text: const TextSpan(
        text: 'B',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: 'f1',
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'L',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontFamily: 'f1',
              fontSize: 40,
            ),
          ),
          TextSpan(
            text: 'O',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'f1',
              color: Colors.red,
            ),
          ),
          TextSpan(
            text: 'G',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'f1',
                color: Colors.green,
                fontSize: 40),
          ),
          TextSpan(
            text: 'S',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'f1',
                color: Colors.black,
                fontSize: 40),
          ),
        ],
      ),
    );
  }
}

class Servi {
  Future<void> update(Bloc value) async {
    final recstor = Hive.box('test');
    for (var i = 0; i < recstor.length; i++) {
      final mapData = recstor.getAt(i) as Map<dynamic, dynamic>;
      if (mapData['id'] == value.id) {
        mapData['lik'] = !mapData['lik'];
        await recstor.put(i, mapData);
        return;
      }
    }
    return;
  }

  Future<List<Bloc>> retrieveData() async {
    final recstor = Hive.box('test');
    List<Bloc> blocList = [];
    for (var i = 0; i < recstor.length; i++) {
      final mapData = recstor.getAt(i) as Map<dynamic, dynamic>;

      final bloc = Bloc(
        title: mapData['title'] as String,
        id: mapData['id'] as String,
        imgurl: mapData['imgurl'] as String,
        lik: mapData['lik'] as bool,
      );
      keyvalue[bloc.id] = bloc.lik;
      blocList.add(bloc);
    }
    return blocList;
  }

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

  Future<void> fetchBlogs(BuildContext context) async {
    const url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        final son = data["blogs"] as List<dynamic>;
        final storag = Hive.box('test');
        dataMap.clear();
        await retrieveData();
        dataMap = son.map((e) {
          return Bloc.fromMap(e);
        }).toList();
        for (var i in dataMap) {
          if (keyvalue.containsKey(i.id)) {
          } else {
            Map<dynamic, dynamic> r = {
              "title": i.title,
              "id": i.id,
              "imgurl": i.imgurl,
              "lik": i.lik
            };
            await storag.add(r);
          }
        }
        dataMap = await retrieveData();
      } else {
        // Request failed
        // ignore: use_build_context_synchronously
        showSnackbar(
            context,
            'Request failed with status code: ${response.statusCode}',
            Colors.red);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbar(context, 'Error: $e', Colors.red);
      List<Bloc> abc = await retrieveData();
      for (var i in abc) {
        dataMap
            .add(Bloc(title: i.title, id: i.id, imgurl: i.imgurl, lik: i.lik));
      }
    }
  }
}
