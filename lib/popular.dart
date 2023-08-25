// ignore_for_file: sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:moviedb/utils/text.dart';

import 'description.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({super.key, required this.popular});
  final List popular;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ModifyText(
              text: 'Popular Movies', color: Colors.white, size: 26),
          Container(
            height: 270,
            child: ListView.builder(
                itemCount: popular.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Description(
                                name: popular[index]['title'],
                                description: popular[index]['overview'],
                                bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                    popular[index]['backdrop_path'],
                                posterurl: 'https://image.tmdb.org/t/p/w500' +
                                    popular[index]['poster_path'],
                                vote: popular[index]['vote_average'].toString(),
                                launchon: popular[index]['release_date']),
                          ));
                    },
                    child: popular[index]['title'] != null
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
                                                  popular[index]
                                                      ['poster_path']))),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  child: ModifyText(
                                      text: popular[index]['title'],
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
