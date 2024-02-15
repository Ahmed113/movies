import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_movie_item.dart';

class BuildMoviesList extends StatelessWidget {
  const BuildMoviesList({
    super.key,
    required ScrollController scrollController, required this.moviesList,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<dynamic> moviesList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints constraints) {
                double itemWidth = 112.w;
                int columns =
                (constraints.maxWidth / itemWidth).floor();
                return GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 14.h,
                      crossAxisSpacing: 5.w,
                      childAspectRatio: .6,
                    ),
                    itemCount: moviesList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                        return CustomMovieItem(movieModel: moviesList[index]);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}


// if (isLoading == true  )
//   Padding(
//     padding: EdgeInsets.only(top: 10, bottom: 40),
//     child: Center(
//       child: CircularProgressIndicator(),
//     ),
//   ),
//              if (hasNextPage == false)
//                Container(
//                  padding: const EdgeInsets.only(top: 10, bottom: 40),
//                  color: Colors.amber,
//                  child: const Center(
//                    child: Text('You have fetched all of the content'),
//                  ),
//                ),
