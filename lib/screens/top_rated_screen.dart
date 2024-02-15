import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/cubits/homeCubit/home-cubit.dart';
import 'package:movies/cubits/homeCubit/home-state.dart';
import 'package:movies/movieModel/movie_model.dart';
import 'package:movies/widgets/build_movies_list.dart';

import '../widgets/movies_section_images.dart';

class TopRatedScreen extends StatefulWidget {
  const TopRatedScreen({super.key});

  @override
  State<TopRatedScreen> createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeTopRatedCubit>(context).loadTopRatedMovies(true);
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
            const Text('Top Rated'),
            BlocBuilder<HomeTopRatedCubit, HomeTopRatedState>(builder: (context, state) {
              if (state is HomeStateTopRatedLoading) {
                return SizedBox(
                  height: 215.h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is HomeStateTopRatedSuccess) {
                return BuildMoviesList(scrollController: _scrollController, moviesList: state.topRatedMovies);
              }
              else if (state is HomeTopRatedStateFailed) {
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
