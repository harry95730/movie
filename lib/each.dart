// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/clas.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/rating.dart';
import 'package:flutter_application_1/searchpage.dart';
import 'package:flutter_html/flutter_html.dart';

class MyPage extends StatefulWidget {
  Movies harry;
  MyPage({super.key, required this.harry});

  @override
  State<MyPage> createState() => _MyPageState();
}

String img = '';

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    if (widget.harry.show!.image != null &&
        widget.harry.show!.image!.original != null) {
      img = widget.harry.show!.image!.original!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.harry.show!.name!,
          softWrap: false,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            widget.harry.show != null
                ? widget.harry.show!.image != null
                    ? widget.harry.show!.image!.medium != null
                        ? ima(img)
                        : Container()
                    : Container()
                : Container(),
            widget.harry.show!.rating!.average != null
                ? StarRating(
                    rating: widget.harry.show!.rating!.average! / 2, br: false)
                : const StarRating(rating: 0, br: false),
            Html(
              data: widget.harry.show!.summary!,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(13, 13, 13, 1),
        elevation: 2,
        selectedLabelStyle: const TextStyle(color: Colors.redAccent),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.redAccent,
        unselectedLabelStyle: const TextStyle(color: Colors.redAccent),
        currentIndex: 0,
        showSelectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.redAccent,
            ),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
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
          } else if (index == 0) {
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

  Widget buildiy(String imagename) {
    return InkWell(
      onTap: () {
        setState(() {
          img = imagename;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0), child: ima(imagename)),
        ),
      ),
    );
  }

  Widget ima(String imag) {
    return Image.network(
      imag,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Text('Image not found');
      },
    );
  }
}
