import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:refill_app/auth.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/pages/movies_lists.dart';
import 'package:refill_app/pages/user_page.dart';

class HeaderPage extends StatelessWidget {
  HeaderPage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colours.scaffoldBGColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colours.accentColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.account_circle),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UserPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Expanded(
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(icon: Icon(Icons.home_filled)),
                    Tab(icon: Icon(Icons.local_fire_department)),
                    Tab(icon: Icon(Icons.timelapse)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.output),
                    onPressed: signOut,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePageCaroussel(
              title1: "Trending Movies",
              title2: "Trending Series",
            ),
            TopRatedCaroussel(
              title1: "Top Rated Movies",
              title2: "Top Rated Series",
            ),
            HomePageCaroussel(
              title1: "Upcoming Movies",
              title2: "Popular Series",
            )
          ],
        ),
      ),
    );
  }
}
