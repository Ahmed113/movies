import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies/screens/home_page.dart';
import 'package:movies/screens/search_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>  HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircleAvatar(
            minRadius: 70,
            maxRadius: 90,
            backgroundImage: AssetImage('assets/film-movie.jpg')),
      ),
    );
  }
}