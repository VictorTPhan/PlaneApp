import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'screen_details.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key, required this.title, required this.database});
  final FirebaseDatabase database;
  final String title;

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  late List<String?> titles;

  Future<List> getdata() async{
    titles = [];
    DatabaseReference ref = widget.database.ref("Trending");
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
                        var temp = data.split("/");
                        group.add(Container(child:TextButton(child:Text(temp[1]), onPressed:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  ScreenDetailPage(title:temp[1], database: widget.database, ref: temp[0])),
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
