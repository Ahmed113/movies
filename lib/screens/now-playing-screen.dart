import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/homeCubit/home-cubit.dart';
import '../cubits/homeCubit/home-state.dart';
import '../widgets/build_movies_list.dart';

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
    BlocProvider.of<HomeNowPlayingCubit>(context).loadNowPlayingMovies(true);
    // _scrollController.addListener(_onScroll);
  }

  // void _onScroll() {
  //   if (_scrollController.position.isScrollingNotifier.value) {
  //     BlocProvider.of<HomeTopRatedCubit>(context).loadTopRatedMovies();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const Text('Now Playing'),
            BlocBuilder<HomeNowPlayingCubit, HomeNowPlayingState>(builder: (context, state) {
              if (state is HomeStateNowPlayingLoading) {
                return SizedBox(
                  height: 215.h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is HomeStateNowPlayingSuccess) {
                return BuildMoviesList(scrollController: _scrollController, moviesList: state.nowPlayingMovies);
              }
              else if (state is HomeNowPlayingStateFailed) {
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
        )
    );
  }
}