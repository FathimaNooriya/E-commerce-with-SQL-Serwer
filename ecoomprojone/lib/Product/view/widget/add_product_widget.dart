import 'package:ecoomprojone/home/controller/home_controller.dart';
import 'package:flutter/material.dart';

import '../../../Core/widgets/custom_text_field.dart';
import '../../controller/product_controller.dart';

class AddProductWidget extends StatelessWidget {
  const AddProductWidget({
    super.key,
    required this.controller,
    required this.homeController,
  });

  final ProductController controller;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 90,
                width: 100,
                child: Image.network(
                    fit: BoxFit.cover,
                    "https://cdn.shopify.com/s/files/1/1403/8979/products/VintageCreamColorHighlighters-2_grande.png?v=1631344232"),
              ),
            ),
            const Text("Product Name"),
            CustomTextField(controller: controller.pdtNameController),
            const Text("Product Description"),
            CustomTextField(
              controller: controller.pdtDecsController,
              maxLines: 4,
              keyboardType: TextInputType.multiline,
            ),
            const Text("Product Price"),
            CustomTextField(
              controller: controller.pdtPriceController,
              keyboardType: TextInputType.number,
            ),
            const Text("Product Quantity"),
            CustomTextField(
              controller: controller.pdtQntityController,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      controller.addProduct(homeController: homeController);
                    },
                    child: controller.productUpdating.value
                        ? const Text("Update")
                        : const Text("Add")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
