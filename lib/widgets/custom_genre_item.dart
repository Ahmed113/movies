import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/movieModel/movie_model.dart';
import 'package:movies/screens/movie_details.dart';
import 'package:movies/utils/constants.dart';

class CustomGenreItem extends StatelessWidget {
  CustomGenreItem({
    super.key,
    this.genre, this.onTap,
    this.genres
  });

  int? genre;
  String? genres;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        // margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xffFD9803),
          borderRadius: BorderRadius.circular(40),
        ),
        child: genre != null? Text(
          '${GENRES[genre]}',
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ):Text(
          genres!,
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
      ),
    );
  }
}