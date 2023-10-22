import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/widgets/footer.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBGColor,
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: ListView(
          children: [
            Container(
              color: Colors.red,
              height: 250,
            ),
            //
            const MovieListContainer(title: "Trending Movies"),

            const MovieListContainer(title: "Watchlist"),
            //
            const Footer()
          ],
        ),
      ),
    );
  }
}

class MovieListContainer extends StatelessWidget {
  final String title;

  const MovieListContainer({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          color: Colors.grey,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(height: 400),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(color: Colors.amber),
                    child: Text(
                      'text $i',
                      style: const TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        )
      ],
    );
  }
}
