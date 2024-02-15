import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/homeCubit/home-cubit.dart';
import '../cubits/homeCubit/home-state.dart';
import '../widgets/build_movies_list.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeTrendingCubit>(context).loadTrendingMovies(true);
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
            const Text('Trending'),
            BlocBuilder<HomeTrendingCubit, HomeTrendingState>(builder: (context, state) {
              if (state is HomeStateTrendingLoading) {
                return SizedBox(
                  height: 215.h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is HomeStateTrendingSuccess) {
                return BuildMoviesList(scrollController: _scrollController, moviesList: state.trendingMovies);
              }
              else if (state is HomeTrendingStateFailed) {
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