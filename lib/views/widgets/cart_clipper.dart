import 'package:flutter/material.dart';

class CartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    path.quadraticBezierTo(size.width * 0.65, size.height * 0.04,
        size.width * 0.69, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.82, size.height * 0.75,
        size.width * .35, size.height * 0.72);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.7, 0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
