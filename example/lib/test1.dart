import 'package:flutter/material.dart';

class IntersectionExample extends StatelessWidget {
  const IntersectionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 50,
            top: 50,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
          Positioned(
            left: 100,
            top: 100,
            child: ClipPath(
              clipper: IntersectionClipper(),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IntersectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Define the intersection area to be cut out
    path.addRect(Rect.fromLTWH(0, 0, 50, 50));
    return Path.combine(PathOperation.reverseDifference, path, path);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
