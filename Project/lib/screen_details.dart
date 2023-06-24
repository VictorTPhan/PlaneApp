import 'package:flutter/material.dart';
import 'screen.dart';
import 'package:firebase_database/firebase_database.dart';

class ScreenDetailPage extends StatefulWidget {
const ScreenDetailPage({super.key, required this.title, required this.database, required this.ref});

final String title;
final FirebaseDatabase database;
final String ref;

@override
State<ScreenDetailPage> createState() => _ScreenDetailPageState();
}

class _ScreenDetailPageState extends State<ScreenDetailPage> {
  late List<String?> details;
  Future<List> getdata() async{
    details = [];
    DatabaseReference ref = widget.database.ref();
    final snapshot = await ref.child(widget.ref+"/"+widget.title).get();
    for (var data in snapshot.children) {
      details.add(data.key);
    }
    print(details);
    return details;
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
