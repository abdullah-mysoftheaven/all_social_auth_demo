import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/Colors.dart';


class RoundedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final paint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo((width / 2) - 16, 80)
      ..arcToPoint(
        Offset((width / 2) + 16, 80),
        radius: Radius.circular(22),
        clockwise: true,
      )
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}









class PlayButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = appColor
      ..style = PaintingStyle.fill;

    double radius = 4.0.r; // Radius for the rounded corners

    Path path = Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - radius, size.height / 2 - radius)
      ..quadraticBezierTo(size.width, size.height / 2, size.width - radius, size.height / 2 + radius)
      ..lineTo(radius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - radius)
      ..lineTo(0, radius)
      ..quadraticBezierTo(0, 0, radius, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}