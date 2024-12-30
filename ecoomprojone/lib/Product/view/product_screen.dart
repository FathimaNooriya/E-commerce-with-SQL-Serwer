import 'package:ecoomprojone/Product/view/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/fonts/font_styles.dart';
import '../../Order/contoller/order_controller.dart';
import '../../home/controller/home_controller.dart';
import '../controller/product_controller.dart';
import 'widget/products_grid.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final font = FontStyles();
    final orderController = Get.put(OrderController());
    final controller = Get.put(ProductController());
    final homeController = Get.put(HomeController());
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(child: SearchWidget(controller: controller)),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () {
                      homeController.pageIndex.value = 3;
                      orderController.editOrderHistory.value
                          ? orderController.netTotal.value = 0.0
                          : null;
                      orderController.editOrderHistory.value = false;
                    },
                    icon: const Icon(Icons.shopping_cart)),
              ),
            ],
          ),
          Obx(() {
            return controller.productStatus.value
                ? const Center(child: Text("No Products found"))
                : ProductsGrid(
                    controller: controller,
                    orderController: orderController,
                    font: font,
                    homeController: homeController,
                  );
          }),
        ],
      ),
    );
  }
}
