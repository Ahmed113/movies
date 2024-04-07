
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:movies/data/remote/movies_api_service.dart';
import 'package:movies/data/repo/genre_movies_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/presentation/cubits/castCubit/cast_cubit.dart';
import 'package:movies/presentation/cubits/emailVerificationCubit/email_verification_cubit.dart';
import 'package:movies/presentation/cubits/genreCubit/genre_cubit.dart';
import 'package:movies/presentation/cubits/homeCubit/sections_cubit/now_playing_cubit.dart';
import 'package:movies/presentation/cubits/homeCubit/sections_cubit/top_rated_cubit.dart';
import 'package:movies/presentation/cubits/homeCubit/sections_cubit/trinding_cubit.dart';
import 'package:movies/presentation/cubits/homeCubit/sections_cubit/up_coming_cubit.dart';
import 'package:movies/presentation/cubits/profilCubit/profile_cubit.dart';
import 'package:movies/presentation/cubits/searchCubit/search_movie_cubit.dart';
import 'package:movies/presentation/cubits/signInCubit/sign_in_cubit.dart';
import 'package:movies/presentation/cubits/signUpCubit/sign_up_cubit.dart';
import 'package:movies/presentation/screens/Authentication/Sign_in_screen.dart';
import 'package:movies/presentation/screens/bottomNavBar/bottom_nav_bar_cubit.dart';
import 'data/remote/cast_service.dart';
import 'data/repo/cast_data.dart';
import 'data/repo/movie_search_data.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterConfig.loadEnvVariables();
  // await EmailVerificationCubit().checkAndDeleteUserOnStart();
  runApp( MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (BuildContext context) {
            return SearchMoviesCubit(MoviesSearchData(MoviesApiService()));
          },
      ),
      BlocProvider(
          create: (BuildContext context) {
            return CastCubit(CastData(CastService()));
          },
      ),
      BlocProvider(create: (BuildContext context){
        return GenreCubit(GenreMoviesData(MoviesApiService()));
      }),
      BlocProvider(create: (BuildContext context){
        return BottomNavBarCubit();
      }),
      BlocProvider(create: (BuildContext context){
        return SocialSignInCubit();
      }),
      BlocProvider(create: (BuildContext context){
        return SignUpCubit();
      }),
      BlocProvider(create: (BuildContext context){
        return EmailVerificationCubit();
      }),
      BlocProvider(create: (BuildContext context){
        return ProfileCubit();
      }),
      // BlocProvider(create: (BuildContext context){
      //   return HomeMoviesCubit(TopRatedMoviesData());
      // }),
      BlocProvider(create: (BuildContext context){
        return TopRatedCubit();
      }),
      BlocProvider(create: (BuildContext context){
        return TrendingCubit();
      }),
      BlocProvider(create: (BuildContext context){
        return NowPlayingCubit();
      }),
      BlocProvider(create: (BuildContext context){
        return UpcomingCubit();
      }),
    ], child: const MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("kkkkkkkkkkkkkkk ${FlutterConfig.get('FACEBOOK_APP_ID')}");
    return const ScreenUtilInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies',
        home: SignInScreen(),

      ),
    );
  }
}

