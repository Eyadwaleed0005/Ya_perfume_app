import 'package:flutter/material.dart';

class QuestionBackground extends StatelessWidget {
  final Color backGroundColor;
  final Color primaryColor;
  final Color secondaryColor;

  const QuestionBackground({
    super.key,
    required this.backGroundColor,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: 1.2,
      scaleY: 1.0,
      child: Container(
        color: backGroundColor,
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.0, -0.15),
              radius: 0.75,
              colors: [
                primaryColor.withValues(alpha: 0.14),
                secondaryColor.withValues(alpha: 0.07),
                //secondaryColor.withValues(alpha: 0.05),
                Colors.transparent,
              ],
              stops: const [0.0, 0.45, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
