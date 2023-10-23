import 'package:flutter/material.dart';
import 'package:refill_app/api/api.dart';
import 'package:refill_app/api/series_api.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/models/movie.dart';
import 'package:refill_app/models/series.dart';
import 'package:refill_app/widgets/footer.dart';
import 'package:refill_app/widgets/movie_list_container.dart';

class HomePageCaroussel extends StatefulWidget {
  final String title1;
  final String title2;
  const HomePageCaroussel(
      {super.key, required this.title1, required this.title2});

  @override
  State<HomePageCaroussel> createState() => _HomePageCarousselState();
}

class _HomePageCarousselState extends State<HomePageCaroussel> {
  late Future<List<Movie>> trendingMovies;

  late Future<List<Series>> trendingSeries;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();

    trendingSeries = SApi().getTrendingSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBGColor,
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: ListView(
          children: [
            // Container(
            //   color: Colors.red,
            //   height: 250,
            // ),
            //
            SizedBox(
              child: FutureBuilder(
                future: trendingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return MovieListContainer(
                        title: widget.title1, snapshot: snapshot);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              child: FutureBuilder(
                future: trendingSeries,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return MovieListContainer(
                        title: widget.title2, snapshot: snapshot);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const Footer()
          ],
        ),
      ),
    );
  }
}

class TopRatedCaroussel extends StatefulWidget {
  final String title1;
  final String title2;
  const TopRatedCaroussel(
      {super.key, required this.title1, required this.title2});

  @override
  State<TopRatedCaroussel> createState() => _TopRatedCaroussel();
}

class _TopRatedCaroussel extends State<TopRatedCaroussel> {
  late Future<List<Movie>> topRatedMovies;

  late Future<List<Series>> topRatedSeries;

  @override
  void initState() {
    super.initState();
    topRatedMovies = Api().getTopRatedMovies();

    topRatedSeries = SApi().getTopRatedSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBGColor,
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: ListView(
          children: [
            // Container(
            //   color: Colors.red,
            //   height: 250,
            // ),
            //
            SizedBox(
              child: FutureBuilder(
                future: topRatedMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return MovieListContainer(
                        title: widget.title1, snapshot: snapshot);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              child: FutureBuilder(
                future: topRatedSeries,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return MovieListContainer(
                        title: widget.title2, snapshot: snapshot);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const Footer()
          ],
        ),
      ),
    );
  }
}

class UpcomingCaroussel extends StatefulWidget {
  final String title1;
  final String title2;
  const UpcomingCaroussel(
      {super.key, required this.title1, required this.title2});

  @override
  State<UpcomingCaroussel> createState() => _UpcomingCaroussel();
}

class _UpcomingCaroussel extends State<UpcomingCaroussel> {
  late Future<List<Movie>> upcomingMovies;

  late Future<List<Series>> popularSeries;

  @override
  void initState() {
    super.initState();
    upcomingMovies = Api().getUpcomingMovies();

    popularSeries = SApi().getPopularSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBGColor,
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: ListView(
          children: [
            SizedBox(
              child: FutureBuilder(
                future: upcomingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return MovieListContainer(
                        title: widget.title1, snapshot: snapshot);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              child: FutureBuilder(
                future: popularSeries,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return MovieListContainer(
                        title: widget.title2, snapshot: snapshot);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const Footer()
          ],
        ),
      ),
    );
  }
}