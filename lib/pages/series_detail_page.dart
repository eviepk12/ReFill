import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/models/series.dart';
import 'package:refill_app/widgets/appbar_title.dart';

class DetailsSeries extends StatelessWidget {
  final Series series;

  const DetailsSeries({
    super.key,
    required this.series,
  });

  @override
  Widget build(BuildContext context) {
    Map<int, String> genreIdToNameMap = {
      28: "Action",
      12: "Adventure",
      16: "Animation",
      35: "Comedy",
      80: "Crime",
      99: "Documentary",
      18: "Drama",
      10751: "Family",
      14: "Fantasy",
      36: "History",
      27: "Horror",
      10402: "Music",
      9648: "Mystery",
      10749: "Romance",
      878: "Science Fiction",
      10770: "TV Movie",
      53: "Thriller",
      10752: "War",
      37: "Western",
      10765: "Sci-Fi & Fantasy"
    };

    List<String> genreNames = series.genreIds
        .map((genreId) => genreIdToNameMap[genreId] ?? 'Unknown')
        .toList();

    return Scaffold(
      backgroundColor: Colours.scaffoldBGColor,
      appBar: AppBar(
        backgroundColor: Colours.accentColor,
        title: const AppBarTitle(title: "Details"),
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
                            '${ApiKeys.imageUrl}${series.posterPath}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              HeadingText(
                title: series.originalTitle,
                fontSize: 35,
                fontWeight: FontWeight.w900,
                textColor: Colours.accentColor,
              ),
              //
              HeadingText(
                title: series.voteAverage.toString(),
                fontSize: 35,
                fontWeight: FontWeight.w900,
                textColor: Colours.accentColor,
              ),
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colours.accentColor)),
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Colors.grey,
                        content: SizedBox(
                          width: 250,
                          child: RatingBar.builder(
                            initialRating: 5,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 10,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    child: const Text('Rate it!',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print(series.id);
                    },
                    child: Text("Favorite it!",
                        style: TextStyle(color: Colors.black)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colours.accentColor)),
                  )
                ],
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
              OverviewContainer(series: series),

              InformationContainer(genreNames: genreNames)
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
    required this.series,
  });

  final Series series;

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
              series.overview,
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

class InformationContainer extends StatelessWidget {
  const InformationContainer({
    super.key,
    required this.genreNames,
  });

  final List<String> genreNames;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HeadingText(
            title: "Information",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            textColor: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                side: const BorderSide(
                  width: 5,
                  color: Colours.accentColor,
                ),
                backgroundColor: Colours.scaffoldBGColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50)),
            child: Text(
              genreNames.join(", "),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
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
