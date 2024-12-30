import 'package:ecoomprojone/Order/contoller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Order/view/confirm_order_screen.dart';
import '../../Order/view/order_screen.dart';
import '../../Product/controller/product_controller.dart';
import '../../Product/view/add_product_screen.dart';
import '../../Product/view/product_screen.dart';
import '../../customer/controller/customer_controller.dart';
import '../../customer/view/add_cust_screen.dart';
import '../../customer/view/customer_screen.dart';
import '../../customer/view/order_history_screen.dart';

class HomeController extends GetxController {
  //...................Instantiates controllers.................
  final custController = Get.put(CustomerController());
  final productController = Get.put(ProductController());
  final orderController = Get.put(OrderController());
  RxInt pageIndex = 2.obs;

  //...................List of screens used for navigation in the application.................
  List<Widget> screens = [
    const CustomerScreen(),
    const AddCustScreen(),
    const ProductScreen(),
    const OrderScreen(),
    const AddProductScreen(),
    const OrderHistoryScreen(),
    const ConfirmOrderScreen(),
  ];

  //...................List of titles for the app bar corresponding to each screen.................
  List<String> appBarTitle = [
    "Customers",
    "Add Customer",
    "Products",
    "Cart Page",
    "Add product",
    "Order history",
    "Ordered Details"
  ];

  //...................Changes the current page.................
  void changePage(int value) {
    if (value == 1) {
      custController.clear();
      custController.customerUpdating.value = false;
    } else if (value == 4) {
      productController.clear();
      productController.productUpdating.value = false;
    } else if (value == 3) {
      orderController.editOrderHistory.value
          ? orderController.netTotal.value = 0.0
          : null;
      orderController.editOrderHistory.value = false;
    }
    pageIndex.value = value;
  }
}
