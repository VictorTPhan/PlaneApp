import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
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
  bool loginFailed = false;

  Future<void> login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: this.email, password: this.password).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home")),
      );
    }).catchError((onError) {
      setState(() {
        loginFailed = true;
      });
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    FirebaseDatabase db = FirebaseDatabase.instance;
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Divider(
              thickness: 4.0,
            ),
            const Text(
              'FLIGHT TRACKER',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold
              ),
            ),
            const Divider(
              thickness: 4.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: const Text(
                'Please sign in below',
                style: TextStyle(
                    fontSize: 20,
                ),
              ),
            ),
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
            if (loginFailed)
              const Text(
                'Wrong account information! Please try again.',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage(title:'Create an Account')),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed:(){
                    login();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
