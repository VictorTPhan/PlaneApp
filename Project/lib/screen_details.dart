import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ScreenDetailPage extends StatefulWidget {
const ScreenDetailPage({super.key, required this.title, required this.ref});

final String title;
final String ref;

@override
State<ScreenDetailPage> createState() => ScreenDetailPageState();
}

class ScreenDetailPageState extends State<ScreenDetailPage> {
  late List<String?> details;

  void SetViewed() async {
    var uid = FirebaseAuth.instance.currentUser?.uid as String;
    var ref = FirebaseDatabase.instance.ref("Users/" + uid);
    await ref.update({
      "Currently Viewing": widget.ref+"/"+widget.title
    });
  }

  Widget getWidgetDependingOnRef(String ref, Map<dynamic, dynamic> info) {
    if (ref == "Planes"){
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
         "airline_icao_code": null,
         "plane_owner": "Airwork Flight Operations Ltd",
         "engines_count": "2",
         "engines_type": "JET",
         "plane_age": "31", *
         "plane_status": "active", *
         "plane_class": null
         */
      return Column(
        children: [
          Text(
            "Registration: ${info['registration_number'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Production Name: ${info['production_line'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Model: ${info['model_code'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "First Flight: ${info['first_flight_date'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Delivery Date: ${info['delivery_date'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Airline: ${info['airline_iata_code'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Age: ${info['plane_age'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Status: ${info['plane_status'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
        ],
      );
    } else if (ref == "Airports") {
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
         "city_iata_code": "AAA" *
         */
      return Column(
        children: [
          Text(
            "Name: ${info['airport_name'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "IATA: ${info['iata_code'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "ICAO: ${info['icao_code'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Time Zone: ${info['timezone'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "GMT: ${info['gmt'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Country: ${info['country_name'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "City: ${info['city_iata_code'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            "Airline: ${info['airline']['name'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Flight Number: ${info['flight']['number'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Flight ICAO: ${info['flight']['icao'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Date: ${info['flight_date'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Status: ${info['flight_status'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Departure Airport: ${info['departure']['airport'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Departure Time Zone: ${info['departure']['timezone'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Departure ICAO: ${info['departure']['icao'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Departure Terminal: ${info['departure']['terminal'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Departure Gate: ${info['departure']['gate'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Departure Delay: ${info['departure']['delay'].toString()} minutes",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Scheduled Departure Time: ${info['departure']['scheduled'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Arrival Airport: ${info['arrival']['airport'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Arrival Timezone: ${info['arrival']['timezone'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Arrival ICAO: ${info['arrival']['icao'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Arrival Terminal: ${info['arrival']['terminal'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Arrival Gate: ${info['arrival']['gate'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Baggage Claim: ${info['arrival']['baggage'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Arrival Delay: ${info['arrival']['delay'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Scheduled Arrival Time: ${info['arrival']['scheduled'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Scheduled Arrival Time: ${info['arrival']['scheduled'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          // Text(
          //   "Aircraft: ${info['aircraft']['registration'].toString()}",
          //   style: const TextStyle(
          //       fontSize: 20
          //   ),
          // ),
          // Text(
          //   "Aircraft Type: ${info['aircraft']['icao'].toString()}",
          //   style: const TextStyle(
          //       fontSize: 20
          //   ),
          // ),
          // Text(
          //   "On Ground?: ${info['live']['is_ground'].toString()}",
          //   style: const TextStyle(
          //       fontSize: 20
          //   ),
          // ),
          // Text(
          //   "Time Updated: ${info['live']['updated'].toString()}",
          //   style: const TextStyle(
          //       fontSize: 20
          //   ),
          // ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ref + " " + widget.title);
    SetViewed();
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title + ' Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Divider(
              thickness: 4.0,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
            const Divider(
              thickness: 4.0,
            ),
            FutureBuilder(
              future: FirebaseDatabase.instance.ref().child(widget.ref).child(widget.title).once(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  try {
                    var info = asyncSnapshot.data?.snapshot.value as Map;
                    return getWidgetDependingOnRef(widget.ref, info);
                  } on Exception {
                    return const Text("Error loading data");
                  }
                } else { // Loading data
                  return const Text("loading...");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
