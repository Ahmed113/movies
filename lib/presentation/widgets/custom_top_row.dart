import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTopRow extends StatelessWidget {
  CustomTopRow({
    super.key,
    required this.title,
    this.textDirection,
    this.iconImage,
    required this.mainAxisAlignment,
    this.onPress,
    this.width,
  });

  final String title;
  TextDirection? textDirection;
  Image? iconImage;
  final MainAxisAlignment mainAxisAlignment;
  final VoidCallback? onPress;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 8),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        textDirection: textDirection,
        children: [
          InkWell(
            onTap: onPress,
            child: iconImage,


          ),
          // Spacer(flex: 1,),
          mainAxisAlignment != MainAxisAlignment.spaceBetween
              ? SizedBox(
                  width: width,
                )
              : Spacer(
                  flex: 1,
                ),
          Text(
            //aaaaa
            title,
            style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.white70
                  ),
          ),
          if (mainAxisAlignment == MainAxisAlignment.spaceBetween &&
              textDirection == TextDirection.ltr)
            Spacer(
              flex: 1,
            )
        ],
      ),
    );
  }
}
