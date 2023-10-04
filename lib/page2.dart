import 'package:flutter/material.dart';
import 'package:flutter_application_1/clas.dart';
import 'package:flutter_application_1/class.dart';
import 'package:photo_view/photo_view.dart';

class Eachbloc extends StatefulWidget {
  final Bloc text;
  const Eachbloc({
    super.key,
    required this.text,
  });

  @override
  State<Eachbloc> createState() => EachblocState();
}

class EachblocState extends State<Eachbloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: Text(
          widget.text.title,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        actions: [
          IconButton(
            alignment: Alignment.center,
            icon: Icon(
              Icons.star,
              color: widget.text.lik ? Colors.blueGrey : Colors.yellow,
            ),
            onPressed: () {
              widget.text.lik = !widget.text.lik;
              Servi().update(widget.text);

              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: PhotoView(
              imageProvider: NetworkImage(widget.text.imgurl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              enableRotation: true,
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.text.title,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
