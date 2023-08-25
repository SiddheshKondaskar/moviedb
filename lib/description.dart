// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviedb/utils/text.dart';

class Description extends StatelessWidget {
  const Description(
      {super.key,
      required this.name,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.launchon});
  final String name, description, bannerurl, posterurl, vote, launchon;

  @override
  Widget build(BuildContext context) {
    final formattedLaunchDate =
        DateFormat('dd/MM/yyyy').format(DateTime.parse(launchon));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.75),
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                      child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Opacity(
                      opacity: 0.75, // Set the desired opacity value
                      child: Image.network(
                        bannerurl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
                  Positioned(
                      bottom: 10,
                      left: 5,
                      child: ModifyText(
                          color: Colors.white,
                          size: 18,
                          text: '⭐ Average Rating - ' + vote))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: ModifyText(color: Colors.white, size: 24, text: name),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: ModifyText(
                  color: Colors.white,
                  size: 16,
                  text: 'Release Date - ' + formattedLaunchDate),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(
                    posterurl,
                  ),
                ),
                Flexible(
                  child: Container(
                    child: ModifyText(
                        color: Colors.white, size: 16, text: description),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
