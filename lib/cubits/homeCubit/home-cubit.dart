import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/cubits/homeCubit/home-state.dart';
import 'package:movies/fetchMovieData/now-playing-movies-data.dart';
import 'package:movies/fetchMovieData/top-rated-movies-data.dart';
import 'package:movies/fetchMovieData/trending-movies-data.dart';
import 'package:movies/movieModel/movie_model.dart';

class HomeTopRatedCubit extends Cubit<HomeTopRatedState> {
  HomeTopRatedCubit(this.topRatedMoviesData)
      : super(HomeTopRatedStateInitial());

  TopRatedMoviesData topRatedMoviesData;
  // TrendingMoviesData trendingMoviesData;
  // NowPlayingMoviesData nowPlayingMoviesData;
  int topRatedPage = 1;
  // int nowPlayingPage = 1;
  // bool isLoading = false;
  bool hasNextTopRatedPage = true;
  bool hasNextNowPlayingPage = true;
  List<MovieModel?> topRatedMovies = List.empty(growable: true);
  List<MovieModel?> allTopRatedMovies = List.empty(growable: true);
  List<MovieModel?> nowPlayingMovies = List.empty(growable: true);
  List<MovieModel?> allNowPlayingMovies = List.empty(growable: true);
  // void loadMovies() async {
  //   try {
  //     if (hasNextTopRatedPage == true) {
  //       if (topRatedPage == 1) {
  //         emit(HomeStateLoading(
  //             isTopRatedLoading: true,
  //             isNowPlayingLoading: false,
  //             isTrendingLoading: false,
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             newPlayingMovies: List.from(allNowPlayingMovies)
  //         )
  //         );
  //       } else {
  //         emit(HomeStateLoading(
  //             isTopRatedLoading: false,
  //             isNowPlayingLoading: false,
  //             isTrendingLoading: false,
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             newPlayingMovies: List.from(allNowPlayingMovies)
  //             ));
  //       }
  //       topRatedMovies =
  //           await topRatedMoviesData.getTopRatedMoviesData(page: topRatedPage);
  //       // trendingMovies =
  //       //     await trendingMoviesData.getTrendingMoviesData(page: trendingPage);
  //       // nowPlayingMovies = await nowPlayingMoviesData.getNowPlayingMoviesData(
  //       //     page: nowPlayingPage);
  //       if (topRatedMovies.isNotEmpty) {
  //         allTopRatedMovies.addAll(topRatedMovies);
  //         // allTrendingMovies.addAll(trendingMovies);
  //         // allNowPlayingMovies.addAll(nowPlayingMovies);
  //         // emit(HomeStateSuccess(topRatedMovies: allTopRatedMovies, trendingMovies: allTrendingMovies, nowPlayingMovies: allNowPlayingMovies, hasNextLoading: true));
  //         topRatedPage++;
  //         emit(HomeStateSuccess(
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             nowPlayingMovies: List.from(allNowPlayingMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             hasNextLoading: true));
  //       } else {
  //         hasNextTopRatedPage = false;
  //         emit(HomeStateSuccess(
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             nowPlayingMovies: List.from(allNowPlayingMovies),
  //             hasNextLoading: false));
  //       }
  //     }
  //     if (hasNextTrendingPage == true) {
  //       if (trendingPage == 1) {
  //         emit(HomeStateLoading(
  //             isTopRatedLoading: false,
  //             isNowPlayingLoading: false,
  //             isTrendingLoading: true,
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             newPlayingMovies: List.from(allNowPlayingMovies)
  //         ));
  //       } else {
  //         emit(HomeStateLoading(
  //             isTopRatedLoading: false,
  //             isNowPlayingLoading: false,
  //             isTrendingLoading: false,
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             newPlayingMovies: List.from(allNowPlayingMovies)
  //         ));
  //       }
  //       trendingMovies =
  //       await trendingMoviesData.getTrendingMoviesData(page: trendingPage);
  //       if (trendingMovies.isNotEmpty) {
  //         allTrendingMovies.addAll(trendingMovies);
  //         trendingPage++;
  //         emit(HomeStateSuccess(
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             nowPlayingMovies: List.from(allNowPlayingMovies),
  //             hasNextLoading: true));
  //       } else {
  //         hasNextTrendingPage = false;
  //         emit(HomeStateSuccess(
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             nowPlayingMovies: List.from(allNowPlayingMovies),
  //             hasNextLoading: false));
  //       }
  //     }
  //     if (hasNextNowPlayingPage == true) {
  //       if (nowPlayingPage == 1) {
  //         emit(HomeStateLoading(
  //             isTopRatedLoading: false,
  //             isNowPlayingLoading: true,
  //             isTrendingLoading: false,
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             newPlayingMovies: List.from(allNowPlayingMovies)));
  //       } else {
  //         emit(HomeStateLoading(
  //             isTopRatedLoading: false,
  //             isNowPlayingLoading: false,
  //             isTrendingLoading: false,
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             newPlayingMovies: List.from(allNowPlayingMovies)));
  //       }
  //       nowPlayingMovies = await nowPlayingMoviesData.getNowPlayingMoviesData(
  //           page: nowPlayingPage);
  //       if (nowPlayingMovies.isNotEmpty) {
  //         allNowPlayingMovies.addAll(nowPlayingMovies);
  //         nowPlayingPage++;
  //         emit(HomeStateSuccess(
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             nowPlayingMovies: List.from(allNowPlayingMovies),
  //             hasNextLoading: true));
  //       } else {
  //         hasNextNowPlayingPage = false;
  //         emit(HomeStateSuccess(
  //             topRatedMovies: List.from(allTopRatedMovies),
  //             trendingMovies: List.from(allTrendingMovies),
  //             nowPlayingMovies: List.from(allNowPlayingMovies),
  //             hasNextLoading: false));
  //       }
  //     }
  //     // else{
  //     //   hasNextPage = false;
  //     //   emit(HomeStateSuccess(topRatedMovies: allTopRatedMovies, trendingMovies: allTrendingMovies, nowPlayingMovies: allNowPlayingMovies, hasNextLoading: false));
  //     // }
  //   } on Exception catch (e) {
  //     emit(HomeStateFailed(exp: '$e'));
  //   }
  // }
  void loadTopRatedMovies( bool loadMore ) async{
    try{
        if (topRatedPage == 1) {
          emit(HomeStateTopRatedLoading(
              // topRatedMovies: List.from(allTopRatedMovies),
              isLoading: true
          )
          );
        }
        if (loadMore == true) {
          while (hasNextTopRatedPage == true) {
            topRatedMovies = await topRatedMoviesData.getTopRatedMoviesData(page: topRatedPage);
            if (topRatedMovies.isNotEmpty) {
              allTopRatedMovies.addAll(topRatedMovies);
              emit(HomeStateTopRatedSuccess(
                  topRatedMovies: List.from(allTopRatedMovies),
                  hasNextLoading: true));
              topRatedPage++;
            } else {
              hasNextTopRatedPage = false;
            }
          }
        }  else{
          while (hasNextTopRatedPage == true && allTopRatedMovies.length<=10) {
            topRatedMovies = await topRatedMoviesData.getTopRatedMoviesData(page: topRatedPage);
            if (topRatedMovies.isNotEmpty) {
              allTopRatedMovies.addAll(topRatedMovies);
              emit(HomeStateTopRatedSuccess(
                  topRatedMovies: List.from(allTopRatedMovies),
                  hasNextLoading: true));
              topRatedPage++;
            } else {
              hasNextTopRatedPage = false;
            }
          }
        }

    }on Exception catch (e) {
      emit(HomeTopRatedStateFailed(exp: '$e'));
    }
  }
}

