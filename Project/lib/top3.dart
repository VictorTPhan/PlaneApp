import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'screen_details.dart';

class top3 extends StatefulWidget {
  const top3({super.key, required this.title, required this.database});
  final FirebaseDatabase database;
  final String title;

  @override
  State<top3> createState() => _top3State();
}

class _top3State extends State<top3> {
  late List<String?> titles;

  Future<List> getdata() async{
    titles = [];
    DatabaseReference ref = widget.database.ref("TopFlights");
    final snapshot = await ref.once();
    for (var data in snapshot.snapshot.children) {
      titles.add(data.value as String);
    }
    print(titles);
    return titles;
  }

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
            Container(
              child:Text(
                widget.title,
                style: TextStyle(fontSize: 45),
              ),
              height:75,
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
                        group.add(Container(child:TextButton(child:Text(data), onPressed:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  ScreenDetailPage(title: data, database: widget.database, ref: "Flights")),
                          );
                        })));
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
