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
                  var credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email:this.email, password:this.password);
                  DatabaseReference ref = FirebaseDatabase.instance.ref('Users');
                  ref.update({
                    await credential.user!.uid:{
                      "Currently Viewing":"",
                      "Liked":[],

                    }
                    }
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(title:'Home', uid:credential.user?.uid)),
                  );
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