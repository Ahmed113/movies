import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/model/movieModel/movie_model.dart';
import '../screens/movie_details.dart';
import '../utils/constants.dart';


class CustomMovieItem extends StatefulWidget {
  const CustomMovieItem({super.key, required this.movieModel});

  final MovieModel movieModel;

  @override
  State<CustomMovieItem> createState() => _CustomMovieItemState();
}

class _CustomMovieItemState extends State<CustomMovieItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetails(
                      movieModel: widget.movieModel,
                    )));
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          side: BorderSide(color: Colors.black.withOpacity(.1)),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                '$MOVIE_IMG_BASE_URL/w200${widget.movieModel.posterPath}',
              ),
              fit: BoxFit.fill,
              colorFilter: const ColorFilter.mode(
                Colors.black26,
                BlendMode.darken,
              ),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20.h,
                      width: 35.w,
                      // padding: EdgeInsets.all(7),
                      // margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xffFD9803),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star_rounded,
                              color: Colors.white, size: 14.sp),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            widget.movieModel.voteAverage
                                .toString()
                                .split('.')
                                .first,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      '${widget.movieModel.title}',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(.88)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
