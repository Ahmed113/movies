import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.textEditingController,
    this.onSubmitted, this.image, this.suffixIconColor,
    this.hintText, this.fillColor
  });

  final TextEditingController textEditingController;
  void Function(String)? onSubmitted;
  ImageProvider<Object>? image;
  Color? suffixIconColor;
  String? hintText;
  Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.blueGrey,
      controller: textEditingController,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: ImageIcon(
           image,
          color: suffixIconColor,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 19.sp, color: Colors.blueGrey.withOpacity(.8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Color(0xffE76402),
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
          const BorderSide(color: Color(0xffE7ECDF), width: 2.0),
        ),
        filled: true,
        fillColor: fillColor,
      ),
      style: TextStyle(fontSize: 19.sp),
    );
  }
}