class HomeTrendingCubit extends Cubit<HomeTrendingState>{
  HomeTrendingCubit(this.trendingMoviesData)
      : super(HomeTrendingStateInitial());

  TrendingMoviesData trendingMoviesData;
  int trendingPage = 1;
  bool hasNextTrendingPage = true;
  List<MovieModel?> trendingMovies = List.empty(growable: true);
  List<MovieModel?> allTrendingMovies = List.empty(growable: true);

  void loadTrendingMovies(bool loadMore) async{
    try{
        if (trendingPage == 1) {
          emit(HomeStateTrendingLoading(
              // trendingMovies: List.from(allTrendingMovies),
              isLoading: true
          ));
        }
        if (loadMore == true) {
          while (hasNextTrendingPage == true) {
            trendingMovies = await trendingMoviesData.getTrendingMoviesData(
                page: trendingPage);
            if (trendingMovies.isNotEmpty) {
              allTrendingMovies.addAll(trendingMovies);
              emit(HomeStateTrendingSuccess(
                  trendingMovies: List.from(allTrendingMovies),
                  hasNextLoading: true));
              trendingPage++;
            } else {
              hasNextTrendingPage = false;
              loadMore = false;
            }
          }
        } else{
        while (hasNextTrendingPage == true && allTrendingMovies.length <= 10) {
          trendingMovies = await trendingMoviesData.getTrendingMoviesData(
              page: trendingPage);
          if (trendingMovies.isNotEmpty) {
            allTrendingMovies.addAll(trendingMovies);
            emit(HomeStateTrendingSuccess(
                trendingMovies: List.from(allTrendingMovies),
                hasNextLoading: true));
            trendingPage++;
          } else {
            hasNextTrendingPage = false;
          }
        }
      }
    }on Exception catch (e) {
      emit(HomeTrendingStateFailed(exp: '$e'));
    }
  }
}

