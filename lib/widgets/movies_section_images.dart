import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/fetchMovieData/top-rated-movies-data.dart';
import 'package:movies/movieModel/movie_model.dart';

import '../screens/movie_details.dart';
import '../services/top-rated-movies.dart';
import '../utils/constants.dart';

class MoviesSectionItems extends StatelessWidget {
  const MoviesSectionItems({
    super.key, required this.movieModel,
  });

  final MovieModel movieModel;
  // TopRatedMovies topRatedMovies = TopRatedMovies();
  @override
  Widget build(BuildContext context) {
    // TopRatedMoviesData topRatedMoviesData = TopRatedMoviesData(topRatedMovies);
    // topRatedMoviesData.getTopRatedMoviesData(page: 1);
    // print('rrrrrrrrrr${topRatedMoviesData.movies.length}');
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetails(
                  movieModel: movieModel,
                )));
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(15)),
            ),
            child: Container(
              height: 215.h ,
              width: 130.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(
                    '$MOVIE_IMG_BASE_URL/w200${movieModel.posterPath}',
                  ),
                  fit: BoxFit.fill,
                  colorFilter: const ColorFilter.mode(
                    Colors.black26,
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 110.w,
            child: Center(
              child: Text('${movieModel.title}',style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600
              ),
              maxLines: 1,
                overflow: TextOverflow.ellipsis,),
            ),
          )
        ],
      ),
    );
  }
}
//ClipRRect(
//         borderRadius: const BorderRadius.all(Radius.circular(15)),
//         child: Image.network(
//           '$MOVIE_IMG_BASE_URL/w300${topRatedMovie.backdropPath}' ,
//           width: 130.w,
//           height: 215.h,
//           fit: BoxFit.fill,
//         ),
//       )