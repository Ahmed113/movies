
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget{
  CustomTextFormField({super.key,
    this.controller,
    required this.obscureText,
    this.hint,
   required this.obscuringCharacter,
    required this.prefixIcon,
    this.suffixIcon,
    this.suffixIcon2,
    this.validator,
    this.onSuffixClickIcon,
    required this.textType,
    this.aboveText,
    required this.filled
  });

  TextEditingController? controller;
  bool obscureText;
  String? hint;
  String obscuringCharacter;
  IconData prefixIcon;
  IconData? suffixIcon;
  IconData? suffixIcon2;
  String? Function(String?)? validator;
  void Function()? onSuffixClickIcon;
  TextInputType? textType;
  String? aboveText;
  bool filled;
  // Color filledColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 73,
      padding:  const EdgeInsets.symmetric(horizontal: 20,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(aboveText!,style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            fontSize: 15.sp,
            color: Colors.black.withOpacity(.5)
          ),),
          const SizedBox(height: 2,),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            obscuringCharacter: obscuringCharacter,
            validator: validator,
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Color(0xffE76402),
                    width: 2
                  ),
                ),
              filled: filled,
              fillColor: Colors.white12,
              prefixIcon: Icon(
                prefixIcon,
                color: Color(0xffE76402),
                size: 25,
              ),
              suffixIcon: IconButton(
                icon: Icon(obscureText? suffixIcon : suffixIcon2),
                onPressed: onSuffixClickIcon,
                color: const Color(0xff8C8C8C),
              ),
              border: const OutlineInputBorder(),
              hintText: hint,
              hintStyle: TextStyle(fontSize: 13.sp),
              contentPadding: const EdgeInsets.only(top: 15)
            ),
            keyboardType: textType,
            // autofocus: true,
          ),
          SizedBox(height: 10.h)
        ],
      ),
    );
  }

}