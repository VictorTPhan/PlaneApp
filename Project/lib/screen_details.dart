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
    if (ref == "Planes") {
      return Column(
        children: [
          Text(
            "Capacity: ${info['Capacity'].toString()} persons",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Range: ${info['Range'].toString()} km",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Likes: ${info['Liked Number'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Views: ${info['View Number'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
        ],
      );
    } else if (ref == "Airports") {
      return Column(
        children: [
          Text(
            "IATA-ICAO: ${info['IATA-ICAO'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Location: ${info['Location'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Likes: ${info['Liked Number'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Views: ${info['View Number'].toString()}",
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
            "Locations: ${info['Locations'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Plane: ${info['Plane'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Status: ${info['Status'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Likes: ${info['Liked Number'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
          Text(
            "Views: ${info['View Number'].toString()}",
            style: const TextStyle(
                fontSize: 20
            ),
          ),
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
