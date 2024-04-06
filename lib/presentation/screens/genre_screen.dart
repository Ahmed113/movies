import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubits/genreCubit/genre_cubit.dart';
import '../cubits/genreCubit/genre_state.dart';
import '../widgets/build_movies_list.dart';
import '../widgets/custom_top_row.dart';

class GenreScreen extends StatefulWidget {
  // GenreScreen({super.key});
  GenreScreen({super.key, required this.genre});

  String genre;

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GenreCubit>(context).disposePreviousGenreMovies();
    BlocProvider.of<GenreCubit>(context).loadGenreMovies(widget.genre, true);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 0.1) {
      BlocProvider.of<GenreCubit>(context).loadGenreMovies(widget.genre, true);
    }
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   BlocProvider.of<GenreCubit>(context).disposePreviousGenreMovies();
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.center,
            image: AssetImage("assets/backgroundImg8.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            CustomTopRow(
            title: widget.genre,
            textDirection: TextDirection.ltr,
            iconImage: Image.asset("assets/arrow-left.png", height: 25,color: Colors.white70,),
            onPress: () {
              Navigator.pop(context);
            },
            mainAxisAlignment: MainAxisAlignment.spaceBetween),
            BlocBuilder<GenreCubit, GenreState>(
              builder: (context, state) {
                if (state is GenreStateLoading) {
                  return SizedBox(
                    height: 215.h,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is GenreStateLoadingSuccess) {
                  return BuildMoviesList(
                      scrollController: _scrollController,
                      moviesList: state.genreMovies);
                } else if (state is GenreStateLoadingFailed) {
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
            )
          ],
        ),
      ),
    );
  }
}
