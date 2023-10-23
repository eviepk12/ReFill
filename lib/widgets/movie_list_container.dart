import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/pages/detail_screen.dart';
import 'package:refill_app/widgets/section_title.dart';

class MovieListContainer extends StatelessWidget {
  final String title;
  final AsyncSnapshot snapshot;

  const MovieListContainer({
    super.key,
    required this.title,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colours.accentColor),
        SectionTitle(title),
        const Divider(color: Colours.accentColor),
        //
        CarouselSlider.builder(
          options: CarouselOptions(height: 400),
          // items: [1, 2, 3, 4, 5].map((i),
          itemCount: 15,
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          movie: snapshot
                              .data[itemIndex], // Removed 'const' from here
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(color: Colors.amber),
                    child: Image.network(
                      '${ApiKeys.imageUrl}${snapshot.data[itemIndex].posterPath}',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
