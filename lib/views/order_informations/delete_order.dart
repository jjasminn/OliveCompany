import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../database/databaseconnect.dart';

class DeleteOrder extends StatefulWidget {
  const DeleteOrder({super.key});

  @override
  State<DeleteOrder> createState() => _DeleteOrderState();
}

class _DeleteOrderState extends State<DeleteOrder> {
  String hata = "";

  @override
  TextEditingController order_no = TextEditingController();
  Database dbb = Database();
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Siparis Silme",
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(
            height: 90,
          ),
          Center(
              child: TextField(
                  controller: order_no,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    labelText: "Siparis no giriniz",
                  ))),
          ElevatedButton(
              onPressed: () {
                dbb.DeleteOrder(int.parse(order_no.text));
              },
              child: Text("Sil")),
          SizedBox(
            height: 30,
          ),
          Text(
            hata,
            style: TextStyle(color: Colors.red),
          )
        ],
      ),
    );
  }
}
