import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:ya_perfume/core/style/app_color.dart';
import 'package:ya_perfume/core/style/textstyles.dart';
import 'package:ya_perfume/core/widgets/app_loading_indicator.dart';

class DevelopersVideoDialog extends StatefulWidget {
  final String videoAssetPath;

  const DevelopersVideoDialog({
    super.key,
    required this.videoAssetPath,
  });

  @override
  State<DevelopersVideoDialog> createState() =>
      _DevelopersVideoDialogState();
}

class _DevelopersVideoDialogState extends State<DevelopersVideoDialog> {
  late final VideoPlayerController _controller;
  late final Future<void> _initialization;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(widget.videoAssetPath);
    _initialization = _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    await _controller.initialize();

    if (!mounted) return;

    await _controller.play();
  }

  Future<void> _togglePlayback() async {
    if (_controller.value.isPlaying) {
      await _controller.pause();
      return;
    }

    if (_controller.value.position >= _controller.value.duration) {
      await _controller.seekTo(Duration.zero);
    }

    if (!mounted) return;

    await _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.bgSurface,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 24.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: const BorderSide(
          color: AppColors.borderAccent,
        ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 720.w),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'رسالة من المطورين',
                      textDirection: TextDirection.rtl,
                      style: AppTextStyle.font18TextAccentMediumNoto(),
                    ),
                  ),
                  IconButton(
                    tooltip: 'إغلاق',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: FutureBuilder<void>(
                  future: _initialization,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Text(
                          'تعذر تشغيل الفيديو.',
                          textDirection: TextDirection.rtl,
                          style: AppTextStyle.font17textMutedRegularNoto(),
                        ),
                      );
                    }

                    if (snapshot.connectionState != ConnectionState.done) {
                      return SizedBox(
                        height: 180.h,
                        child: const Center(
                          child: AppLoadingIndicator(),
                        ),
                      );
                    }

                    return ValueListenableBuilder<VideoPlayerValue>(
                      valueListenable: _controller,
                      builder: (context, value, child) {
                        if (value.hasError) {
                          return Text(
                            'تعذر تشغيل الفيديو.',
                            textDirection: TextDirection.rtl,
                            style: AppTextStyle.font17textMutedRegularNoto(),
                          );
                        }

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: AspectRatio(
                                aspectRatio: value.aspectRatio > 0
                                    ? value.aspectRatio
                                    : 16 / 9,
                                child: VideoPlayer(_controller),
                              ),
                            ),
                            VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: AppColors.goldAccent,
                                bufferedColor:
                                    AppColors.veryDarkGrayishBlue,
                                backgroundColor: AppColors.bgSurfaceRaised,
                              ),
                            ),
                            IconButton(
                              tooltip: value.isPlaying ? 'إيقاف مؤقت' : 'تشغيل',
                              onPressed: _togglePlayback,
                              icon: Icon(
                                value.isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: AppColors.goldAccent,
                                size: 32.r,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}