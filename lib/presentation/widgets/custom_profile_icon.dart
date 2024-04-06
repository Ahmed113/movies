import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileIcons extends StatelessWidget {
  CustomProfileIcons({
    super.key,
    required this.containerColor,
    required this.iconColor,
    required this.icon
  });

  Color containerColor;
  Color iconColor;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      width: 38.w,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Icon(icon,color: iconColor),
    );
  }
}