import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/model/movieModel/movie_model.dart';
import '../screens/movie_details.dart';
import '../utils/constants.dart';

class MoviesSectionItems extends StatelessWidget {
  const MoviesSectionItems({
    super.key, required this.movieModel, required this.isUpcoming,
  });

  final MovieModel movieModel;
  final bool isUpcoming;
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
              BorderRadius.all(Radius.circular(20)),
            ),
            child: Container(
              height: 200.h ,
              width: 280.w,
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
          isUpcoming == false? SizedBox(
            width: 110.w,
            child: Center(
              child: Text('${movieModel.title}',style: TextStyle(
                color: Colors.white70,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600
              ),
              maxLines: 1,
                overflow: TextOverflow.ellipsis,),
            ),
          ):const SizedBox()
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