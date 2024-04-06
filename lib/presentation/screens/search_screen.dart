import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubits/searchCubit/search_movie_state.dart';
import '../cubits/searchCubit/search_movie_cubit.dart';
import '../widgets/build_movies_list.dart';
import '../widgets/custom-text-field.dart';

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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgroundImg8.jpg"),
              fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              CustomTextField(textEditingController: _searchController,
              onSubmitted: (data) async {
                title = data;
                if (title != null) {
                  BlocProvider.of<SearchMoviesCubit>(context)
                      .disposePreviousSearch();
                  BlocProvider.of<SearchMoviesCubit>(context)
                      .getMovies(title: title!);
                }
              },
                image: AssetImage('assets/search.png'),
                suffixIconColor: const Color(0xffE76402),
                hintText: "Search",
                fillColor: const Color(0xffE7ECDF),
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


