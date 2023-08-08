import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'screen_details.dart';

class RandomPage extends StatefulWidget {
  RandomPage({super.key, required this.database});

  final FirebaseDatabase database;
  late String title;
  late String page = '';

  Future<List> getdata() async {
    var titles = [];
    DatabaseReference ref = database.ref(title);
    final snapshot = await ref.once();
    for (var data in snapshot.snapshot.children) {
      titles.add(data.key);
    }
    return titles as List <dynamic>;
  }

  void getrandom() async {
    var value = Random().nextInt(3);
    if (value == 0) {
      title = "Planes";
    }
    else if (value == 1) {
      title = "Airports";
    }
    else {
      title = "Flights";
    }
  }

  @override
  State<RandomPage> createState() => RandomPageState();
}

  class RandomPageState extends State <RandomPage>{
    Future<List> getdata() async{
      var details = [];
      DatabaseReference ref = widget.database.ref();
      final snapshot = await ref.child(widget.title+"/"+widget.page).get();
      for (var data in snapshot.children) {
        final temp = await ref.child(widget.title+"/"+widget.page+"/"+(data.key as String)).get();
        final value = temp.value.toString();
        details.add(data.key.toString()+": "+value);

      }
      print(details);
      return details;
    }
    @override
  Widget build(BuildContext context){
      widget.getrandom();
      return Scaffold(
        appBar: AppBar(

          title: Text(widget.page + ' Details Screen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 45),
              ),
              const Text(
                '--- --- --- --- --- ---\n\n',
                style: TextStyle(fontSize: 20),
              ),
              SingleChildScrollView(
                child: FutureBuilder(
                    future: getdata(),
                    builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else if(snapshot.hasData && snapshot.data!.isNotEmpty){
                        List<Widget> group = [];
                        for (var data in snapshot.data!){
                          group.add(Text(data));
                        }
                        return Column(
                          children:group,
                        );
                      }
                      else{
                        return Text('No data found');
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      );
  }
}
