import 'package:flutter/material.dart';
import 'screen_details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key, required this.title, required this.database});

  final String title;
  final FirebaseDatabase database;

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {

  late List<String?> titles;

  Future<List> getdata() async{
    titles = [];
    DatabaseReference ref = widget.database.ref(widget.title + "s");
    final snapshot = await ref.once();
    for (var data in snapshot.snapshot.children) {
      titles.add(data.key);
    }
    return titles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title + ' Database'),
      ),
      body: Center(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Container(
              child:Text(
                widget.title + 's',
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
                          MaterialPageRoute(builder: (context) =>  ScreenDetailPage(title:data, database: widget.database, ref: widget.title + "s")),
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
