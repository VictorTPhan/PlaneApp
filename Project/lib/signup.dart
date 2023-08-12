import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.title});

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String userName = '';
  String email = '';
  String password = '';
  bool signUpFailed = false;

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
            TextField(
                onChanged: (s1) {
                  this.email = s1;
                },
                decoration:const InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Enter Email',
                )
            ),
            TextField(
                onChanged: (s1) {
                  this.userName = s1;
                },
                decoration:const InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Enter User Name',
                )
            ),
            TextField(
                onChanged: (s1) {
                  this.password = s1;
                },
                obscureText: true,
                decoration:const InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Enter Password',
                )
            ),
            if (signUpFailed)
              const Text(
                'Invalid information! Please try again.',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            ElevatedButton(
              onPressed:() async {
                try{
                  var credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email:this.email, password:this.password).then((value) async {
                    await FirebaseDatabase.instance.ref().child('Users').child(FirebaseAuth.instance.currentUser!.uid).update(
                      {
                        "Currently Viewing":"nothing",
                        "Liked":[],
                        "name": this.userName
                      }
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage(title:'Home')),
                    );
                  }).catchError((onError) {
                    setState(() {
                      signUpFailed = true;
                    });
                  });
                }
                catch(e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:Text(e.toString()),
                    )
                  );
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),

    );
  }
}