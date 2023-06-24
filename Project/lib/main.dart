import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const LoginPage(title: 'Home Screen'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future <void> login () async{
    try{
      await firebaseAuth.signInWithEmailAndPassword(email:this.email, password:this.password);
      if(firebaseAuth.currentUser != null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title:'Home')),
        );
      }
    }
    catch(e){}

  }
  @override
  Widget build(BuildContext context) {
    FirebaseDatabase db = FirebaseDatabase.instance;
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (s1) {
                this.email = s1;
                },
              decoration:InputDecoration(
                border:OutlineInputBorder(),
                labelText: 'Email',
              )
            ),
            TextField(
                onChanged: (s1) {
                  this.password = s1;
                },
                obscureText: true,
                decoration:InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Password',
                )
            ),
            TextButton(
              child: Text('Sign up'),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage(title:'Create an Account')),
                );
              },
            ),
            ElevatedButton(
            child:Text('Log in'),
              onPressed:(){
              login();
              },
            ),
          ],
        ),
      ),
    );
  }
}
