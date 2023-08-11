import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'screen.dart';
import 'liked.dart';
import 'screen_details.dart';
import 'top3.dart';
import 'trending.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.uid});

  final String title;
  final String? uid;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String randomPage;
  late String randomTopic;

  //Plane data is just static, I would recommend running this once during development
  //to get your required data in the database and NOT using this in the app while running.
  Future<void> updateDatabaseWithPlanes() async {
    const url = "http://api.aviationstack.com/v1/airplanes?limit=1&access_key=d3d92a69102709cc75bdaaeb75453dd7";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      var flights = map['data'];
      for (Map<String, dynamic> flight in flights) {
        print(flight);
        //Do whatever you need to below

        /*
         "registration_number": "YR-BAC",
         "production_line": "Boeing 737 Classic",
         "iata_type": "B737-300",
         "model_name": "737",
         "model_code": "B737-377",
         "icao_code_hex": "4A0823",
         "iata_code_short": "B733",
         "construction_number": "23653",
         "test_registration_number": null,
         "rollout_date": null,
         "first_flight_date": "1986-08-02T22:00:00.000Z",
         "delivery_date": "1986-08-21T22:00:00.000Z",
         "registration_date": "0000-00-00",
         "line_number": "1260",
         "plane_series": "377",
         "airline_iata_code": "0B",
         "airline_icao_code": null,
         "plane_owner": "Airwork Flight Operations Ltd",
         "engines_count": "2",
         "engines_type": "JET",
         "plane_age": "31",
         "plane_status": "active",
         "plane_class": null
         */
      }
    } else {
      return;
    }
  }

  //Airport data is just static, I would recommend running this once during development
  //to get your required data in the database and NOT using this in the app while running.
  Future<void> updateDatabaseWithAirports() async {
    const url = "http://api.aviationstack.com/v1/airports?limit=1&access_key=d3d92a69102709cc75bdaaeb75453dd7";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      var airports = map['data'];
      for (Map<String, dynamic> airport in airports) {
        print(airport);
        //Do whatever you need to below

        /*
         "airport_name": "Anaa",
         "iata_code": "AAA",
         "icao_code": "NTGA",
         "latitude": "-17.05",
         "longitude": "-145.41667",
         "geoname_id": "6947726",
         "timezone": "Pacific/Tahiti",
         "gmt": "-10",
         "phone_number": null,
         "country_name": "French Polynesia",
         "country_iso2": "PF",
         "city_iata_code": "AAA"
         */
      }
    } else {
      return;
    }
  }

  //Run this every ____ hours or if user timestamp exceeds the last recorded timestamp by ____ hours
  Future<void> updateDatabaseWithFlights() async {
    const url = "http://api.aviationstack.com/v1/flights?limit=1&access_key=d3d92a69102709cc75bdaaeb75453dd7";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      var flights = map['data'];
      for (Map<String, dynamic> flight in flights) {
        print(flight);
        //Do whatever you need to below

        /*
         "airport_name": "Anaa",
         "iata_code": "AAA",
         "icao_code": "NTGA",
         "latitude": "-17.05",
         "longitude": "-145.41667",
         "geoname_id": "6947726",
         "timezone": "Pacific/Tahiti",
         "gmt": "-10",
         "phone_number": null,
         "country_name": "French Polynesia",
         "country_iso2": "PF",
         "city_iata_code": "AAA"
         */
      }
    } else {
      return;
    }
  }

  Future<void> CheckTime() async {
    var ref = FirebaseDatabase.instance.ref("TimeUpdated");
    var temp = await ref.get();
    var time = temp.value as String;
    if (time.isEmpty) {
      FirebaseDatabase.instance.ref().update(
        {
          "TimeUpdated": DateTime.now().toString()
        }
      );
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

  @override
  Widget build(BuildContext context) {
    CheckTime();
    return Scaffold(
      appBar: AppBar(
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
              'FLIGHT TRACKER',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold
              ),
            ),
            const Divider(
              thickness: 4.0,
            ),
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
                  'Top 3 tracked flights', //Top 3 tracked flights
                  style: TextStyle(fontSize: 30),
                ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LikedPage(title: 'Liked')),
                );
              },
              child: const Text(
                'Liked', //Top 3 tracked flights
                style: TextStyle(fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TrendingPage()),
                );
              },
              child: const Text(
                'Trending', //Top 3 tracked flights
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
