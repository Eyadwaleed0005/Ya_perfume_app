import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ya_perfume/core/helper/spacer.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/features/app_activation/presentation/widgets/developers_video_dialog.dart';

class DevelopersMessageWidget extends StatelessWidget {
  final String videoAssetPath;

  const DevelopersMessageWidget({super.key, required this.videoAssetPath});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(18.r),
      topRight: Radius.circular(18.r),
      bottomRight: Radius.circular(18.r),
      bottomLeft: Radius.circular(4.r),
    );

    return Material(
      color: AppColors.bgSurfaceRaised,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(
          color: AppColors.borderAccent.withValues(alpha: 0.45),
          width: 1.w,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (_) =>
                DevelopersVideoDialog(videoAssetPath: videoAssetPath),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.rtl,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.mark_chat_unread_outlined,
                    size: 25.r,
                    color: AppColors.goldAccentLight,
                  ),
                  Positioned(
                    top: -2.r,
                    right: -2.r,
                    child: Container(
                      width: 7.r,
                      height: 7.r,
                      decoration: const BoxDecoration(
                        color: AppColors.goldAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              horizontalSpace(12),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      'هناك رسالة من المطورين',
                      textDirection: TextDirection.rtl,
                      style: AppTextStyle.font15textAccentRegularNoto(),
                    ),
                    verticalSpace(3),
                    Text(
                      'اضغط لمشاهدة الرسالة',
                      textDirection: TextDirection.rtl,
                      style: AppTextStyle.font15textMutedRegularNoto().copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(12),
              Icon(
                Icons.play_circle_outline_rounded,
                size: 20.r,
                color: AppColors.textAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
