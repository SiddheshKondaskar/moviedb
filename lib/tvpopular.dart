// ignore_for_file: sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
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
              text: 'Popular TV Shows', color: Colors.white, size: 26),
          Container(
            height: 180,
            child: ListView.builder(
                itemCount: tvpopular.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
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
                                            tvpopular[index]['backdrop_path']),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            child: ModifyText(
                                text: tvpopular[index]['original_name'] ??
                                    'Loading...',
                                color: Colors.white,
                                size: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
