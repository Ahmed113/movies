import 'package:carousel_animations/carousel_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomSliderBar extends StatelessWidget {
  const CustomSliderBar({
    super.key, required this.config,
  });

  final SwiperPluginConfig config;

  @override
  Widget build(BuildContext context) {
    int i;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for ( i = 0; i < config.itemCount; i++)
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(4),
              height: i == config.activeIndex ? 3.h : 2.h,
              width: i == config.activeIndex ? 18.w : 15.w,
              decoration: BoxDecoration(
                  color:
                      i == config.activeIndex ? Colors.white70 : Colors.white24,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            ),
        ],
      ),
    );
  }
}
