
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_page.dart';
import '../profile.dart';
import '../search_screen.dart';


part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());

  User? user;
  Map? fBUser;

  int selectedIndex = 0;
  // List<Widget> screens = [
  //   HomePage(user: user!=null? user!: null,),
  //   SearchScreen(),
  // ];

  void changeBottomNavBarIndex({required int newIndex}) {
    selectedIndex = newIndex;
    print("What is Selected Index $selectedIndex");
    emit(BottomNavBarChangeIndex());
  }

  Widget? getPage(int index, {User? user, Map? fbUser}){
    switch(index) {
      case 0:
        return HomePage(user: user, fbUser: fbUser,);
        break;
      case 1:
        return const SearchScreen();
        break;
      case 2:
        return Profile(user: user, fbUser: fbUser);
    }
    // return null;

  }
}
