import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubits/homeCubit/home_state.dart';
import '../cubits/homeCubit/sections_cubit/trinding_cubit.dart';
import '../widgets/build_movies_list.dart';
import '../widgets/custom_top_row.dart';


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
    BlocProvider.of<TrendingCubit>(context).loadMovies(
      true,
    );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 0.1) {
      BlocProvider.of<TrendingCubit>(context).loadMovies(
        true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CustomTopRow(
            title: "Trending",
            textDirection: TextDirection.ltr,
            iconImage: Image.asset("assets/arrow-left.png", height: 25, color: Colors.white70,),
            onPress: () {
              Navigator.pop(context);
            },
            mainAxisAlignment: MainAxisAlignment.spaceBetween),
        BlocBuilder<TrendingCubit, HomeState>(
            builder: (context, state) {
          if (state is HomeStateLoading) {
            return SizedBox(
              height: 215.h,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is HomeTrendingState) {
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
