import 'package:ecoomprojone/Order/view/widget/cart_table_heading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../Core/fonts/font_styles.dart';
import '../../Product/controller/product_controller.dart';
import '../../Product/view/widget/shimmer_widget.dart';
import '../../customer/controller/customer_controller.dart';
import '../../home/controller/home_controller.dart';
import '../contoller/order_controller.dart';
import 'widget/calender_widget.dart';
import '../../Core/widgets/listview_shimmer_widget.dart';
import 'widget/cart_items_widget.dart';
import 'widget/customer_drop_down.dart';

class Orderscreen extends StatelessWidget {
  const Orderscreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final font = FontStyles();
    final controller = Get.put(OrderController());
    final customerController = Get.put(CustomerController());
    final productController = Get.put(ProductController());
    final homeController = Get.put(HomeController());
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: customerController.loading.value
          ? const ShimmerWidget()
          : LayoutBuilder(builder: (context, constraints) {
              return constraints.maxWidth < 600
                  ? CartWidget(
                      customerController: customerController,
                      homeController: homeController,
                      controller: controller,
                      font: font,
                      productController: productController)
                  : Center(
                      child: SizedBox(
                        width: screenWidth * .7,
                        child: Card(
                          child: CartWidget(
                              customerController: customerController,
                              homeController: homeController,
                              controller: controller,
                              font: font,
                              productController: productController),
                        ),
                      ),
                    );
            }),
    );
  }
}

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.controller,
    required this.font,
    required this.productController,
    required this.homeController,
    required this.customerController,
  });

  final OrderController controller;
  final FontStyles font;
  final ProductController productController;
  final HomeController homeController;
  final CustomerController customerController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CalenderWidget(controller: controller),
                Obx(
                  () => Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: customerController.loading.value
                          ? Shimmer(
                              child: Container(
                              width: 60,
                            ))
                          : controller.editOrderHistory.value == false
                              ? CustomerDropDown(
                                  customerController: customerController)
                              : Card(
                                  child: Row(
                                    children: [
                                      Text(controller
                                          .editOrder.value.orderHeader.custId
                                          .toString()),
                                      const Icon(Icons.account_circle,
                                          size: 35, color: Colors.blueAccent),
                                    ],
                                  ),
                                )),
                ),
              ],
            ),
          ),
          CartTableHeading(font: font),
          const Divider(),
          Obx(
            () => controller.orderList.isEmpty
                ? const Center(
                    child: Text(
                    "no  items found",
                  ))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.editOrderHistory.value == false
                              ? controller.orderList.length
                              : controller.editOrder.value.orderDetails.length,
                          itemBuilder: (context, index) {
                            return productController.loading.value
                                ? const ListViewShimmerWidget()
                                : CartItems(
                                    index: index,
                                    controller: controller,
                                    font: font);
                          }),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {},
                              label: const Text("Add Product"),
                              icon: const Icon(Icons.add),
                            ),
                            Text(
                              "Total",
                              style: font.tittle2,
                            ),
                            // Obx(
                            //   () =>
                            Text(
                              controller.netTotal.value.toString(),
                              style: font.tittle1,
                            ),
                            //)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                            onPressed: () {
                              homeController.pageIndex.value = 6;
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Order Now",
                                style: font.tittle2,
                              ),
                            )),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
