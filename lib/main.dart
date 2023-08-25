import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'nowplaying.dart';
import 'popular.dart';
import 'toprated.dart';

import 'tvnowplaying.dart';
import 'tvpopular.dart';
import 'tvtoprated.dart';

import 'searchpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List popularMovies = [];
  List topRatedMovies = [];
  List nowPlayingMovies = [];
  List tvPopular = [];
  List tvTopRated = [];
  List tvNowPlaying = [];

  final String apiKey = '5ada7f84fb56fce2f59f719a794e16c8';
  final token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YWRhN2Y4NGZiNTZmY2UyZjU5ZjcxOWE3OTRlMTZjOCIsInN1YiI6IjY0ZDM0Mjc5YmYzMWYyMDFjYjY3ZmM3ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0NkiFm5raLlCUHi3x548YgA2n42NNWS7XPBCzRdnkYQ'; // your API token here

  int selectedTabIndex = 0;

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, token),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));

    Map nowPlayingResult = await tmdbWithCustomLogs.v3.movies.getNowPlaying();
    Map topRatedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map popularResult = await tmdbWithCustomLogs.v3.movies.getPopular();

    Map tvPopularResult = await tmdbWithCustomLogs.v3.tv.getPopular();
    Map tvTopRatedResult = await tmdbWithCustomLogs.v3.tv.getTopRated();
    Map tvNowPlayingResult = await tmdbWithCustomLogs.v3.tv.getAiringToday();

    setState(() {
      nowPlayingMovies = nowPlayingResult["results"];
      topRatedMovies = topRatedResult['results'];
      popularMovies = popularResult['results'];

      tvNowPlaying = tvNowPlayingResult["results"];
      tvPopular = tvPopularResult['results'];
      tvTopRated = tvTopRatedResult['results'];
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
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0), // Adjust padding as needed
            alignment: Alignment.center,
            child: ToggleSwitch(
              initialLabelIndex: selectedTabIndex,
              totalSwitches: 2,
              labels: const ['Movies', 'TV Shows'],
              customTextStyles: [
                GoogleFonts.bebasNeue(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ],

              onToggle: (index) {
                if (index != null) {
                  setState(() {
                    selectedTabIndex = index;
                  });
                }
              },
              inactiveFgColor: Colors.black, // Adjust color as needed
              inactiveBgColor: Colors.white, // Adjust color as needed
              minWidth: 80, // Adjust the width of each switch
              minHeight: 36, // Adjust the height of the switch
            ),
          ),
          selectedTabIndex == 0
              ? Column(
                  children: [
                    NowPlayingMovies(nowplaying: nowPlayingMovies),
                    TopRatedMovies(toprated: topRatedMovies),
                    PopularMovies(popular: popularMovies),
                  ],
                )
              : Column(
                  children: [
                    TvNowPlaying(tvnowplaying: tvNowPlaying),
                    TvTopRated(tvtoprated: tvTopRated),
                    TvPopular(tvpopular: tvPopular),
                  ],
                )
        ],
      ),
    );
  }
}
