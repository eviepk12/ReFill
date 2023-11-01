import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/pages/detail_screen_movie.dart';
import 'package:refill_app/pages/series_detail_page.dart';
import 'package:refill_app/widgets/section_title.dart';

class MovieListContainer extends StatelessWidget {
  final String title;
  final bool isMovie;

  const MovieListContainer(
      {super.key,
      required this.title,
      required this.snapshot,
      required this.isMovie});
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
                      isMovie
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsMovie(
                                  movie: snapshot.data[
                                      itemIndex], // Removed 'const' from here
                                ),
                              ),
                            )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsSeries(
                                  series: snapshot.data[
                                      itemIndex], // Removed 'const' from here
                                ),
                              ),
                            );
                    },
                    child: Container(
                      child: SizedBox(
                        height: double.infinity,
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                           shadowColor: Colours.accentColor,
                          margin: const EdgeInsets.all(10),
                          child: Image.network(
                            '${ApiKeys.imageUrl}${snapshot.data[itemIndex].posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ));
              },
            );
          },
        ),
      ],
    );
  }
}
