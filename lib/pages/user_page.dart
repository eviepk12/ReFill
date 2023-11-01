import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:refill_app/auth.dart';
import 'package:refill_app/constants.dart';
import 'package:refill_app/pages/auth_pages/create_user_details.dart';
import 'package:refill_app/pages/detail_screen_movie.dart';
import 'package:refill_app/widgets/appbar_title.dart';
import 'package:refill_app/widgets/footer.dart';
import 'package:refill_app/widgets/section_title.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBGColor,
      appBar: AppBar(
        backgroundColor: Colours.accentColor,
        title: const AppBarTitle(title: "User Details"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateUserDetailsPage()),
                  ),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              signOut();
              Navigator.pop(context);
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
            ),
            child:
                const Text("Sign Out", style: TextStyle(color: Colors.white)),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

class MovieListContainer extends StatelessWidget {
  final String title;

  MovieListContainer({
    super.key,
    required this.title,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;

  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  late final user = auth.currentUser;
  // late final uuid = user!.uid;
  // late final userEmail = user!.email;

  @override
  Widget build(BuildContext context) {
    //
    // final docRef = db.collection("Users").where("uid", isEqualTo: user!.uid);
    // docRef.get().then(
    //   (DocumentSnapshot doc) {
    //     final data = doc.data() as Map<String, dynamic>;

    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );
    //
    return Column(
      children: [
        SectionTitle(title),
        const Divider(color: Colors.white),
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
                          builder: (context) => DetailsMovie(
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
                          decoration: const BoxDecoration(
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
                      ],
                    ));
              },
            );
          },
        ),
      ],
    );
  }
}
