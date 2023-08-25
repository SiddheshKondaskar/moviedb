// ignore_for_file: sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:moviedb/description.dart';
import 'package:moviedb/utils/text.dart';

class TvTopRated extends StatelessWidget {
  const TvTopRated({super.key, required this.tvtoprated});
  final List tvtoprated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifyText(
              text: 'Top Rated Shows', color: Colors.white, size: 26),
          Container(
            height: 270,
            child: ListView.builder(
                itemCount: tvtoprated.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Description(
                                name: tvtoprated[index]['name'],
                                description: tvtoprated[index]['overview'],
                                bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                    tvtoprated[index]['backdrop_path'],
                                posterurl: 'https://image.tmdb.org/t/p/w500' +
                                    tvtoprated[index]['poster_path'],
                                vote: tvtoprated[index]['vote_average']
                                    .toString(),
                                launchon: tvtoprated[index]['first_air_date']),
                          ));
                    },
                    child: tvtoprated[index]['name'] != null
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            width: 140,
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500' +
                                                  tvtoprated[index]
                                                      ['poster_path']))),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  child: ModifyText(
                                      text: tvtoprated[index]['name'],
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
