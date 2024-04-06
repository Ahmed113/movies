import 'package:carousel_animations/carousel_animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/model/movieModel/movie_model.dart';
import '../cubits/homeCubit/home_state.dart';
import '../cubits/homeCubit/sections_cubit/now_playing_cubit.dart';
import '../cubits/homeCubit/sections_cubit/top_rated_cubit.dart';
import '../cubits/homeCubit/sections_cubit/trinding_cubit.dart';
import '../cubits/homeCubit/sections_cubit/up_coming_cubit.dart';
import '../cubits/profilCubit/profile_cubit.dart';
import '../utils/constants.dart';
import '../widgets/custom_genre_item.dart';
import '../widgets/custom_slider_bar.dart';
import '../widgets/movie_sections_row.dart';
import '../widgets/movies_section_images.dart';
import 'movie_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.user, this.fbUser});

  final User? user;
  final Map? fbUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? imgUrl;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TopRatedCubit>(context).loadMovies(false);
    BlocProvider.of<TrendingCubit>(context).loadMovies(false);
    BlocProvider.of<NowPlayingCubit>(context).loadMovies(false);
    BlocProvider.of<UpcomingCubit>(context).loadMovies(false);
  }

  @override
  Widget build(BuildContext context) {
    Iterable<String> genresValues = GENRES.values;
    List<String> genres = genresValues.toList();
    if (context.read<ProfileCubit>().photoUrl == null) {
      imgUrl = widget.user?.photoURL;
    }else{
      imgUrl = context.read<ProfileCubit>().photoUrl;
    }
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage("assets/backgroundImg8.jpg"),
            fit: BoxFit.cover,
            // opacity: .8
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // CustomTopRow(title: "Aflamak", mainAxisAlignment: MainAxisAlignment.center),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text("Hello",
                          style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                          fontFamily: "Poppins",)),
                      SizedBox(width: 5.w,),
                      Text(widget.user!= null? "${widget.user!.displayName!.split(" ").first}!":
                          "${widget.fbUser?["name"].toString().split(" ").first}",
                          style: TextStyle(
                              fontSize: 25.sp,
                              color: Colors.white,
                          fontFamily: "Poppins",
                          fontStyle: FontStyle.italic,)),
                      const Spacer(flex: 1,),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(100),),
                        child: imgUrl != null || widget.fbUser !=null ? Image.network(
                          // widget.user!=null? "${widget.user?.photoURL}":
                          imgUrl!=null? imgUrl!:
                          "${widget.fbUser?["picture"]["data"]["url"]}",
                          width: 70.w,
                          height: 65.h,
                          fit: BoxFit.fill,
                        ):Image.asset(
                          "assets/person.jpg",
                          width: 70.w,
                          height: 65.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Text('AFLAMAK',
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white70,
                    fontFamily: "LobsterTwo")),
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
                BlocBuilder<UpcomingCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeStateLoading) {
                      return SizedBox(
                        height: 215.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is HomeUpComingState) {
                      return SizedBox(
                        height: 300.h,
                        child: Swiper(
                            itemCount: 10,
                            // control: SwiperControl(),
                            loop: true,
                            pagination: SwiperCustomPagination(
                                builder: (context, config) {
                              int i;
                              return CustomSliderBar(config: config,);
                            }),
                            // outer: true,
                            // padding: const EdgeInsets.symmetric(vertical: 10),
                            // shrinkWrap: true,
                            // layout: SwiperLayout.CUSTOM,
                            // customLayoutOption:
                            // CustomLayoutOption(startIndex: -1, stateCount: 3)
                            //   ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
                            //   ..addTranslate([
                            //     const Offset(-370.0, -40.0),
                            //     const Offset(0.0, 0.0),
                            //     const Offset(370.0, -40.0)
                            //   ]),
                            itemWidth: 300.0,
                            itemHeight: 150.0,
                            viewportFraction: .7,
                            scale: .8,
                            onTap: (index) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MovieDetails(
                                            movieModel:
                                                state.movies[index],
                                          )));
                            },
                            autoplay: true,
                            autoplayDelay: 4000,
                            autoplayDisableOnInteraction: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              MovieModel movieItem =
                                  state.movies[index];
                              return Image.network(
                                  '$MOVIE_IMG_BASE_URL/w200${movieItem.posterPath}',
                                  fit: BoxFit.fill);
                            }),
                      );
                    } else if (state is HomeStateFailed) {
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
                  },
                ),
                SizedBox(
                  height: 35.h,
                ),
                const MovieSectionsRow(sectionName: 'Top Rated'),
                BlocBuilder<TopRatedCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeStateLoading) {
                        return SizedBox(
                          height: 215.h,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is HomeTopRatedState) {
                        return SizedBox(
                          height: 264.h,
                          child: Swiper(
                              itemCount: 10,
                              // physics: const ScrollPhysics(),
                              // controller: _nowPlayingScrollController,
                              // padding: const EdgeInsets.symmetric(vertical: 10),
                              // shrinkWrap: true,
                              viewportFraction: .7,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return MoviesSectionItems(
                                  movieModel: state.movies[index],
                                  isUpcoming: false,
                                );
                              }),
                        );
                      } else if (state is HomeStateFailed) {
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
                            child: Text('There is something error',style: TextStyle(color: Colors.white70),),
                          ),
                        );
                      }
                    }),
                const MovieSectionsRow(sectionName: 'Trending'),
                BlocBuilder<TrendingCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeStateLoading) {
                        print("xxxxxxxxxxxxxxxxx: $state");
                        return SizedBox(
                          height: 215.h,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is HomeTrendingState) {
                        print("xxxxxxxxxxxxxxxxx: $state");
                        return SizedBox(
                          height: 264.h,
                          child: Swiper(
                              itemCount: 10,
                              // physics: const ScrollPhysics(),
                              // controller: _nowPlayingScrollController,
                              // padding: const EdgeInsets.symmetric(vertical: 10),
                              // shrinkWrap: true,
                              viewportFraction: .7,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return MoviesSectionItems(
                                  movieModel: state.movies[index],
                                  isUpcoming: false,
                                );
                              }),
                        );
                      } else if (state is HomeStateFailed) {
                        print("xxxxxxxxxxxxxxxxx: $state");
                        return SizedBox(
                          height: 215.h,
                          child: Center(
                            child: Text(state.exp),
                          ),
                        );
                      } else {
                        print("xxxxxxxxxxxxxxxxx: $state");
                        return SizedBox(
                          height: 215.h,
                          child: const Center(
                            child: Text('There is something error'),
                          ),
                        );
                      }
                    }),
                const MovieSectionsRow(sectionName: 'Now Playing'),
                BlocBuilder<NowPlayingCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeStateLoading) {
                        return SizedBox(
                          height: 215.h,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is HomeNowPlayingState) {
                        return SizedBox(
                          height: 264.h,
                          child: Swiper(
                              itemCount: 10,
                              // physics: const ScrollPhysics(),
                              // controller: _nowPlayingScrollController,
                              // padding: const EdgeInsets.symmetric(vertical: 10),
                              // shrinkWrap: true,
                              viewportFraction: .7,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return MoviesSectionItems(
                                  movieModel: state.movies[index],
                                  isUpcoming: false,
                                );
                              }),
                        );
                      } else if (state is HomeStateFailed) {
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
