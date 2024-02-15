import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/cubits/homeCubit/home-cubit.dart';
import 'package:movies/fetchMovieData/movies_search_data.dart';
import 'package:movies/fetchMovieData/now-playing-movies-data.dart';
import 'package:movies/fetchMovieData/top-rated-movies-data.dart';
import 'package:movies/fetchMovieData/trending-movies-data.dart';
import 'package:movies/screens/search_screen.dart';
import 'package:movies/screens/splash_screen.dart';
import 'package:movies/services/cast_service.dart';
import 'package:movies/services/movie_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/services/now-playing-movies.dart';
import 'package:movies/services/top-rated-movies.dart';
import 'package:movies/services/trending-movies.dart';
import 'cubits/castCubit/cast_cubit.dart';
import 'cubits/searchCubit/search_movie_cubit.dart';


void main() {
  runApp( MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (BuildContext context) {
            return SearchMoviesCubit(MoviesSearchData(MovieSearch()));
          },
      ),
      BlocProvider(
          create: (BuildContext context) {
            return CastCubit(CastService());
          },
      ),
      BlocProvider(
          create: (BuildContext context){
            return HomeTopRatedCubit(TopRatedMoviesData(TopRatedMoviesService()),);
      }),
      BlocProvider(
          create: (BuildContext context){
            return HomeTrendingCubit(TrendingMoviesData(TrendingMoviesService()),);
      }),
      BlocProvider(
          create: (BuildContext context){
            return HomeNowPlayingCubit(NowPlayingMoviesData(NowPlayingMoviesService()),);
      }),
    ], child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies',
        home: SplashScreen(),

      ),
    );
  }
}

