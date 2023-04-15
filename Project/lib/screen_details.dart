import 'package:flutter/material.dart';
import 'screen.dart';
import 'package:firebase_database/firebase_database.dart';

class ScreenDetailPage extends StatefulWidget {
const ScreenDetailPage({super.key, required this.title});

final String title;

@override
State<ScreenDetailPage> createState() => _ScreenDetailPageState();
}

class _ScreenDetailPageState extends State<ScreenDetailPage> {
  @override
  void initState() {
  getdata();


  }

  void getdata() async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("Flights");
    final snapshot = await ref.get();
    print(snapshot.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title + ' Details Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title + 's',
              style: TextStyle(fontSize: 45),
            ),
            const Text(
              '--- --- --- --- --- ---\n\n',
              style: TextStyle(fontSize: 20),
            ),
            SingleChildScrollView(
              child: Column(
                children:[
                  Text(
                    'Detail 1',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 2',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 3',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 4',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 5',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 6',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 3',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 3',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 3',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 3',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 3',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 3',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 3',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 3',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    'Detail 3',
                    style: TextStyle(fontSize: 30),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
