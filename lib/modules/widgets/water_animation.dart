// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_fuzzy/models/water_painter_model.dart';
import 'package:flutter_fuzzy/themes/app_colors.dart';

class WaterAnimation extends StatefulWidget {
  final Duration duration;
  double firstValue = 0;
  double secondValue = 0;
  double thirdValue = 0;
  double fourthValue = 0;

  WaterAnimation({
    super.key,
    required this.duration,
    required this.firstValue,
    required this.secondValue,
    required this.thirdValue,
    required this.fourthValue,
  });

  @override
  State<WaterAnimation> createState() => _WaterAnimationState();
}

class _WaterAnimationState extends State<WaterAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: widget.duration,
    );
  }

  @override
  void didUpdateWidget(WaterAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.duration;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      decoration: BoxDecoration(
        color: AppColors.SELECTIVE_YELLOW.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          CustomPaint(
            painter: WaterPainter(
              widget.firstValue,
              widget.secondValue,
              widget.thirdValue,
              widget.fourthValue,
            ),
            child: SizedBox(
              height: 264,
              width: size.width,
            ),
          ),
          const Center(
            child: Text('TANK WATER',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  wordSpacing: 3,
                  color: AppColors.PRUSSIAN_BLUE,
                ),
                textScaleFactor: 3),
          ),
        ],
      ),
    );
  }
}
