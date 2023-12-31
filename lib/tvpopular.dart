// ignore_for_file: sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:moviedb/description.dart';
import 'package:moviedb/utils/text.dart';

class TvPopular extends StatelessWidget {
  const TvPopular({super.key, required this.tvpopular});
  final List tvpopular;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifyText(
              text: ' Popular Shows', color: Colors.white, size: 26),
          Container(
            height: 270,
            child: ListView.builder(
                itemCount: tvpopular.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Description(
                                name: tvpopular[index]['name'],
                                description: tvpopular[index]['overview'],
                                bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                    tvpopular[index]['backdrop_path'],
                                posterurl: 'https://image.tmdb.org/t/p/w500' +
                                    tvpopular[index]['poster_path'],
                                vote:
                                    tvpopular[index]['vote_average'].toString(),
                                launchon: tvpopular[index]['first_air_date']),
                          ));
                    },
                    child: tvpopular[index]['name'] != null
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
                                                  tvpopular[index]
                                                      ['poster_path']))),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  child: ModifyText(
                                      text: tvpopular[index]['name'],
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
