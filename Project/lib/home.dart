import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'screen.dart';
import 'liked.dart';
import 'screen_details.dart';
import 'top3.dart';
import 'trending.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.uid});

  final String title;
  final String? uid;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String randomPage;
  late String randomTopic;

  Future<void> CheckTime() async {
    var ref = FirebaseDatabase.instance.ref("TimeUpdated");
    var temp = await ref.get();
    var time = temp.value as String;
    if (time.isEmpty) {
      FirebaseDatabase.instance.ref().update({"TimeUpdated": DateTime.now().toString()});
    }
  }

  Future<void> getRandom() async {
    var value = Random().nextInt(3);
    if (value == 0) {
      randomTopic = "Planes";
    } else if (value == 1) {
      randomTopic = "Airports";
    } else {
      randomTopic = "Flights";
    }

    var titles = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref(randomTopic);
    final snapshot = await ref.once();
    for (var data in snapshot.snapshot.children) {
      titles.add(data.key);
    }
    randomPage = titles[Random().nextInt(titles.length)];
  }

  @override
  Widget build(BuildContext context) {
    CheckTime();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Divider(
              thickness: 4.0,
            ),
            const Text(
              'FLIGHT TRACKER',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold
              ),
            ),
            const Divider(
              thickness: 4.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Top3(title: 'Top 3 Flights')),
                  );
                },
                child: const Text(
                  'Top 3 tracked flights', //Top 3 tracked flights
                  style: TextStyle(fontSize: 30),
                ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LikedPage(title: 'Liked')),
                );
              },
              child: const Text(
                'Liked', //Top 3 tracked flights
                style: TextStyle(fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TrendingPage()),
                );
              },
              child: const Text(
                'Trending', //Top 3 tracked flights
                style: TextStyle(fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await getRandom().then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenDetailPage(
                            ref: randomTopic, title: randomPage)),
                  );
                });
              },
              child: const Text(
                'Random Page', //Top 3 tracked flights
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orangeAccent,
        child: Container(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextButton(
                onPressed: null,
                child: Text(
                    'Home',
                    style: TextStyle(fontSize: 20)
                ),
              ),
              const VerticalDivider(
                thickness: 4.0,
              ),
              TextButton(
                child: const Text(
                    'Planes',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ScreenPage(title: 'Plane')),
                  );
                },
              ),
              const VerticalDivider(
                thickness: 4.0,
              ),
              TextButton(
                child: const Text(
                    'Airports',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ScreenPage(title: 'Airport')),
                  );
                },
              ),
              const VerticalDivider(
                thickness: 4.0,
              ),
              TextButton(
                child: const Text(
                    'Flights',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ScreenPage(title: 'Flight')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
