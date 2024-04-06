import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bottom_nav_bar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, this.user, this.fbUser});

  final User? user;
  final Map? fbUser;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<BottomNavBarCubit>(context);
        return Scaffold(
            backgroundColor: Colors.black45.withOpacity(.2),
            // body: cubit.screens[cubit.selectedIndex],
            body: cubit.getPage(cubit.selectedIndex, user: user, fbUser: fbUser ),
            bottomNavigationBar: SizedBox(
              height: 65.h,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                child: BottomNavigationBar(
                  backgroundColor: const Color(0xff30343F),
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: true,
                  currentIndex: cubit.selectedIndex,
                  onTap: (int newIndex) {
                    cubit.changeBottomNavBarIndex(newIndex: newIndex);
                  },
                  selectedItemColor: const Color(0xffE76402),
                  unselectedItemColor: Colors.grey,
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/home.png",
                        height: 25.h,
                        color: cubit.selectedIndex == 0
                            ? const Color(0xffE76402)
                            : Colors.grey,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/searchb.png",
                        height: 25.h,
                        color: cubit.selectedIndex == 1
                            ? const Color(0xffE76402)
                            : Colors.grey,
                      ),
                      label: 'Search',
                      // backgroundColor: Colors.white,
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/user.png",
                        height: 25.h,
                        color: cubit.selectedIndex == 2
                            ? const Color(0xffE76402)
                            : Colors.grey,

                      ),
                      label: 'Profile',
                      // backgroundColor: Colors.white,
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Image.asset("assets/user.png",height: 25.h,
                    //     color: cubit.selectedIndex == 2? Color(0xffE76402): Colors.grey,),
                    //   label: 'Profile',
                    //   // backgroundColor: Colors.white,
                    // ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(
                    //     Icons.list,
                    //     size: 35.sp,
                    //   ),
                    //   label: 'More',
                    //   backgroundColor: Colors.white,
                    // ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
