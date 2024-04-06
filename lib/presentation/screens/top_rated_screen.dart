import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubits/homeCubit/home_state.dart';
import '../cubits/homeCubit/sections_cubit/top_rated_cubit.dart';
import '../widgets/build_movies_list.dart';
import '../widgets/custom_top_row.dart';

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
    BlocProvider.of<TopRatedCubit>(context).loadMovies(true);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 0.1) {
      BlocProvider.of<TopRatedCubit>(context).loadMovies(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage("assets/backgroundImg8.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
      children: [
          CustomTopRow(
              title: "Top Rated",
              textDirection: TextDirection.ltr,
              iconImage: Image.asset("assets/arrow-left.png", height: 25, color: Colors.white70,),
              onPress: () {
                Navigator.pop(context);
              },
              mainAxisAlignment: MainAxisAlignment.spaceBetween),
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
    ),
        ));
  }
}
