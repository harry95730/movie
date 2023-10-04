import 'package:flutter/material.dart';
import 'package:flutter_application_1/class.dart';
import 'package:flutter_application_1/listofsub.dart';
import 'package:flutter_application_1/page3.dart';

class Custompage extends StatefulWidget {
  const Custompage({super.key});

  @override
  State<Custompage> createState() => _CustompageState();
}

class _CustompageState extends State<Custompage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[200],
        toolbarHeight: 80.0,
        title: Center(child: Design().titl()),
        actions: [
          IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Custompage1()));
              setState(() {});
            },
          ),
        ],
      ),
      body: Listpage(
        refresh: refresh,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black87,
          onPressed: () {
            refresh();
            setState(() {
              sea = !sea;
            });
          },
          child: Icon(
            sea ? Icons.search : Icons.close,
          )),
    );
  }
}
