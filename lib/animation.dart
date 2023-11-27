// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

class MovingZ extends StatefulWidget {
  const MovingZ({super.key});

  @override
  _MovingZState createState() => _MovingZState();
}

class _MovingZState extends State<MovingZ> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String currentImagePath = 'assets/images/i1.jpg';
  bool c = false;
  bool d = false;
  final List<String> imagePaths = [
    'assets/images/i1.jpg',
    'assets/images/i12.jpg',
    'assets/images/i3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _controller.repeat(reverse: true);
    f();
  }

  void f() async {
    await Future.delayed(const Duration(milliseconds: 3350), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MyApp()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.shade300,
                Colors.black38,
                Colors.red.shade50,
                Colors.black54
              ],
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                for (var i = 0; i < 1; i++)
                  Positioned(
                    left: i * 30.0,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        double xPos = _controller.value * 20;
                        if (i == 0) {
                          xPos = _controller.value * 20 * 5;
                        }
                        return Transform.translate(
                          offset: Offset(xPos, 0),
                          child: child,
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                double rotation = _controller.value * 3.142 * 2;
                                return Transform.rotate(
                                    angle: rotation, child: te());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget te() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 85.0,
          fontFamily: 'Montserrat',
          decoration: TextDecoration.none,
        ),
        children: <TextSpan>[
          const TextSpan(
            text: 'M',
            style: TextStyle(
              fontSize: 85.0,
              fontFamily: 'Montserrat',
              decoration: TextDecoration.none,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: 'o',
            style: TextStyle(
              fontSize: 85.0,
              fontFamily: 'Montserrat',
              decoration: TextDecoration.none,
              color: Colors.cyan.shade50,
            ),
          ),
          const TextSpan(
            text: 'v',
            style: TextStyle(
              fontSize: 85.0,
              fontFamily: 'Montserrat',
              decoration: TextDecoration.none,
              color: Colors.redAccent,
            ),
          ),
          TextSpan(
            text: 'i',
            style: TextStyle(
              fontSize: 85.0,
              fontFamily: 'Montserrat',
              decoration: TextDecoration.none,
              color: Colors.cyan.shade50,
            ),
          ),
          const TextSpan(
            text: 'Z',
            style: TextStyle(
              fontSize: 85.0,
              fontFamily: 'Montserrat',
              decoration: TextDecoration.none,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
