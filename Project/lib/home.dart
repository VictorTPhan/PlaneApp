import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'liked.dart';
import 'random.dart';
import 'top3.dart';
import 'trending.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Firebase Init");
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Screen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    FirebaseDatabase db = FirebaseDatabase.instance;
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
                  MaterialPageRoute(builder: (context) =>  RandomPage(title:'Random')),
                );
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
