import 'package:flutter/material.dart';
import 'package:flutter_application_1/class.dart';
import 'package:flutter_application_1/listofsub2.dart';

class Custompage1 extends StatefulWidget {
  const Custompage1({super.key});

  @override
  State<Custompage1> createState() => _Custompage1State();
}

class _Custompage1State extends State<Custompage1> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlue[200],
        toolbarHeight: 80.0,
        title: Center(child: Design().titl()),
        actions: [
          IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.star,
              color: Colors.blueGrey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Listpage1(
        refresh: refresh,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black87,
          onPressed: () {
            setState(() {
              sea = !sea;
            });
            refresh();
          },
          child: Icon(
            sea ? Icons.search : Icons.close,
          )),
    );
  }
}
