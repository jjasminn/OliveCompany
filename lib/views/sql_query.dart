import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:veritabani_projesi/views/query_informations/all_orders.dart';

import '../database/databaseconnect.dart';
import '../view_models/controller.dart';
import 'hata.dart';

class Query extends StatefulWidget {
  const Query({super.key});

  @override
  State<Query> createState() => _QueryState();
}

class _QueryState extends State<Query> {
  final Controller c = Get.find();
  Database dbb = Database();
  @override
  String most_selled_oil = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sorgulama ekrani")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(50),
            child: Text(
              "Zeytinyagi Firmasiyla alakali sorgulamalara buradan ulasabilirsiniz",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                var order = await dbb.AllOrders();
                print(order.length);
                Get.to(AllOrders(order: order));
              },
              child: Text("Tum siparisleri goruntule"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              var oil = await dbb.most_selled_oil();
              print(oil[0][0]);
              Get.to(Hata(
                message: "En cok satilan yag turu ${oil[0][0]}",
              ));
            },
            child: Text("En cok satilan yag turunu gor"),
          ),
        ],
      ),
    );
  }
}
