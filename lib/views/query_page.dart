import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Query extends StatefulWidget {
  const Query({super.key});

  @override
  State<Query> createState() => _QueryState();
}

class _QueryState extends State<Query> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Add delete page"));
  }
}
