import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'screen_details.dart';

class Top3 extends StatefulWidget {
  const Top3({super.key, required this.title});
  final String title;

  @override
  State<Top3> createState() => _Top3State();
}

class _Top3State extends State<Top3> {
  late List<String?> titles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            FutureBuilder(
              future: FirebaseDatabase.instance.ref().child("Flights").orderByChild("View Number").limitToLast(3).once(),
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
                                      title:postList[i],
                                      ref: widget.title + "s"
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
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500
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
      ),
    );
  }
}
