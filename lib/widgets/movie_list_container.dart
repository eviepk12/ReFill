import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/pages/detail_screen.dart';
import 'package:refill_app/widgets/section_title.dart';

class MovieListContainer extends StatelessWidget {
  final String title;

  const MovieListContainer({
    super.key,
    required this.title,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;

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
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                          ),
                          child: Container(
                            color: Colours.accentColor.withOpacity(0.5),
                            child: Image.network(
                              '${ApiKeys.imageUrl}${snapshot.data[itemIndex].posterPath}',
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Container(
                        //   color: Colours.accentColor.withOpacity(0.5),
                        // )
                      ],
                    )
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: TransparentImageCard(
                    //     width: MediaQuery.of(context).size.width,
                    //     height: MediaQuery.of(context).size.height,
                    //     imageProvider: NetworkImage(
                    //         '${ApiKeys.imageUrl}${snapshot.data[itemIndex].posterPath}'),
                    //     title: Text(
                    //       '${snapshot.data[itemIndex].originalTitle}',
                    //       style: const TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w600,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     description: Text(
                    //       '\u{2B50}' '${snapshot.data[itemIndex].voteAverage}',
                    //       style: const TextStyle(
                    //           fontSize: 20, color: Colours.accentColor),
                    //     ),
                    //   ),
                    // ),
                    );
              },
            );
          },
        ),
      ],
    );
  }
}
