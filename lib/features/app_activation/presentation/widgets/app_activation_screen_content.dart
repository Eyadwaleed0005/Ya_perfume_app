import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/widgets/custom_button.dart';
import 'package:ya_perfume/features/app_activation/presentation/widgets/developers_message_widget.dart';
import 'package:ya_perfume/features/app_activation/presentation/widgets/fame_x_logo.dart';

class AppActivationScreenContent extends StatelessWidget {
  final bool isChecking;
  final VoidCallback onCheckActivation;

  const AppActivationScreenContent({
    super.key,
    required this.isChecking,
    required this.onCheckActivation,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        fit: StackFit.expand,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final topPadding = 88.h;
              final bottomPadding = 32.h;
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  32.w,
                  topPadding,
                  32.w,
                  bottomPadding,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        (constraints.maxHeight - topPadding - bottomPadding)
                            .clamp(0.0, double.infinity)
                            .toDouble(),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 620.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const FameXLogo(),
                          verticalSpace(32),
                          Container(
                            width: 64.w,
                            height: 2.h,
                            color: AppColors.borderAccent,
                          ),
                          verticalSpace(24),
                          Text(
                            'شكرًا لحسن تعاونكم معنا',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.font24textAccentSemiBoldNoto(),
                          ),
                          verticalSpace(12),
                          Text(
                            'تم إيقاف تفعيل التطبيق لحين استكمال سداد '
                            'المستحقات المتفق عليها.',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.font18textMutedRegularNoto()
                                .copyWith(height: 1.8),
                          ),
                          verticalSpace(10),
                          Text(
                            'نراكم في أعمال أخرى',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.font20TextAccentRegularNoto(),
                          ),
                          verticalSpace(28),
                          CustomButton(
                            text: 'التحقق من التفعيل',
                            width: 260.w,
                            height: 52.h,
                            foreground: AppColors.textDark,
                            background: AppColors.bgAccent,
                            isLoading: isChecking,
                            onPressed: onCheckActivation,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 16.h,
            left: 16.w,
            right: 16.w,
            child: const Align(
              alignment: Alignment.topLeft,
              child: DevelopersMessageWidget(
                videoAssetPath: 'assets/videos/developers_message.mp4',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
