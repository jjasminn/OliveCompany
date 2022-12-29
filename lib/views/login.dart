import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:postgres/postgres.dart';
import 'package:postgres/postgres.dart';
import '/database/databaseconnect.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  TextEditingController Ncontroller = TextEditingController();
  TextEditingController Pcontroller = TextEditingController();
  Widget build(BuildContext context) {
    //Database db = Database(); Database islemleri devam edecek

    //db.ConnectToDatabase();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ZeytinYagi Isletme Tesisi"),
      ),
      body: Column(children: [
        ListTile(
          leading: Text("Isim "),
          title: TextField(
            controller: Ncontroller,
          ),
        ),
        ListTile(
          leading: Text("Password "),
          title: TextField(
            controller: Pcontroller,
          ),
        ),
        ElevatedButton(onPressed: null, child: Text("ekle"))
      ]),
    );
  }
}
