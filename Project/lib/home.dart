import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:plane_app/login.dart';
import 'package:plane_app/main.dart';
import 'package:plane_app/settings.dart';
import 'screen.dart';
import 'liked.dart';
import 'screen_details.dart';
import 'top3.dart';
import 'trending.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String randomPage;
  late String randomTopic;

  //Plane data is just static, I would recommend running this once during development
  //to get your required data in the database and NOT using this in the app while running.
  Future<void> updateDatabaseWithPlanes() async {
    const url = "http://api.aviationstack.com/v1/airplanes?limit=9&access_key=d3d92a69102709cc75bdaaeb75453dd7";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      var flights = map['data'];
      for (Map<String, dynamic> flight in flights) {
        print(flight);
        //Do whatever you need to below

        /*
         "registration_number": "YR-BAC", *
         "production_line": "Boeing 737 Classic", *
         "iata_type": "B737-300",
         "model_name": "737",
         "model_code": "B737-377", *
         "icao_code_hex": "4A0823",
         "iata_code_short": "B733",
         "construction_number": "23653",
         "test_registration_number": null,
         "rollout_date": null,
         "first_flight_date": "1986-08-02T22:00:00.000Z", *
         "delivery_date": "1986-08-21T22:00:00.000Z", *
         "registration_date": "0000-00-00",
         "line_number": "1260",
         "plane_series": "377",
         "airline_iata_code": "0B", *
         "airline_icao_code": null, *
         "plane_owner": "Airwork Flight Operations Ltd",
         "engines_count": "2",
         "engines_type": "JET",
         "plane_age": "31", *
         "plane_status": "active", *
         "plane_class": null
         */

        flight['Liked Number'] = 0;
        flight['View Number'] = 0;

        //update info at root/Planes
        await FirebaseDatabase.instance.ref().child("Planes").child(flight['model_code']).set(flight).then((value) {
          print(flight['model_name']+" updated");
        }).catchError((onError) {
          print("Error");
        });
      }
    } else {
      return;
    }
  }

  //Airport data is just static, I would recommend running this once during development
  //to get your required data in the database and NOT using this in the app while running.
  Future<void> updateDatabaseWithAirports() async {
    const url = "http://api.aviationstack.com/v1/airports?limit=10&access_key=d3d92a69102709cc75bdaaeb75453dd7";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      var airports = map['data'];
      for (Map<String, dynamic> airport in airports) {
        print(airport);
        //Do whatever you need to below

        /*
         "airport_name": "Anaa", *
         "iata_code": "AAA", *
         "icao_code": "NTGA", *
         "latitude": "-17.05",
         "longitude": "-145.41667",
         "geoname_id": "6947726",
         "timezone": "Pacific/Tahiti", *
         "gmt": "-10", *
         "phone_number": null,
         "country_name": "French Polynesia", *
         "country_iso2": "PF",
         "city_iata_code": "AAA"
         */
        airport['Liked Number'] = 0;
        airport['View Number'] = 0;

        //update info at root/Planes
        await FirebaseDatabase.instance.ref().child("Airports").child(airport['airport_name']).set(airport).then((value) {
          print(airport['airport_name']+" updated");
        }).catchError((onError) {
          print("Error");
        });
      }
    } else {
      return;
    }
  }

  //Run this every ____ hours or if user timestamp exceeds the last recorded timestamp by ____ hours
  Future<void> updateDatabaseWithFlights() async {
    const url = "http://api.aviationstack.com/v1/flights?limit=10&access_key=d3d92a69102709cc75bdaaeb75453dd7";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      var flights = map['data'];
      for (Map<String, dynamic> flight in flights) {
        print(flight);
        //Do whatever you need to below

        flight['Liked Number'] = 0;
        flight['View Number'] = 0;
        var name = flight['airline']['name'] + " " + flight['flight']['number'];

        //update info at root/Planes
        await FirebaseDatabase.instance.ref().child("Flights").child(name).set(flight).then((value) {
          print(name+" updated");
        }).catchError((onError) {
          print("Error");
        });
      }
    } else {
      return;
    }
  }

  Future<void> CheckTime() async {
    //1. get the time from the database
    var lastTime = 0;
    await FirebaseDatabase.instance.ref().once().then((value) {
      var info = value.snapshot.value as Map;
      lastTime = info["TimeUpdated"];
    });
    //2. get the current time
    var currentTime = DateTime.now().millisecondsSinceEpoch;
    await FirebaseDatabase.instance.ref().update({
      "TimeUpdated": currentTime
    });
    //3. compare the two times and see if ~hour has passed
    int deltaTime = currentTime - lastTime;
    DateTime deltaDateTime = DateTime.fromMillisecondsSinceEpoch(deltaTime);
    Duration duration = deltaDateTime.difference(DateTime(1970, 1, 1));
    int hours = duration.inHours;
    //4. if so, call the flight update script
    if (hours > 1) {
      print("Update Database");
      await updateDatabaseWithFlights();
    }
  }

  Future<void> getRandom() async {
    var value = Random().nextInt(3);
    if (value == 0) {
      randomTopic = "Planes";
    } else if (value == 1) {
      randomTopic = "Airports";
    } else {
      randomTopic = "Flights";
    }

    var titles = [];
    DatabaseReference ref = FirebaseDatabase.instance.ref(randomTopic);
    final snapshot = await ref.once();
    for (var data in snapshot.snapshot.children) {
      titles.add(data.key);
    }
    randomPage = titles[Random().nextInt(titles.length)];
  }

  Widget displayUserName() {
    if (FirebaseAuth.instance.currentUser == null) {
      return Container();
    } else {
      return FutureBuilder(
        future: FirebaseDatabase.instance.ref().child("Users").child(FirebaseAuth.instance.currentUser!.uid).once(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            try {
              var info = asyncSnapshot.data?.snapshot.value as Map;
              return Column(
                children: [
                  Text(
                    "Welcome back, ${info['name']}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "You last viewed ${info['Currently Viewing']}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              );
            } on Exception {
              return const Text("Error loading data");
            }
          } else { // Loading data
            return const Text("loading...");
          }
        },
      );
    }
  }

  Widget showLikedFlightsButton() {
    if (FirebaseAuth.instance.currentUser == null) {
      return Container();
    } else {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LikedPage(title: 'Liked')),
          );
        },
        child: const Text(
          'Your Liked Flights', //Top 3 tracked flights
          style: TextStyle(fontSize: 30),
        ),
      );
    }
  }

  Widget showLoginButton() {
    if (FirebaseAuth.instance.currentUser == null) {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LoginPage(title: 'Log In')),
          );
        },
        child: const Text(
          'Log In',
          style: TextStyle(fontSize: 30),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Settings()),
          );
        },
        child: const Text(
          'Settings',
          style: TextStyle(fontSize: 30),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CheckTime();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Divider(
              thickness: 4.0,
            ),
            const Text(
              'AEROTRACKER',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold
              ),
            ),
            const Divider(
              thickness: 4.0,
            ),
            displayUserName(),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Top3(title: 'Top 3 Flights')),
                  );
                },
                child: const Text(
                  'Top 3 Tracked Flights', //Top 3 tracked flights
                  style: TextStyle(fontSize: 30),
                ),
            ),
            showLikedFlightsButton(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TrendingPage()
                  ),
                );
              },
              child: const Text(
                'Trending Pages', //Top 3 tracked flights
                style: TextStyle(fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await getRandom().then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenDetailPage(
                            ref: randomTopic, title: randomPage)),
                  );
                });
              },
              child: const Text(
                'Random Page', //Top 3 tracked flights
                style: TextStyle(fontSize: 30),
              ),
            ),
            showLoginButton(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orangeAccent,
        child: Container(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextButton(
                onPressed: null,
                child: Text(
                    'Home',
                    style: TextStyle(fontSize: 20)
                ),
              ),
              const VerticalDivider(
                thickness: 4.0,
              ),
              TextButton(
                child: const Text(
                    'Planes',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ScreenPage(title: 'Plane')),
                  );
                },
              ),
              const VerticalDivider(
                thickness: 4.0,
              ),
              TextButton(
                child: const Text(
                    'Airports',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ScreenPage(title: 'Airport')),
                  );
                },
              ),
              const VerticalDivider(
                thickness: 4.0,
              ),
              TextButton(
                child: const Text(
                    'Flights',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ScreenPage(title: 'Flight')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
