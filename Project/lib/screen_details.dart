import 'package:flutter/material.dart';
import 'screen.dart';

class ScreenDetailPage extends StatefulWidget {
const ScreenDetailPage({super.key, required this.title});

final String title;

@override
State<ScreenDetailPage> createState() => _ScreenDetailPageState();
}

class _ScreenDetailPageState extends State<ScreenDetailPage> {

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
            Text(
              widget.title + ' 1',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              widget.title + ' 2',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              widget.title + ' 3',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
