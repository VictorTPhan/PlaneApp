import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'screen_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key, required this.title});
  final String title;

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  late List<String?> titles;
  late String uid;

  Future<List> getdata() async{
    titles = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref("Users/" + uid + "/Liked");
    final snapshot = await ref.once();
    for (var data in snapshot.snapshot.children) {
      titles.add(data.value as String);
    }
    print(titles);
    return titles;
  }

  @override
  Widget build(BuildContext context) {

    try {
      print(FirebaseAuth.instance.currentUser!.uid);
    } catch (error) {
      print(error);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: FirebaseDatabase.instance.ref().child("Users").child(FirebaseAuth.instance.currentUser!.uid).once(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            try {
              var info = asyncSnapshot.data?.snapshot.value as Map;
              var liked = info["Liked"];
              if (liked == null) {
                return const Text("You currently haven't liked any flights.");
              } else {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemCount: liked.length,
                    itemBuilder: (BuildContext context, int i) {
                      return GestureDetector(
                        onTap: () {
                          String entry = liked[i].toString();
                          var ref = entry.split("/")[0];
                          var title = entry.split("/")[1];

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScreenDetailPage(
                                    title: title,
                                    ref: ref
                                )
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                                liked[i],
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                          ),
                        ),
                      );
                    }
                );
              }
            } catch (Exception) {
              return const Text("Error loading data");
            }
          } else { // Loading data
            return const Text("loading...");
          }
        },
      ),
    );
  }
}
