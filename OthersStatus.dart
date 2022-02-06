// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

class OthersStatus extends StatelessWidget {
  const OthersStatus(
      {Key key,
      this.imageName,
      this.name,
      this.time,
      this.isSeen,
      this.numberOfStatus})
      : super(key: key);
  final String name;
  final String time;
  final String imageName;
  final bool isSeen;
  final int numberOfStatus;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomPaint(
        painter: StatusPainter(isSeen: isSeen, numberOfStatus: numberOfStatus),
        child: CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(imageName),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
        "Today at , $time",
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}

degreeToAngle(double degree) {
  return degree * pi / 180;
}

class StatusPainter extends CustomPainter {
  bool isSeen;
  int numberOfStatus;
  StatusPainter({this.isSeen, this.numberOfStatus});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 10.0
      ..color = isSeen ? Colors.grey : Color(0xff21bfa6)
      ..style = PaintingStyle.stroke;
    drawArc(canvas, size, paint);
  }

  void drawArc(Canvas canvas, Size size, Paint paint) {
    if (numberOfStatus == 1) {
      canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          degreeToAngle(0), degreeToAngle(360), false, paint);
    } else {
      double degree = 0;
      double arc = 360 / numberOfStatus;
      for (int i = 0; i < numberOfStatus; i++) {
        canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height),
            degreeToAngle(degree + 4), degreeToAngle(arc - 8), false, paint);
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
