import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
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
  late String RandomPage;
  late String RandomTopic;
  FirebaseDatabase db = FirebaseDatabase.instance;

  Future<void> getdata() async {
    var titles = [];
    DatabaseReference ref = db.ref(RandomTopic);
    final snapshot = await ref.once();
    for (var data in snapshot.snapshot.children) {
      titles.add(data.key);
    }
    RandomPage = titles[Random().nextInt(titles.length)];
  }

  Future<void> getrandom() async {
    var value = Random().nextInt(3);
    if (value == 0) {
      RandomTopic = "Planes";
    }
    else if (value == 1) {
      RandomTopic = "Airports";
    }
    else {
      RandomTopic = "Flights";
    }
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    getrandom();
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Home',
              style: TextStyle(fontSize: 45),
            ),
            const Text(
              '--- --- --- --- --- ---\n\n',
              style: TextStyle(fontSize: 20),
            ),
            TextButton(
              child:const Text(
                'Top 3 tracked flights', //Top 3 tracked flights
                style: TextStyle(fontSize: 30),
              ),
              onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  TopPage(title:'Top 3 Flights')),
                );
              },
            ),
            TextButton(
              child:const Text(
                'Liked', //Top 3 tracked flights
                style: TextStyle(fontSize: 30),
              ),
              onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  LikedPage(title:'Liked')),
                );
              },
            ),
            TextButton(
              child:const Text(
                'Trending', //Top 3 tracked flights
                style: TextStyle(fontSize: 30),
              ),
              onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  TrendingPage(title:'Trending')),
                );
              },
            ),
            TextButton(
              child:const Text(
                'Random Page', //Top 3 tracked flights
                style: TextStyle(fontSize: 30),
              ),
              onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ScreenDetailPage(ref: RandomTopic, title: RandomPage, database: db)),
                ).then((value) {
                  getrandom();
                });
              },
            ),
            const Text(
              'Select item that you want to look at in the toolbar',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child:
        Container(
          child:Row(mainAxisAlignment: MainAxisAlignment.center,
            children:[
              TextButton(
                child:Text('Home', style: TextStyle(fontSize: 20)),
                onPressed:null,
              ),
              Text(' | ', style: TextStyle(fontSize: 20)),
              TextButton(
                child:Text('Planes', style: TextStyle(fontSize: 20)),
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  ScreenPage(title:'Plane', database: db)),
                  );
                },
              ),
              Text(' | ', style: TextStyle(fontSize: 20)),
              TextButton(
                child:Text('Airports', style: TextStyle(fontSize: 20)),
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScreenPage(title:'Airport', database: db)),
                  );
                },
              ),
              Text(' | ', style: TextStyle(fontSize: 20)),
              TextButton(
                child:Text('Flights', style: TextStyle(fontSize: 20)),
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScreenPage(title:'Flight', database: db)),
                  );
                },
              ),
            ],
          ),
          height: 75,
        ),
        color:Colors.orangeAccent,
      ),
    );
  }
}
