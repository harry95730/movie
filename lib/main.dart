import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/clas.dart';
import 'package:flutter_application_1/class.dart';
import 'package:flutter_application_1/listofsub.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Bloc> _searchResults = [];
  bool kr = false;
  bool fro = true;
  onSearchTextChanged(String query) async {
    _searchResults.clear();
    if (query.isEmpty) {
      for (var i in dataMap) {
        _searchResults.add(i);
      }

      setState(() {
        fro = !fro;
      });
      return;
    }
    for (var i in dataMap) {
      if (i.title.toLowerCase().contains(query)) {
        _searchResults.add(i);
      }
    }
    setState(() {
      fro = !fro;
    });
  }

  void someAsyncFunction() async {
    try {
      List<Bloc> abc = [];
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
    setState(() {
      someAsyncFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 40),
            child: Center(
              child: ClipPath(
                clipper: CustomAppBar(),
                child: AppBar(
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFDEF9F9),
                            Color(0xFFFEFEFE),
                          ],
                        ),
                      ),
                    ),
                  ),
                  title: const SafeArea(
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 21.0,
                            backgroundImage:
                                AssetImage('assets/images/i3.jpg')),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Hello ,',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black)),
                            Text('M alwan',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Row(
                      children: [
                        IconButton(
                          icon: FaIcon(
                            size: min(20, 20),
                            FontAwesomeIcons.solidBell,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: FaIcon(
                              size: min(20, 20),
                              FontAwesomeIcons.list,
                              color: Colors.black),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[300]),
                    child: TextField(
                      onChanged: onSearchTextChanged,
                      controller: controller,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Search for brand',
                        hintMaxLines: 1,
                      ),
                    ),
                  ),
                ),
                const PictureSlider(),
                function(context, _searchResults),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PictureSlider extends StatefulWidget {
  const PictureSlider({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PictureSliderState createState() => _PictureSliderState();
}

class _PictureSliderState extends State<PictureSlider> {
  final List<String> images = [
    "assets/images/i1.jpg",
    "assets/images/i12.jpg",
    "assets/images/i3.jpg",
  ];
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          options: CarouselOptions(
            height: 210,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2 / 3,
            viewportFraction: 1.0,
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return InkWell(
              onTap: () {},
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  DotsIndicator(
                    currentPage: index,
                    numberOfDots: images.length,
                  )
                ],
              ),
            );
          },
        ),
      ],
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

class DotsIndicator extends StatelessWidget {
  final int numberOfDots;
  final int currentPage;

  const DotsIndicator({
    super.key,
    required this.numberOfDots,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numberOfDots, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }
}
