import 'package:flutter/material.dart';
import 'screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            const Text(
              'Menu\n',
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              'Liked\n',
              style: TextStyle(fontSize: 30),
            ),
            const Text(
              'Trending\n',
              style: TextStyle(fontSize: 30),
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
                      MaterialPageRoute(builder: (context) => const ScreenPage(title:'Plane')),
                    );
                  },
                ),
                Text(' | ', style: TextStyle(fontSize: 20)),
                TextButton(
                child:Text('Airports', style: TextStyle(fontSize: 20)),
                  onPressed:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ScreenPage(title:'Airport')),
                    );
                  },
                ),
                Text(' | ', style: TextStyle(fontSize: 20)),
                TextButton(
                child:Text('Flights', style: TextStyle(fontSize: 20)),
                  onPressed:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ScreenPage(title:'Flight')),
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
