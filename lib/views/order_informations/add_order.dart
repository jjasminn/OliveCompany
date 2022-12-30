import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../database/databaseconnect.dart';

class AddOrder extends StatefulWidget {
  AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  @override
  TextEditingController name_controller = TextEditingController();
  TextEditingController lastname_controller = TextEditingController();
  TextEditingController address_controller = TextEditingController();
  TextEditingController type_controller = TextEditingController();
  TextEditingController amount_controller = TextEditingController();
  Widget build(BuildContext context) {
    Database dbb = Database();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            information(name_controller, "Isim"),
            information(lastname_controller, "Soyisim"),
            information(address_controller, "Adres"),
            information(type_controller, "Zeytin Turu"),
            information(amount_controller, "Zeytin Miktari"),
            ElevatedButton(
                onPressed: () {
                  dbb.AddtoDataBase(
                      name_controller.text,
                      lastname_controller.text,
                      address_controller.text,
                      int.parse(amount_controller.text),
                      type_controller.text);
                },
                child: Text("Yeni Siparis Ekle"))
          ],
        ),
      ),
    );
  }

  Container information(TextEditingController controller, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          labelText: text,
        ),
        controller: controller,
      ),
    );
  }
}
