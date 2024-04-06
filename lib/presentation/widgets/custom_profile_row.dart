import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_profile_icon.dart';

class CustomProfileRow extends StatelessWidget {
  CustomProfileRow({
    super.key,
    required this.containerColor,
    required this.icon,
    required this.iconColor,
    required this.text
  });

  Color containerColor;
  Color iconColor;
  IconData icon;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CustomProfileIcons(containerColor: containerColor, iconColor: iconColor, icon: icon,),
          SizedBox(width: 8.w,),
          Text(text, style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              fontFamily: "Poppins"
          )),
          Spacer(flex: 1,),
          Icon(Icons.arrow_forward_ios_outlined, color: Colors.white,),
        ],
      ),
    );
  }
}