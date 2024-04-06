import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/now_playing_screen.dart';
import '../screens/top_rated_screen.dart';
import '../screens/trending_screen.dart';



class MovieSectionsRow extends StatelessWidget {
  const MovieSectionsRow({
    super.key, required this.sectionName,
  });

  final String sectionName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: Row(
        children: [
          const Spacer(flex: 1,),
          Text(sectionName,style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            color: Colors.white70
          )),
          const Spacer(
            flex: 20,
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) {
                        if (sectionName == 'Top Rated') {
                          return const TopRatedScreen();
                        } else if (sectionName == 'Trending') {
                          return const TrendingScreen();
                        } else{
                          return const NowPlayingScreen();
                        }

                      } ));
            },
            child: const Text('View All',style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xffE76402),
            )),
          ),
          const Spacer(flex: 1,),
        ],
      ),
    );
  }
}
