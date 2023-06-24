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
String email = '';
String password = '';

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
                decoration:InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Enter Email',
                )
            ),
            TextField(
                onChanged: (s1) {
                  this.password = s1;
                },
                obscureText: true,
                decoration:InputDecoration(
                  border:OutlineInputBorder(),
                  labelText: 'Enter Password',
                )
            ),
            ElevatedButton(
              onPressed:() async {
                try{
                  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email:this.email, password:this.password);
                }
                catch(e) {
                  print(e);
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