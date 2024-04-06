import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/genre_screen.dart';
import '../utils/constants.dart';


class CustomGenreItem extends StatelessWidget {
  CustomGenreItem({
    super.key,
    this.genre,
    // this.onTap,
    this.genres
  });

  int? genre;
  String? genres;
  // void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        genre != null? Navigator.push(context,
        MaterialPageRoute(builder: (context)=> GenreScreen(genre: GENRES[genre]!))):
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> GenreScreen(genre: genres!)));
      },
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
          color: const Color(0xffE76402),
          borderRadius: BorderRadius.circular(40),
          // color: Colors.
        ),
        child: genre != null? Text(
          '${GENRES[genre]}',
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white70),
        ):Text(
          genres!,
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white70),
        ),
      ),
    );
  }
}