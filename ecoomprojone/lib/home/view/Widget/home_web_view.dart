import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/home_controller.dart';

class HomeWebView extends StatelessWidget {
  const HomeWebView({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        SizedBox(
          width: 200,
          child: Obx(() {
            return NavigationRail(
              extended: true,
              backgroundColor: const Color.fromARGB(255, 180, 208, 255),
              selectedIconTheme: const IconThemeData(color: Colors.black),
              unselectedIconTheme: const IconThemeData(
                color: Color.fromARGB(158, 255, 255, 255),
              ),
              onDestinationSelected: (value) => controller.changePage(value),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text('Customers'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_add_alt_1),
                  label: Text('Add Customers'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart),
                  label: Text('Cart'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.sell),
                  label: Text('Add Product'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.history_outlined),
                  label: Text('Order History'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.confirmation_num),
                  label: Text('Conform Order'),
                ),
              ],
              selectedIndex: controller.pageIndex.value,
            );
          }),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: Column(
            children: [
              AppBar(
                title: Obx(() {
                  return Center(
                      child: Text(
                          controller.appBarTitle[controller.pageIndex.value]));
                }),
              ),
              SingleChildScrollView(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height * .9,
                child:
                    Obx(() => controller.screens[controller.pageIndex.value]),
              )),
            ],
          ),
        ),
      ]),
    );
  }
}
