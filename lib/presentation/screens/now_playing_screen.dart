import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubits/homeCubit/home_state.dart';
import '../cubits/homeCubit/sections_cubit/now_playing_cubit.dart';
import '../widgets/build_movies_list.dart';
import '../widgets/custom_top_row.dart';


class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreen();
}

class _NowPlayingScreen extends State<NowPlayingScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NowPlayingCubit>(context).loadMovies(true);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 0.1) {
      BlocProvider.of<NowPlayingCubit>(context).loadMovies(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CustomTopRow(
            title: "Now Playing",
            textDirection: TextDirection.ltr,
            iconImage: Image.asset("assets/arrow-left.png", height: 25, color: Colors.white70,),
            onPress: () {
              Navigator.pop(context);
            },
            mainAxisAlignment: MainAxisAlignment.spaceBetween),
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
            return BuildMoviesList(
                scrollController: _scrollController,
                moviesList: state.movies);
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
    ));
  }
}
