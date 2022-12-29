import 'package:postgres/postgres.dart';
import 'dart:io';
import 'dart:convert';

class Database {
  void ConnectToDatabase() async {
    final con = PostgreSQLConnection('10.0.2.2', 5435, 'zeytinyagi',
        username: 'postgres', password: 'password');

    await con.open();
    print("Connected to database...");

    await con.close();
  }
}
