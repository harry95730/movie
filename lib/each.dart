// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/clas.dart';

class MyPage extends StatefulWidget {
  Bloc harry;
  MyPage({super.key, required this.harry});

  @override
  State<MyPage> createState() => _MyPageState();
}

String img = '';

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    img = widget.harry.images[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ima(img),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.harry.title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${widget.harry.price.toString()}',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.harry.description,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 90,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.harry.images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildiy(widget.harry.images[index]);
                  }),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(12.0),
        ),
        child: const Text(
          'BUY NOW',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
