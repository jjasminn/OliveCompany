import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../database/databaseconnect.dart';
import '../../view_models/controller.dart';
import '../hata.dart';

class AddOrder extends StatefulWidget {
  AddOrder({super.key});

  @override
  State<AddOrder> createState() => _AddOrderState();
}

class _AddOrderState extends State<AddOrder> {
  @override
  final Controller _controller = Get.find();
  TextEditingController id_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController lastname_controller = TextEditingController();
  TextEditingController address_controller = TextEditingController();
  TextEditingController type_controller = TextEditingController();
  TextEditingController amount_controller = TextEditingController();
  Widget build(BuildContext context) {
    Database dbb = Database();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(
              text: 'Ciftci',
            ),
            Tab(
              text: 'Musteri',
            )
          ],
        ),
        body: TabBarView(
          children: [Ciftci(dbb), Musteri(dbb)],
        ),
      ),
    );
  }

  SingleChildScrollView Ciftci(Database dbb) {
    int miktar;
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
                  miktar = int.parse(amount_controller.text);
                  if (miktar < 50) {
                    Get.to(Hata(
                        message:
                            "50 kilo altindaki zeytin miktari icin siparis gerceklestirilemez"));
                  } else {
                    dbb.AddFarmerOrder(
                        name_controller.text,
                        lastname_controller.text,
                        address_controller.text,
                        int.parse(amount_controller.text),
                        type_controller.text);
                    Get.to(Hata(message: "Siparis Eklendi"));
                  }
                },
                child: Text("Yeni Donusum Siparisi Ekle"))
          ],
        ),
      ),
    );
  }

  SingleChildScrollView Musteri(Database dbb) {
    var para;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            information(name_controller, "Isim"),
            information(lastname_controller, "Soyisim"),
            information(address_controller, "Adres"),
            information(type_controller, "ZeytinYagi Tipi"),
            information(amount_controller, "ZeytinYagi Miktari"),
            ElevatedButton(
                onPressed: () async {
                  para = await dbb.AddCustomerOrder(
                      name_controller.text,
                      lastname_controller.text,
                      address_controller.text,
                      int.parse(amount_controller.text),
                      type_controller.text);
                  Get.to(
                      Hata(message: 'Siparis Eklendi \n Siparis tutari $para'));
                },
                child: Text("Yeni Siparis Ekle")),
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
