import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'screen_details.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  late List<String?> titles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Text(
                "Top Trending Airplanes",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500
                ),
              ),
              FutureBuilder(
                future: FirebaseDatabase.instance.ref().child("Flights").orderByChild("Liked Number").limitToLast(3).once(),
                builder: (context, asyncSnapshot){
                  if (asyncSnapshot.hasData){
                    try {
                      var asyncSnapshotList = asyncSnapshot.data?.snapshot.children.toList();

                      var postList = List.empty(growable: true);
                      for (DataSnapshot dataSnapshot in asyncSnapshotList!) {
                        postList.add(dataSnapshot.key);
                      }
                      postList = postList.reversed.toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: postList!.length,
                        itemBuilder: (BuildContext ctx, i)=> Container(
                          height: 100,
                          width: 100,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScreenDetailPage(
                                        title: postList[i],
                                        ref: "Flights"
                                    )
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                    postList[i],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ),
                      );
                    } catch (Exception) {
                      return const Text("Error loading data");
                    }
                  }
                  else { // Loading data
                    return const Text("loading...");
                  }
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Text(
                "Top Trending Airports",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500
                ),
              ),
              FutureBuilder(
                future: FirebaseDatabase.instance.ref().child("Airports").orderByChild("Liked Number").limitToLast(3).once(),
                builder: (context, asyncSnapshot){
                  if (asyncSnapshot.hasData){
                    try {
                      var asyncSnapshotList = asyncSnapshot.data?.snapshot.children.toList();

                      var postList = List.empty(growable: true);
                      for (DataSnapshot dataSnapshot in asyncSnapshotList!) {
                        postList.add(dataSnapshot.key);
                      }
                      postList = postList.reversed.toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: postList!.length,
                        itemBuilder: (BuildContext ctx, i)=> Container(
                          height: 100,
                          width: 100,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScreenDetailPage(
                                        title: postList[i],
                                        ref: "Airports"
                                    )
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                    postList[i],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ),
                      );
                    } catch (Exception) {
                      return const Text("Error loading data");
                    }
                  }
                  else { // Loading data
                    return const Text("loading...");
                  }
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Text(
                "Top Trending Flights",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500
                ),
              ),
              FutureBuilder(
                future: FirebaseDatabase.instance.ref().child("Flights").orderByChild("Liked Number").limitToLast(3).once(),
                builder: (context, asyncSnapshot){
                  if (asyncSnapshot.hasData){
                    try {
                      var asyncSnapshotList = asyncSnapshot.data?.snapshot.children.toList();

                      var postList = List.empty(growable: true);
                      for (DataSnapshot dataSnapshot in asyncSnapshotList!) {
                        postList.add(dataSnapshot.key);
                      }
                      postList = postList.reversed.toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: postList!.length,
                        itemBuilder: (BuildContext ctx, i)=> Container(
                          height: 100,
                          width: 100,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScreenDetailPage(
                                        title: postList[i],
                                        ref: "Flights"
                                    )
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                    postList[i],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ),
                      );
                    } catch (Exception) {
                      return const Text("Error loading data");
                    }
                  }
                  else { // Loading data
                    return const Text("loading...");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
