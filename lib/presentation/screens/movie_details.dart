import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/model/movieModel/cast_model.dart';
import '../../domain/model/movieModel/movie_model.dart';
import '../cubits/castCubit/cast_cubit.dart';
import '../cubits/castCubit/cast_state.dart';
import '../utils/constants.dart';
import '../widgets/custom_cast_item.dart';
import '../widgets/custom_genre_item.dart';


class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.movieModel});

  final MovieModel movieModel;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CastCubit>(context).getCast(id: widget.movieModel.id!);
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350.h,
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  // borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                  image: DecorationImage(
                    image: NetworkImage(
                        '$MOVIE_IMG_BASE_URL/w200/${widget.movieModel.posterPath}'),
                    fit: BoxFit.fill,
                    colorFilter: const ColorFilter.mode(
                      Colors.black26,
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Container(
                    height: 25.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: const Color(0xffFD9803),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_rounded, color: Colors.white, size: 15.sp),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          widget.movieModel.voteAverage.toString().split('.').first,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  trailing: Text(
                    "${widget.movieModel.releaseDate}",
                    style: TextStyle(fontSize: 15.sp, color: Colors.white24),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 80.h,
                width: MediaQuery.of(context).size.width,
                // padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "${widget.movieModel.title}",
                        style: TextStyle(
                          fontSize: 27.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        // softWrap: true,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // padding: const EdgeInsets.all( 12),
                          shrinkWrap: true,
                          itemCount: widget.movieModel.genre?.length,
                          itemBuilder: (context, index) {
                            return CustomGenreItem(genre: widget.movieModel.genre![index],);
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.movieModel.overview!.isNotEmpty
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                            "Synopsis",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500,
                                color: Colors.white70
                            ),
                          ),
                      )
                      : const Text(''),
                   SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "${widget.movieModel.overview}",
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white38),
                      softWrap: true,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<CastCubit, CastState>(
                    builder: (context, state) {
                      if (state is CastInitial) {
                        return const Center(child: Text(''));
                      }else if (state is CastLoading){
                        return const Center(child: CircularProgressIndicator());
                      }else if (state is CastSuccess) {
                        List<CastModel?> casts =
                            BlocProvider.of<CastCubit>(context).cast!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            state.cast.isNotEmpty
                                ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                      "Cast",
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w500,
                                          color: Colors.white70
                                      ),
                                    ),
                                )
                                : const Text(''),
                            Container(
                              height: 200.h,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: casts.length,
                                  itemBuilder: (context, index) {
                                    return CustomCastItem(casts: casts, movieImgBaseUrl: MOVIE_IMG_BASE_URL, index: index,);
                                  }),
                            ),
                          ],
                        );
                      } else if (state is CastFailed) {
                        return Center(child: Text(state.exp));
                      }  {
                        return Text('Loading Failed!',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white70
                          ),);
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

