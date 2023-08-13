import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  showAlertDialog(BuildContext context) {
    String email = '';
    String password = '';
    bool loginFailed =false;

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String email = '';
        String password = '';
        bool loginFailed =false;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text("Account Deletion"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("To delete your account, you must sign in again."),
                if (loginFailed)
                  const Text(
                    'Invalid information! Please try again.',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                TextField(
                    onChanged: (s1) {
                      email = s1;
                    },
                    decoration:InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: 'Email',
                    )
                ),
                TextField(
                    onChanged: (s1) {
                      password = s1;
                    },
                    obscureText: true,
                    decoration:InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: 'Password',
                    )
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Delete"),
                onPressed: () async {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
                    FirebaseDatabase.instance.ref().child("Users").child(FirebaseAuth.instance.currentUser!.uid).remove();

                    FirebaseAuth.instance.currentUser!.delete().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home")),
                      );
                    }).catchError((onError) {
                      setState(() {
                        loginFailed = true;
                      });
                    });
                  }).catchError((onError) {
                    setState(() {
                      loginFailed = true;
                    });
                  });
                },
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        automaticallyImplyLeading: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home")),
                );
              });
            },
            child: const Text(
              'Log Out',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              showAlertDialog(context);
              // await FirebaseAuth.instance.currentUser!.delete().then((value) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const LoginPage(title: "Home")),
              //   );
              // });
            },
            child: const Text(
              'Delete Account', //Top 3 tracked flights
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