class HomeNowPlayingCubit extends Cubit<HomeNowPlayingState>{
  HomeNowPlayingCubit(this.nowPlayingMoviesData)
      : super(HomeNowPlayingStateInitial());

  NowPlayingMoviesData nowPlayingMoviesData;
  int nowPlayingPage = 1;
  bool hasNextNowPlayingPage = true;
  List<MovieModel?> nowPlayingMovies = List.empty(growable: true);
  List<MovieModel?> allNowPlayingMovies = List.empty(growable: true);

  void loadNowPlayingMovies(bool loadMore) async{
    try{
        if (nowPlayingPage == 1) {
          emit(HomeStateNowPlayingLoading(
              // newPlayingMovies: List.from(allNowPlayingMovies),
              isLoading: true));
        }
        if (loadMore == true) {
          while(hasNextNowPlayingPage == true) {
            nowPlayingMovies = await nowPlayingMoviesData.getNowPlayingMoviesData(
                page: nowPlayingPage);
            if (nowPlayingMovies.isNotEmpty) {
              allNowPlayingMovies.addAll(nowPlayingMovies);
              emit(HomeStateNowPlayingSuccess(
                  nowPlayingMovies: List.from(allNowPlayingMovies),
                  hasNextLoading: true));
              nowPlayingPage++;
            } else {
              hasNextNowPlayingPage = false;
              emit(HomeStateNowPlayingSuccess(
                  nowPlayingMovies: List.from(allNowPlayingMovies),
                  hasNextLoading: false));
            }
          }
        }else{
          while(hasNextNowPlayingPage == true && allNowPlayingMovies.length <= 10) {
            nowPlayingMovies = await nowPlayingMoviesData.getNowPlayingMoviesData(
                page: nowPlayingPage);
            if (nowPlayingMovies.isNotEmpty) {
              allNowPlayingMovies.addAll(nowPlayingMovies);
              emit(HomeStateNowPlayingSuccess(
                  nowPlayingMovies: List.from(allNowPlayingMovies),
                  hasNextLoading: true));
              nowPlayingPage++;
            } else {
              hasNextNowPlayingPage = false;
              emit(HomeStateNowPlayingSuccess(
                  nowPlayingMovies: List.from(allNowPlayingMovies),
                  hasNextLoading: false));
            }
          }
        }
    }on Exception catch (e) {
      emit(HomeNowPlayingStateFailed(exp: '$e'));
    }
  }
}
