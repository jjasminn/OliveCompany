import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:veritabani_projesi/views/order_informations/delete_order.dart';

import '../database/databaseconnect.dart';
import '../view_models/controller.dart';
import 'order_informations/add_order.dart';

class OrderInformation extends StatefulWidget {
  const OrderInformation({super.key});

  @override
  State<OrderInformation> createState() => _OrderInformationState();
}

class _OrderInformationState extends State<OrderInformation> {
  final Controller _controller = Get.find();

  int _currentIndex = 1;
  Widget _currentScreen = DeleteOrder();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Siparis Islemleri"),
        centerTitle: true,
      ),
      body: _currentScreen,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [Icons.add, Icons.delete],
        activeIndex: _currentIndex,
        height: Get.height / 12,
        backgroundColor: Color.fromARGB(255, 54, 115, 56),
        splashColor: Colors.grey,
        inactiveColor: Colors.white,
        activeColor: Colors.black,
        onTap: (int) {
          setState(() {
            _currentIndex = int;
            if (int == 0) {
              _currentScreen = AddOrder();
            } else {
              _currentScreen = DeleteOrder();
            }
          });
        },
      ),
    );
  }
}
