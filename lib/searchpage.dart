// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'description.dart';
import 'utils/text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  List searchMovies = [];
  List searchTvShow = [];

  final String apiKey = 'YOUR_API_KEY';
  final token =
      'YOUR_TOKEN'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.75),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) async {
                if (value.isNotEmpty) {
                  TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, token),
                      logConfig: const ConfigLogger(
                          showLogs: true, showErrorLogs: true));

                  Map searchMoviesResult =
                      await tmdbWithCustomLogs.v3.search.queryMovies(value);

                  Map searchTvShowResult =
                      await tmdbWithCustomLogs.v3.search.queryTvShows(value);

                  setState(() {
                    searchMovies = searchMoviesResult['results'];
                    searchTvShow = searchTvShowResult['results'];
                  });
                }
              },
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    searchController.clear();
                    setState(() {
                      searchMovies.clear();
                      searchTvShow.clear();
                    });
                  },
                ),
                hintText: 'Search for movies and TV shows...',
                hintStyle: GoogleFonts.bebasNeue(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Visibility(
            visible: searchMovies.isNotEmpty,
            child: ModifyText(text: 'Movies:', color: Colors.white, size: 18),
          ),
          Expanded(
            child: searchMovies.isEmpty
                ? Center(
                    child: Text(
                      '',
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: searchMovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Description(
                                    name: searchMovies[index]['title'],
                                    description: searchMovies[index]
                                        ['overview'],
                                    bannerurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            searchMovies[index]
                                                ['backdrop_path'],
                                    posterurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            searchMovies[index]['poster_path'],
                                    vote: searchMovies[index]['vote_average']
                                        .toString(),
                                    launchon: searchMovies[index]
                                        ['release_date']),
                              ));
                        },
                        child: searchMovies[index]['title'] != null &&
                                searchMovies[index]['backdrop_path'] != null
                            ? Container(
                                padding: const EdgeInsets.all(5),
                                width: 140,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 180,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500' +
                                                      searchMovies[index]
                                                          ['poster_path']))),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      child: ModifyText(
                                          text: searchMovies[index]['title'],
                                          color: Colors.white,
                                          size: 14),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      );
                    }),
          ),
          Visibility(
            visible: searchTvShow.isNotEmpty,
            child: ModifyText(text: 'TV Shows:', color: Colors.white, size: 18),
          ),
          Expanded(
            child: searchTvShow.isEmpty
                ? Center(
                    child: Text(
                      '',
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: searchTvShow.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Description(
                                    name: searchTvShow[index]['name'],
                                    description: searchTvShow[index]
                                        ['overview'],
                                    bannerurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            searchTvShow[index]
                                                ['backdrop_path'],
                                    posterurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            searchTvShow[index]['poster_path'],
                                    vote: searchTvShow[index]['vote_average']
                                        .toString(),
                                    launchon: searchTvShow[index]
                                        ['first_air_date']),
                              ));
                        },
                        child: searchTvShow[index]['name'] != null &&
                                searchTvShow[index]['backdrop_path'] != null
                            ? Container(
                                padding: const EdgeInsets.all(5),
                                width: 140,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 180,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://image.tmdb.org/t/p/w500' +
                                                      searchTvShow[index]
                                                          ['poster_path']))),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      child: ModifyText(
                                          text: searchTvShow[index]['name'],
                                          color: Colors.white,
                                          size: 14),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
