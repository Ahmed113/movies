import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/searchCubit/search_movieState.dart';
import '../cubits/searchCubit/search_movie_cubit.dart';
import '../widgets/build_movies_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? title;
  List? movies;
  bool? isLoading;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.isScrollingNotifier.value) {
      final query = _searchController.text;
      // BlocProvider.of<SearchMoviesCubit>(context).getMovies(title: query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding:
              const EdgeInsets.only(top: 45, right: 15, left: 15, bottom: 8),
          child: Column(
            children: [
              TextField(
                cursorColor: Colors.blueGrey,
                controller: _searchController,
                onSubmitted: (data) async {
                  title = data;
                  if (title != null) {
                    BlocProvider.of<SearchMoviesCubit>(context)
                        .disposePreviousSearch();
                    BlocProvider.of<SearchMoviesCubit>(context)
                        .getMovies(title: title!);
                  }
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: const ImageIcon(
                    AssetImage('assets/search.png'),
                    color: Colors.blueGrey,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontSize: 19.sp, color: Colors.blueGrey.withOpacity(.8)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.blueGrey,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Color(0xffE7ECDF), width: 2.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xffE7ECDF),
                ),
                style: TextStyle(fontSize: 19.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              BlocBuilder<SearchMoviesCubit, SearchMoviesState>(
                  builder: (context, state) {
                if (state is SearchMoviesInitial) {
                  // print('zzzzzzzzzzzzz$state');
                  return Padding(
                    padding: EdgeInsets.only(top: 200.h),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 90,
                              width: 90,
                              child: Image.asset('assets/search-movie.png')),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Search Movie !',
                            style:
                                TextStyle(fontSize: 18.sp, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is SearchMoviesLoading) {
                  // print('zzzzzzzzzzzzz$state');
                  return Padding(
                    padding: EdgeInsets.only(top: 250.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (state is SearchMoviesLoadingMore) {
                  // print('zzzzzzzzzzzzz$state');
                    return BuildMoviesList(
                      scrollController: _scrollController,
                      moviesList: state.moreMovies,
                    );
                } else if (state is SearchMoviesFailed) {
                  return Padding(
                    padding: EdgeInsets.only(top: 250.h),
                    child: Center(child: Text(state.exp)),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Failed fetching data',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ));
  }
}
