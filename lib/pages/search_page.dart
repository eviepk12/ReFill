import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:refill_app/constants.dart';
import 'package:refill_app/pages/detail_screen.dart';
import 'dart:convert';

import '../models/movie.dart';
import '../models/series.dart'; // Import the SeriesDetailScreen

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    final String apiUrl =
        'https://api.themoviedb.org/3/search/multi?include_adult=true&language=en-US&page=1&query=$query';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjQ3YmJkMThkN2ZhYzM1YjczOTU1NTIzYTVhZGZlNiIsInN1YiI6IjY1MjJhMzY3ZWE4NGM3MDBlYjlkYzkxMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Lsr9aK7SEeo7wCCLDfWPQGaTeLEAyQ-NnzHjay8VHQo',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        searchResults = data['results'];
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBGColor,
      appBar: AppBar(
        backgroundColor: Colours.accentColor,
        title: Text(
          "Search",
          style: GoogleFonts.aBeeZee(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusColor: Colors.white,
                filled: true,
                fillColor: Colors.white,
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _performSearch(_searchController.text);
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final result = searchResults[index];
                  return ListTile(
                      onTap: () {
                        // Navigate to the appropriate detail screen
                        if (result['media_type'] == 'movie') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(movie: Movie.fromJson(result)),
                            ),
                          );
                        }
                        //else if (result['media_type'] == 'tv') {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => SeriesDetailsScreen(
                        //           series: Series.fromJson(result)),
                        //     ),
                        //   );
                        // }
                      },
                      leading: result['poster_path'] != null
                          ? Container(
                              width: 56,
                              height: 84,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w92${result['poster_path']}',
                                fit: BoxFit.cover,
                              ),
                            )
                          : SizedBox.shrink(),
                      title: Text(result['name'] ?? result['title'] ?? 'N/A',
                          style: const TextStyle(color: Colors.white)),
                      subtitle: (result['media_type'] == "movie")
                          ? Text(result['release_date'] + "\n (Movie)",
                              style:
                                  const TextStyle(color: Colours.accentColor))
                          : (result['media_type'] == "tv")
                              ? Text(result['first_air_date'] + "\n (TV)",
                                  style: const TextStyle(
                                      color: Colours.accentColor))
                              : Text(
                                  result['known_for_department'],
                                  style: const TextStyle(
                                      color: Colours.accentColor),
                                ) // conditional statements for media types
                      // Text(result['media_type'] == "movie" ? result['release_date'] : result['first_air_date'], style: const TextStyle(color: Colours.accentColor),),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
