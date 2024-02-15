import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/cubits/homeCubit/home-state.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/widgets/custom_genre_item.dart';

import '../cubits/homeCubit/home-cubit.dart';
import '../widgets/movie_sections_row.dart';
import '../widgets/movies_section_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _topRatedScrollController = ScrollController();
  final ScrollController _trendingScrollController = ScrollController();
  final ScrollController _nowPlayingScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeTopRatedCubit>(context).loadTopRatedMovies(false);
    BlocProvider.of<HomeTrendingCubit>(context).loadTrendingMovies(false);
    BlocProvider.of<HomeNowPlayingCubit>(context).loadNowPlayingMovies(false);
    // _topRatedScrollController.addListener(_topRatedScroll);
    // _trendingScrollController.addListener(_trendingScroll);
    // _nowPlayingScrollController.addListener(_nowPlayingScroll);
  }

  void _topRatedScroll() {
    if (_topRatedScrollController.position.isScrollingNotifier.value) {
      BlocProvider.of<HomeTopRatedCubit>(context).loadTopRatedMovies(false);
    }
  }

  // void _trendingScroll() {
  //   if (_topRatedScrollController.position.isScrollingNotifier.value) {
  //     BlocProvider.of<HomeTrendingCubit>(context).loadTrendingMovies();
  //   }
  // }
  // void _nowPlayingScroll() {
  //   if (_topRatedScrollController.position.isScrollingNotifier.value) {
  //     BlocProvider.of<HomeNowPlayingCubit>(context).loadNowPlayingMovies();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Iterable<String> genresValues = GENRES.values;
    List<String> genres = genresValues.toList();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('AFLAMAK',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.h),
              SizedBox(
                height: 40.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // padding: const EdgeInsets.all( 12),
                    // padding: const EdgeInsets.symmetric(horizontal: 12),
                    shrinkWrap: true,
                    itemCount: genres.length,
                    itemBuilder: (context, index) {
                      return CustomGenreItem(
                        genres: genres[index],
                      );
                    }),
              ),
              SizedBox(
                height: 20.h,
              ),
              const MovieSectionsRow(sectionName: 'Top Rated'),
              BlocBuilder<HomeTopRatedCubit, HomeTopRatedState>(
                  builder: (context, state) {
                if (state is HomeStateTopRatedLoading) {
                  // return state.isLoading == true
                  //     ?
                  return SizedBox(
                    height: 215.h,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is HomeStateTopRatedSuccess) {
                  return SizedBox(
                    height: 264.h,
                    child: ListView.builder(
                        itemCount: 10,
                        // physics: const ScrollPhysics(),
                        controller: _topRatedScrollController,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return MoviesSectionItems(
                              movieModel: state.topRatedMovies[index]);
                        }),
                  );
                } else if (state is HomeTopRatedStateFailed) {
                  return SizedBox(
                    height: 215.h,
                    child: Center(
                      child: Text(state.exp),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 215.h,
                    child: const Center(
                      child: Text('There is something error'),
                    ),
                  );
                }
              }),
              const MovieSectionsRow(sectionName: 'Trending'),
              BlocBuilder<HomeTrendingCubit, HomeTrendingState>(
                  builder: (context, state) {
                if (state is HomeStateTrendingLoading) {
                  return SizedBox(
                    height: 215.h,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is HomeStateTrendingSuccess) {
                  // return state.trendingMovies.isNotEmpty?
                  return SizedBox(
                    height: 264.h,
                    child: ListView.builder(
                        itemCount: 10,
                        // physics: const ScrollPhysics(),
                        // controller: _trendingScrollController,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return MoviesSectionItems(
                              movieModel: state.trendingMovies[index]);
                        }),
                  );
                } else if (state is HomeTrendingStateFailed) {
                  return SizedBox(
                    height: 215.h,
                    child: Center(
                      child: Text(state.exp),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 215.h,
                    child: const Center(
                      child: Text('There is something error'),
                    ),
                  );
                }
              }),
              const MovieSectionsRow(sectionName: 'Now Playing'),
              BlocBuilder<HomeNowPlayingCubit, HomeNowPlayingState>(
                  builder: (context, state) {
                if (state is HomeStateNowPlayingLoading) {
                  return SizedBox(
                    height: 215.h,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is HomeStateNowPlayingSuccess) {
                  return SizedBox(
                    height: 264.h,
                    child: ListView.builder(
                        itemCount: 10,
                        // physics: const ScrollPhysics(),
                        // controller: _nowPlayingScrollController,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return MoviesSectionItems(
                              movieModel: state.nowPlayingMovies[index]);
                        }),
                  );
                } else if (state is HomeNowPlayingStateFailed) {
                  return SizedBox(
                    height: 215.h,
                    child: Center(
                      child: Text(state.exp),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 215.h,
                    child: const Center(
                      child: Text('There is something error'),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
// BlocBuilder<HomeCubit, HomeState>(
// builder: (context, state) {
// if (state is HomeStateLoading) {
// return Column(
// children: [
// const MovieSectionsRow(
// sectionName: 'Top Rated',
// ),
// state.isTopRatedLoading? SizedBox(
// height: 215.h,
// child: const Center(
// child: CircularProgressIndicator()))
//     : SizedBox(
// height: 264.h,
// child: ListView.builder(
// itemCount: 10,
// // physics: const ScrollPhysics(),
// controller: _scrollController,
// padding: const EdgeInsets.symmetric(
// vertical: 10),
// shrinkWrap: true,
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) {
// return MoviesSectionItems(
// movieModel:
// state.topRatedMovies![index]);
// }),
// ),
// const MovieSectionsRow(
// sectionName: 'Trending',
// ),
// state.isTrendingLoading == true
// ? SizedBox(
// height: 215.h,
// child: const Center(
// child: CircularProgressIndicator()))
//     : SizedBox(
// height: 259.h,
// child: ListView.builder(
// itemCount: 10,
// // physics: const ScrollPhysics(),
// padding: const EdgeInsets.symmetric(
// vertical: 10),
// shrinkWrap: true,
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) {
// return MoviesSectionItems(
// movieModel:
// state.trendingMovies![index],
// );
// }),
// ),
// const MovieSectionsRow(
// sectionName: 'Now Playing',
// ),
// state.isNowPlayingLoading == true
// ? SizedBox(
// height: 215.h,
// child: const Center(
// child: CircularProgressIndicator()))
//     : SizedBox(
// height: 259.h,
// child: ListView.builder(
// itemCount: 10,
// // physics: const ScrollPhysics(),
// padding: const EdgeInsets.symmetric(
// vertical: 10),
// shrinkWrap: true,
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) {
// return MoviesSectionItems(
// movieModel:
// state.newPlayingMovies![index],
// );
// }),
// ),
// ],
// );
// } else if (state is HomeStateSuccess) {
// return Column(
// children: [
// const MovieSectionsRow(
// sectionName: 'Top Rated',
// ),
// SizedBox(
// height: 264.h,
// child: ListView.builder(
// itemCount: 10,
// // physics: const ScrollPhysics(),
// controller: _scrollController,
// padding: const EdgeInsets.symmetric(vertical: 10),
// shrinkWrap: true,
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) {
// return MoviesSectionItems(
// movieModel: state.topRatedMovies[index]);
// }),
// ),
// const MovieSectionsRow(
// sectionName: 'Trending',
// ),
// SizedBox(
// height: 259.h,
// child: ListView.builder(
// itemCount: 10,
// // physics: const ScrollPhysics(),
// padding: const EdgeInsets.symmetric(vertical: 10),
// shrinkWrap: true,
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) {
// return MoviesSectionItems(
// movieModel: state.trendingMovies[index],
// );
// }),
// ),
// const MovieSectionsRow(
// sectionName: 'Now Playing',
// ),
// SizedBox(
// height: 259.h,
// child: ListView.builder(
// itemCount: 10,
// // physics: const ScrollPhysics(),
// padding: const EdgeInsets.symmetric(vertical: 10),
// shrinkWrap: true,
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) {
// return MoviesSectionItems(
// movieModel: state.nowPlayingMovies[index],
// );
// }),
// ),
// ],
// );
// } else if (state is HomeStateFailed) {
// return SizedBox(
// height: 215.h,
// child: Center(
// child: Text(state.exp),
// ),
// );
// } else {
// return SizedBox(
// height: 215.h,
// child: const Center(
// child: Text('There is something error'),
// ),
// );
// }
// },
// ),

//------------------------------------
// const MovieSectionsRow(sectionName: 'Trending Movies',),
//               // SizedBox(
//               //   height: 215.h,
//               //   child: ListView.builder(
//               //       itemCount: 10,
//               //       // physics: const ScrollPhysics(),
//               //       padding: const EdgeInsets.symmetric(vertical: 10),
//               //       shrinkWrap: true,
//               //       scrollDirection: Axis.horizontal,
//               //       itemBuilder: (context, index) {
//               //         return MoviesSectionImages(topRatedMovie: MovieModel(),);
//               //       }),
//               // ),
//               // const MovieSectionsRow(sectionName: 'Trending Movies',),
//               // SizedBox(
//               //   height: 215.h,
//               //   child: ListView.builder(
//               //       itemCount: 10,
//               //       // physics: const ScrollPhysics(),
//               //       padding: const EdgeInsets.symmetric(vertical: 10),
//               //       shrinkWrap: true,
//               //       scrollDirection: Axis.horizontal,
//               //       itemBuilder: (context, index) {
//               //         return MoviesSectionImages(topRatedMovie: MovieModel());
//               //       }),
//               // ),
