import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/movieModel/cast_model.dart';

class CustomCastItem extends StatelessWidget {
  const CustomCastItem({
    super.key,
    required this.casts,
    required this.movieImgBaseUrl, required this.index,
  });

  final List<CastModel?> casts;
  final String movieImgBaseUrl;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                  Radius.circular(50)),
              side: BorderSide(
                  color: Colors.black
                      .withOpacity(.1)),
            ),
            child: Container(
              width: 98.w,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(50),
                image: DecorationImage(
                  image: casts[index]
                      ?.profilePath !=
                      null
                      ? NetworkImage(
                      '$movieImgBaseUrl/w200/${casts[index]?.profilePath}')
                      : const AssetImage(
                      'assets/person.jpg')
                  as ImageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        casts[index]?.name != null
            ? Text(
          '${casts[index]?.name?.split(' ').first}',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
          ),
        )
            : const Text(''),
        SizedBox(
          height: 5.h,
        ),
        casts[index]?.character != null
            ? Text(
          '${casts[index]?.character?.split(' ').first}',
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.black
                .withOpacity(.5),
          ),
        )
            : const Text(''),
      ],
    );
  }
}