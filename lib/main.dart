import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/animation.dart';
import 'package:flutter_application_1/clas.dart';
import 'package:flutter_application_1/class.dart';
import 'package:flutter_application_1/listofsub.dart';
import 'package:flutter_application_1/searchpage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MaterialApp(
    home: MovingZ(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Movies> _searchResults = [];
  bool kr = false;

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
  void initState() {
    super.initState();
    someAsyncFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 40),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: [
              Container(color: Colors.black),
              ClipPath(
                clipper: CustomAppBar(),
                child: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.redAccent, Colors.black],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 21.0,
                  backgroundImage: AssetImage('assets/images/i3.jpg')),
              SizedBox(width: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hello ,',
                      style: TextStyle(fontSize: 10.0, color: Colors.white)),
                  Text('Harry',
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: FaIcon(
                size: min(20, 20),
                FontAwesomeIcons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Searchpage()));
              },
            ),
          ],
        ),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: function(context, _searchResults)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(13, 13, 13, 1),
        elevation: 2,
        selectedLabelStyle: const TextStyle(color: Colors.redAccent),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.red.shade200,
        unselectedLabelStyle: TextStyle(color: Colors.red.shade200),
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.red.shade200,
            ),
            label: 'HOME',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.redAccent,
            ),
            label: 'SEARCH',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Searchpage(),
              ),
            );
          }
        },
      ),
    );
  }
}

class CustomAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);

    path.quadraticBezierTo(
        size.width / 30, size.height - 30, size.width / 10, size.height - 30);

    path.lineTo(9 / 10 * size.width, size.height - 30);

    path.cubicTo(
      9 / 10 * size.width,
      size.height - 30,
      size.width,
      size.height - 40,
      size.width,
      size.height - 50,
    );

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
