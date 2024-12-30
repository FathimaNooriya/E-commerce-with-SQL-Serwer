import 'package:ecoomprojone/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/fonts/font_styles.dart';
import '../../Core/widgets/listview_shimmer_widget.dart';
import '../../Order/contoller/order_controller.dart';
import '../../Product/controller/product_controller.dart';
import '../../Product/model/product_model.dart';
import '../../Product/view/widget/shimmer_widget.dart';
import '../controller/customer_controller.dart';
import 'widget/order_list_items.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final font = FontStyles();
    final controller = Get.put(CustomerController());
    final productController = Get.put(ProductController());

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => controller.loading.value
              ? const ListViewShimmerWidget()
              : controller.orderHistoryList.isEmpty
                  ? const Center(
                      child: Text("No oreders found"),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return constraints.maxWidth < 600
                                  ? OrderHistoryWidget(
                                      controller: controller,
                                      font: font,
                                      productController: productController)
                                  :
                                  // constraints.maxWidth < 1024
                                  //     ?
                                  Center(
                                      child: SizedBox(
                                        width: screenWidth * .7,
                                        child: OrderHistoryWidget(
                                            controller: controller,
                                            font: font,
                                            productController:
                                                productController),
                                      ),
                                    );
                              // : OrderHistoryWidget(
                              //     controller: controller,
                              //     font: font,
                              //     productController: productController);
                            },
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

class OrderHistoryWidget extends StatelessWidget {
  OrderHistoryWidget({
    super.key,
    required this.controller,
    required this.productController,
    required this.font,
  });
  final CustomerController controller;
  final ProductController productController;
  final FontStyles font;
  final orderController = Get.put(OrderController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.orderHistoryList.length,
        itemBuilder: (context, index) {
          final order = controller.orderHistoryList[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller
                          .orderHistoryList[index].orderDetails.length,
                      itemBuilder: (context, index2) {
                        final data = controller
                            .orderHistoryList[index].orderDetails[index2];
                        return FutureBuilder<ProductModel?>(
                          future: productController.getProductDetails(
                              productId: data.productId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ListViewShimmerWidget();
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text("Error loading product details"));
                            } else if (snapshot.hasData) {
                              final ProductModel product = snapshot.data!;

                              return OrderListItems(
                                productName: product.productName,
                                productQty: data.productQty,
                                productPrice: product.productPrice,
                                productTotal: data.productTotal,
                              );
                            } else {
                              return const SizedBox
                                  .shrink(); // Handle empty case gracefully
                            }
                          },
                        );
                        // return OrderListItems(
                        //   font: font,
                        //   productName: product!.,
                        //   productQty: data.productQty,
                        // );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return controller.loading.value
                              ? const ShimmerWidget()
                              : ElevatedButton(
                                  onPressed: () async {
                                   
                                    controller.loading.value = true;

                                    try {
                                      await controller.editOrderFuction(
                                          index: index,
                                          orderController: orderController);
                                     
                                      orderController.editOrderHistory.value =
                                          true;

                                      homeController.pageIndex.value = 3;
                                    } finally {
                                      controller.loading.value = false;
                                    }
                                  },
                                  child: const Text("Edit"));
                        }),
                        Row(
                          children: [
                            const Text("Total"),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                order.orderHeader.orderTotal.toString(),
                                style: font.tittle2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
