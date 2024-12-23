import 'package:cool_nav/cool_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class HomePhoneView extends StatelessWidget {
  const HomePhoneView({
    super.key,
    required this.controller,
  });
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(
            controller.appBarTitle[controller.pageIndex.value],
          );
        }),
      ),
      body: Obx(() => controller.screens[controller.pageIndex.value]),
      bottomNavigationBar: Obx(() {
        return FlipBoxNavigationBar(
            currentIndex: controller.pageIndex.value,
            onTap: (value) => controller.changePage(value),
            verticalPadding: 20.0,
            items: <FlipBoxNavigationBarItem>[
              FlipBoxNavigationBarItem(
                name: 'Customers',
                selectedIcon: Icons.person,
                unselectedIcon: Icons.person_2_outlined,
                selectedBackgroundColor:
                    const Color.fromARGB(255, 205, 77, 255),
                unselectedBackgroundColor:
                    const Color.fromARGB(255, 217, 136, 255),
              ),
              FlipBoxNavigationBarItem(
                name: 'Add Customer',
                selectedIcon: Icons.person_add_alt_1,
                unselectedIcon: Icons.person_add_alt,
                selectedBackgroundColor:
                    const Color.fromARGB(255, 124, 77, 255),
                unselectedBackgroundColor:
                    const Color.fromARGB(255, 179, 136, 255),
              ),
              FlipBoxNavigationBarItem(
                name: 'Home',
                selectedIcon: Icons.home,
                unselectedIcon: Icons.home_outlined,
                selectedBackgroundColor:
                    const Color.fromARGB(255, 83, 109, 254),
                unselectedBackgroundColor:
                    const Color.fromARGB(255, 129, 148, 255),
              ),
              FlipBoxNavigationBarItem(
                name: 'Cart',
                selectedIcon: Icons.shopping_cart,
                unselectedIcon: Icons.shopping_cart_outlined,
                selectedBackgroundColor:
                    const Color.fromARGB(255, 68, 138, 255),
                unselectedBackgroundColor:
                    const Color.fromARGB(255, 130, 177, 255),
              ),
              FlipBoxNavigationBarItem(
                name: 'Add Product',
                selectedIcon: Icons.sell,
                unselectedIcon: Icons.sell_outlined,
                selectedBackgroundColor:
                    const Color.fromARGB(255, 40, 170, 127),
                unselectedBackgroundColor:
                    const Color.fromARGB(220, 130, 255, 245),
              ),
              FlipBoxNavigationBarItem(
                name: 'Order History',
                selectedIcon: Icons.history_outlined,
                unselectedIcon: Icons.history_toggle_off_outlined,
                selectedBackgroundColor: const Color.fromARGB(255, 40, 170, 62),
                unselectedBackgroundColor:
                    const Color.fromARGB(220, 170, 255, 130),
              ),
              FlipBoxNavigationBarItem(
                name: 'Conform Order',
                selectedIcon: Icons.confirmation_num,
                unselectedIcon: Icons.confirmation_num_outlined,
                selectedBackgroundColor:
                    const Color.fromARGB(255, 161, 170, 40),
                unselectedBackgroundColor:
                    const Color.fromARGB(220, 247, 255, 130),
              ),
            ]);
      }),
    );
  }
}
