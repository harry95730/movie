import 'package:flutter/material.dart';
import 'package:flutter_application_1/clas.dart';
import 'package:flutter_application_1/class.dart';
import 'package:flutter_application_1/listofsub.dart';
import 'package:flutter_application_1/main.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final List<Movies> _searchResults = [];
  bool fro = true;
  bool kr = false;
  @override
  void initState() {
    super.initState();
    onSearchTextChanged("");
  }

  onSearchTextChanged(String query) async {
    hat = query;
    if (query.isEmpty) {
      hat = "a";
    }
    await someAsyncFunction();
    setState(() {
      fro = !fro;
    });
  }

  Future<void> someAsyncFunction() async {
    try {
      _searchResults.clear();
      List<Movies> abc = [];
      abc = await Servi().fetchBlogs(context);
      for (var i in abc) {
        _searchResults.add(i);
      }
      setState(() {
        kr = true;
      });
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[300]),
          child: TextField(
            onChanged: onSearchTextChanged,
            controller: controller,
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              labelText: 'Search for Movie',
              hintMaxLines: 1,
            ),
          ),
        ),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: function(context, _searchResults)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(13, 13, 13, 1),
        elevation: 2,
        selectedLabelStyle: const TextStyle(color: Colors.redAccent),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.red.shade200,
        unselectedLabelStyle: TextStyle(color: Colors.red.shade200),
        currentIndex: 0,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.redAccent,
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.red.shade200,
            ),
            label: 'SEARCH',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyApp(),
              ),
            );
          }
        },
      ),
    );
  }
}
