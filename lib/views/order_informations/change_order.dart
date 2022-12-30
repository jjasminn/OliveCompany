import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChangeOrder extends StatefulWidget {
  const ChangeOrder({super.key});

  @override
  State<ChangeOrder> createState() => _ChangeOrderState();
}

class _ChangeOrderState extends State<ChangeOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Change Order"),
    );
  }
}
