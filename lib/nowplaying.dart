// ignore_for_file: sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:moviedb/utils/text.dart';

import 'description.dart';

class NowPlayingMovies extends StatelessWidget {
  const NowPlayingMovies({super.key, required this.nowplaying});
  final List nowplaying;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifyText(
              text: 'Now Playing Movies', color: Colors.white, size: 26),
          Container(
            height: 180,
            child: ListView.builder(
                itemCount: nowplaying.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Description(
                                name: nowplaying[index]['title'],
                                description: nowplaying[index]['overview'],
                                bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                    nowplaying[index]['backdrop_path'],
                                posterurl: 'https://image.tmdb.org/t/p/w500' +
                                    nowplaying[index]['poster_path'],
                                vote: nowplaying[index]['vote_average']
                                    .toString(),
                                launchon: nowplaying[index]['release_date']),
                          ));
                    },
                    child: nowplaying[index]['title'] != null
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            width: 250,
                            child: Column(
                              children: [
                                Container(
                                  width: 250,
                                  height: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500' +
                                                  nowplaying[index]
                                                      ['backdrop_path']),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  child: ModifyText(
                                      text: nowplaying[index]['title'],
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
