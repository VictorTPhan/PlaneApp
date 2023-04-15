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

  Future<List<Map>> getdata() async{
    List<Map> data = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref("Test");
    print("here");
    final snapshot = await ref.get();
    print(snapshot.value);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title + ' Database'),
      ),
      body: Column(
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
                  var group = snapshot.data!.map(
                      (eachGroup) => Container(
                        child:Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            Text(eachGroup["Name"]),
                          ]
                        )
                      )
                  ).toList();
                  return Column(
                    children:group,
                  );
                }
                else{
                  return Text('Hi');
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
