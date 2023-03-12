import 'package:flutter/material.dart';
import 'screen_details.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key, required this.title});

  final String title;

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title + 's Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title + 's',
              style: TextStyle(fontSize: 45),
            ),
            const Text(
              '--- --- --- --- --- ---\n\n',
              style: TextStyle(fontSize: 20),
            ),
          TextButton(
            child:Text(
              widget.title + ' 1',
              style: TextStyle(fontSize: 30),
            ),
            onPressed:() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScreenDetailPage(title:'Flight')),
              );
            },
          ),

            TextButton(
              child:Text(
                widget.title + ' 2',
                style: TextStyle(fontSize: 30),
              ),
              onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScreenDetailPage(title:'Flight')),
                );
              },
            ),
            TextButton(
              child:Text(
                widget.title + ' 3',
                style: TextStyle(fontSize: 30),
              ),
              onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScreenDetailPage(title:'Flight')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
