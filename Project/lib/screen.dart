import 'package:flutter/material.dart';
import 'screen_details.dart';
import 'package:firebase_database/firebase_database.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key, required this.title});

  final String title;

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} Database'),
      ),
      body: FutureBuilder(
        future: FirebaseDatabase.instance.ref().child("${widget.title}s").once(),
        builder: (context, asyncSnapshot){
          if (asyncSnapshot.hasData){
            try {
              var asyncSnapshotList = asyncSnapshot.data?.snapshot.children.toList();

              final postList = List.empty(growable: true);
              for (DataSnapshot dataSnapshot in asyncSnapshotList!) {
                postList.add(dataSnapshot.key);
              }

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
    );
  }
}
