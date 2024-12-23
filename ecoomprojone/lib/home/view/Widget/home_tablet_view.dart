import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../controller/home_controller.dart';

class HomeTabletView extends StatelessWidget {
  HomeTabletView({
    super.key,
    required this.controller,
  });
  final HomeController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu_rounded,
            size: 40,
            color: Colors.blue,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Obx(() {
          return Text(controller.appBarTitle[controller.pageIndex.value]);
        }),
      ),
      key: _scaffoldKey,
      body: Obx(() => controller.screens[controller.pageIndex.value]),
      drawer: Drawer(
        width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(166, 112, 170, 218),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Customers'),
              tileColor: const Color.fromARGB(127, 217, 136, 255),
              onTap: () {
                controller.changePage(0);
                // Handle navigation
                Navigator.pop(context); // Closes the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add_alt_1),
              title: const Text('Add Customers'),
              tileColor: const Color.fromARGB(106, 180, 136, 255),
              onTap: () {
                controller.changePage(1);
                // Handle navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              tileColor: const Color.fromARGB(96, 129, 148, 255),
              onTap: () {
                // Handle navigation
                controller.changePage(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              tileColor: const Color.fromARGB(97, 130, 178, 255),
              onTap: () {
                controller.changePage(3);
                // Handle navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sell),
              title: const Text('Add Product'),
              tileColor: const Color.fromARGB(99, 130, 255, 245),
              onTap: () {
                controller.changePage(4);
                // Handle navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history_outlined),
              title: const Text('Order History'),
              tileColor: const Color.fromARGB(110, 170, 255, 130),
              onTap: () {
                controller.changePage(5);
                // Handle navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.confirmation_num),
              title: const Text('Conform Order'),
              tileColor: const Color.fromARGB(108, 247, 255, 130),
              onTap: () {
                controller.changePage(6);
                // Handle navigation
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
