// ignore_for_file: sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:moviedb/utils/text.dart';

import 'description.dart';

class TvNowPlaying extends StatelessWidget {
  const TvNowPlaying({super.key, required this.tvnowplaying});
  final List tvnowplaying;

  @override
  Widget build(BuildContext context) {
    final excludedLanguages = ['de', 'hi'];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifyText(
              text: 'Now Playing Shows', color: Colors.white, size: 26),
          Container(
            height: 180,
            child: ListView.builder(
                itemCount: tvnowplaying.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Description(
                                name: tvnowplaying[index]['name'],
                                description: tvnowplaying[index]['overview'],
                                bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                    tvnowplaying[index]['backdrop_path'],
                                posterurl: 'https://image.tmdb.org/t/p/w500' +
                                    tvnowplaying[index]['poster_path'],
                                vote: tvnowplaying[index]['vote_average']
                                    .toString(),
                                launchon: tvnowplaying[index]
                                    ['first_air_date']),
                          ));
                    },
                    child: tvnowplaying[index]['name'] != null &&
                            tvnowplaying[index]['backdrop_path'] != null &&
                            !excludedLanguages.contains(
                                tvnowplaying[index]['original_language'])
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
                                                  tvnowplaying[index]
                                                      ['backdrop_path']),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  child: ModifyText(
                                      text: tvnowplaying[index]['name'],
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
