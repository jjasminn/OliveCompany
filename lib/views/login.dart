import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:postgres/postgres.dart';
import 'package:veritabani_projesi/views/order_information_page.dart';
import 'package:veritabani_projesi/views/query_page.dart';

import '../view_models/controller.dart';
import '/database/databaseconnect.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Controller _controller = Get.put(Controller());

  @override
  int _currentlogin = 0;

  Widget build(BuildContext context) {
    Database db = Database(); //Database islemleri devam edecek

    db.ConnectToDatabase();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ZeytinYagi Isletme Tesisi"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "ZEYTINYAGI FIRMASINA HOSGELDINIZ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Zeytinyagi firmasiyla ilgili aciklamalar"),
        SizedBox(
          height: 350,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  Get.to(Query(), arguments: [db]);
                },
                child: Text("Sorgula")),
            TextButton(
                onPressed: () {
                  Get.to(OrderInformation());
                },
                child: Text("Siparis Islemleri"))
          ],
        )
      ]),
    );
  }
}
