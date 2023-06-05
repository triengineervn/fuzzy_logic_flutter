import 'package:flutter/material.dart';
import 'package:flutter_fuzzy/themes/app_colors.dart';

class WaterPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;

  WaterPainter(this.firstValue, this.secondValue, this.thirdValue, this.fourthValue);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColors.BLUE_GREEN.withOpacity(.8)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, 232 - firstValue)
      ..cubicTo(size.width * .4, 232 - secondValue, size.width * .7, 232 - thirdValue, size.width,
          232 - fourthValue)
      ..lineTo(size.width, 232)
      ..lineTo(0, 232);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
