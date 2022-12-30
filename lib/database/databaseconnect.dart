import 'package:postgres/postgres.dart';
import 'dart:io';
import 'dart:convert';

class Database {
  void ConnectToDatabase() async {
    final con = PostgreSQLConnection('10.0.2.2', 5435, 'zeytinyagi',
        username: 'postgres', password: 'password');

    await con.open();
    print("Connected to database...");

//     await con.query('''
//   CREATE TABLE customers(
//     id serial primary key not null,
//     name text,
//     email text,
//     address text,
//     type text,
//     amount int
//   )
//  ''');

//     await con.query('''
//   CREATE TABLE orders(
//     id serial primary key not null,
//     customer_id int,
//     price int,
//     date date,
//       CONSTRAINT fk_customers
//       FOREIGN KEY(customer_id)
// 	  REFERENCES customers(id)

//   )
//  ''');

    await con.close();
  }

  void AddtoDataBase(
    String name,
    String lastname,
    String location,
    int amount,
    String type,
  ) async {
    final con = PostgreSQLConnection('10.0.2.2', 5435, 'zeytinyagi',
        username: 'postgres', password: 'password');
    await con.open();

    await con.query("""

        INSERT INTO customers (name,lastname,address,type,amount)
        VALUES ($name,$lastname,$location,$type,$amount)

      """);
    await con.close();
  }
}
