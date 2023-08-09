// ignore_for_file: prefer_interpolation_to_compose_strings, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:moviedb/toprated.dart';
import 'package:moviedb/tvpopular.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'trending.dart';
import 'utils/text.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingMovies = [];
  List topRatedMovies = [];
  List tvPopular = [];
  final String apiKey = '5ada7f84fb56fce2f59f719a794e16c8';
  final token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YWRhN2Y4NGZiNTZmY2UyZjU5ZjcxOWE3OTRlMTZjOCIsInN1YiI6IjY0ZDM0Mjc5YmYzMWYyMDFjYjY3ZmM3ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0NkiFm5raLlCUHi3x548YgA2n42NNWS7XPBCzRdnkYQ';

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, token),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));
    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvPopularResult = await tmdbWithCustomLogs.v3.tv.getTopRated();

    setState(() {
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedResult['results'];
      tvPopular = tvPopularResult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.75),
        elevation: 0.0,
        leading: Image.asset(
          'images/logo.png', // Replace with your logo image file path
          width: 40, // Adjust the width as needed
        ),
      ),
      extendBodyBehindAppBar: true,
      body: ListView(children: [
        TvPopular(tvpopular: tvPopular),
        TopRatedMovies(toprated: topRatedMovies),
        TrendingMovies(trending: trendingMovies),
      ]),
    );
  }
}
