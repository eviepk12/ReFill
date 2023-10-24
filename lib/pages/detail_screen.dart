import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:refill_app/api/api.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/models/movie.dart';
import 'package:refill_app/models/movie_details.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBGColor,
      appBar: AppBar(
        backgroundColor: Colours.accentColor,
        title: Text(
          "Details",
          style: GoogleFonts.aBeeZee(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 50, right: 50, bottom: 25),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        filterQuality: FilterQuality.high,
                        image: NetworkImage(
                            '${ApiKeys.imageUrl}${movie.posterPath}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              HeadingText(
                title: movie.originalTitle,
                fontSize: 35,
                fontWeight: FontWeight.w900,
                textColor: Colours.accentColor,
              ),
              //
              HeadingText(
                title:  movie.voteAverage.toString(),
                fontSize: 35,
                fontWeight: FontWeight.w900,
                textColor: Colours.accentColor,
              ),
              //
              SizedBox(
                width: 250,
                child: RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 10,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              //
              OverviewContainer(movie: movie),
            ],
          ),
        ],
      ),
    );
  }
}

class OverviewContainer extends StatelessWidget {
  const OverviewContainer({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HeadingText(
            title: "Overview",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            textColor: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              movie.overview,
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  final String title;
  final FontWeight fontWeight;
  final Color textColor;
  final double fontSize;

  const HeadingText(
      {super.key,
      required this.title,
      required this.fontWeight,
      required this.textColor,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.openSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
    );
  }
}
