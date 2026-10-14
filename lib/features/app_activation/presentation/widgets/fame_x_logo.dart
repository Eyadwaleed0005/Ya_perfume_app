import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';

class FameXLogo extends StatelessWidget {
  const FameXLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Fame X',
      image: true,
      child: ExcludeSemantics(
        child: SizedBox(
          width: 280.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AspectRatio(
                aspectRatio: 300 / 170,
                child: CustomPaint(painter: _FameXSymbolPainter()),
              ),
              SizedBox(height: 14.h),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'F A M E '),
                      TextSpan(
                        text: 'X',
                        style: TextStyle(color: AppColors.goldAccent),
                      ),
                    ],
                  ),
                  textDirection: TextDirection.ltr,
                  style: AppTextStyle.font36textPrimarySemiBoldNoto().copyWith(
                    color: AppColors.offWhite,
                    letterSpacing: 6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FameXSymbolPainter extends CustomPainter {
  const _FameXSymbolPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 300, size.height / 170);

    final bracketPaint = Paint()
      ..color = AppColors.offWhite
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(
      Path()
        ..moveTo(48, 65)
        ..lineTo(20, 95)
        ..lineTo(48, 125),
      bracketPaint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(252, 65)
        ..lineTo(280, 95)
        ..lineTo(252, 125),
      bracketPaint,
    );

    final whitePaint = Paint()
      ..color = AppColors.offWhite
      ..style = PaintingStyle.fill;

    canvas.drawPath(
      Path()
        ..moveTo(82, 48)
        ..lineTo(110, 48)
        ..lineTo(146, 86)
        ..lineTo(132, 101)
        ..close(),
      whitePaint,
    );

    canvas.drawPath(
      Path()
        ..moveTo(168, 111)
        ..lineTo(218, 160)
        ..lineTo(189, 160)
        ..lineTo(154, 126)
        ..close(),
      whitePaint,
    );

    final arrowPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          AppColors.darkAutumnBrown,
          AppColors.goldAccent,
          AppColors.goldAccentLight,
        ],
      ).createShader(const Rect.fromLTWH(82, 6, 140, 154));

    canvas.drawPath(
      Path()
        ..moveTo(82, 160)
        ..lineTo(108, 160)
        ..lineTo(210, 46)
        ..lineTo(220, 59)
        ..lineTo(232, 6)
        ..lineTo(181, 21)
        ..lineTo(194, 32)
        ..close(),
      arrowPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _FameXSymbolPainter oldDelegate) => false;
}
