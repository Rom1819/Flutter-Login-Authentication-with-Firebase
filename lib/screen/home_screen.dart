import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      backgroundColor: Colors.cyan,
      body: Center(
        child: Text(
          'WELCOME TO HOME SCREEN',
          style: TextStyle(
            color: Colors.deepPurple[700],
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}

