import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Hata extends StatefulWidget {
  String message;
  Hata({super.key, required this.message});

  @override
  State<Hata> createState() => _HataState();
}

class _HataState extends State<Hata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Geri Donut')),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
            child: Text(
          widget.message,
          style: TextStyle(fontSize: 30),
        )),
      ),
    );
  }
}
