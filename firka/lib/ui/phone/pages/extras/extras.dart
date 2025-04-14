import 'package:flutter/material.dart';

class ExtrasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extras'),
      ),
      body: Center(
        child: Text(
          ':3',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}