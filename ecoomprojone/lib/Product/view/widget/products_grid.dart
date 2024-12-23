import 'package:ecoomprojone/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/fonts/font_styles.dart';
import '../../../Core/widgets/shimmer_widget.dart';
import '../../../Order/contoller/order_controller.dart';
import '../../controller/product_controller.dart';
import 'products_card_widget.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
    required this.controller,
    required this.orderController,
    required this.font,
    required this.homeController,
  });
  final ProductController controller;
  final OrderController orderController;
  final FontStyles font;
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? const ShimmerWidget()
          : controller.productList.isEmpty
              ? const Center(
                  child: Text("No Products Found"),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                        itemCount: controller.productList.length,
                        shrinkWrap: true,
                        gridDelegate: constraints.maxWidth < 600
                            ? const SliverGridDelegateWithMaxCrossAxisExtent(
                                childAspectRatio: 4 / 5.8,
                                maxCrossAxisExtent: 250,
                                mainAxisExtent: 290,
                                crossAxisSpacing: .5,
                                mainAxisSpacing: .5)
                            : constraints.maxWidth < 1024
                                ? const SliverGridDelegateWithMaxCrossAxisExtent(
                                    childAspectRatio: 4 / 5.5,
                                    maxCrossAxisExtent: 250,
                                    mainAxisExtent: 270,
                                    crossAxisSpacing: .5,
                                    mainAxisSpacing: .5)
                                : const SliverGridDelegateWithMaxCrossAxisExtent(
                                    childAspectRatio: 4 / 4.5,
                                    maxCrossAxisExtent: 250,
                                    mainAxisExtent: 270,
                                    crossAxisSpacing: .5,
                                    mainAxisSpacing: .5),
                        itemBuilder: (context, index) {
                          final data = controller.productList[index];
                          return InkWell(
                            onTap: () {
                              controller.editProduct(product: data);
                              homeController.pageIndex.value = 4;
                            },
                            child: ProductsCardWidget(
                                data: data,
                                font: font,
                                orderController: orderController),
                          );
                        });
                  },
                ),
    );
  }
}
