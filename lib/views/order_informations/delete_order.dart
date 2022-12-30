import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeleteOrder extends StatefulWidget {
  const DeleteOrder({super.key});

  @override
  State<DeleteOrder> createState() => _DeleteOrderState();
}

class _DeleteOrderState extends State<DeleteOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("DeleteOrder"),
    );
  }
}
