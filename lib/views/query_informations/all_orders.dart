import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../database/databaseconnect.dart';

class AllOrders extends StatefulWidget {
  var order;

  AllOrders({super.key, required this.order});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    print(widget.order.length);
    return Scaffold(
      appBar: AppBar(title: Text("Tum Siparisler")),
      body: Column(children: [
        Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Sipris Zamani"),
                Text("Musteri id "),
                Text("Litre"),
                Text("Zeytin Turu")
              ],
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: widget.order.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 20,
                  child: Text(
                      '${widget.order[index][0]}    ${widget.order[index][1]}   ${widget.order[index][2]}   ${widget.order[index][3]}'),
                );
              }),
        )
      ]),
    );
  }
}
