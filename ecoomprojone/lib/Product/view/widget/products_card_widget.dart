import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/fonts/font_styles.dart';
import '../../../Order/contoller/order_controller.dart';
import '../../model/product_model.dart';

class ProductsCardWidget extends StatelessWidget {
  const ProductsCardWidget({
    super.key,
    required this.data,
    required this.font,
    required this.orderController,
  });

  final ProductModel data;
  final FontStyles font;
  final OrderController orderController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: SizedBox(
                  height: 90,
                  width: 120,
                  child: Image.network(
                      fit: BoxFit.cover,
                      "https://cdn.shopify.com/s/files/1/1403/8979/products/VintageCreamColorHighlighters-2_grande.png?v=1631344232"),
                ),
              ),
              Text(
                data.productName,
                style: font.tittle3,
              ),
              Text(data.productDescription!),
              data.productStock == 0
                  ? const Text(
                      "Out of Stock",
                      style: TextStyle(color: Colors.red),
                    )
                  : Text(
                      "Stock:${data.productStock.toString()}",
                    ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              // data.productStock == 0
              //     ? const Text(
              //         "Out of Stock",
              //         style: TextStyle(color: Colors.red),
              //       )
              //     : Text(
              //         "Stock:${data.productStock.toString()}",
              //       ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Rs:${data.productPrice.toString()}",
                    style: font.tittle3,
                  ),

                  //   ],
                  // ),
                  //  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       // Check if the product is already in the cart
                  //       bool isAlreadyInCart = orderController.orderList
                  //           .any((item) => item.productId == data.productId);

                  //       if (isAlreadyInCart) {
                  //         // Show a message or perform an action if the product is already in the cart
                  //         Get.snackbar("Cart",
                  //             "${data.productName} is already in the cart.");
                  //       } else if (data.productStock != 0) {
                  //         // Add the product to the cart
                  //         orderController.addOrderToList(product: data);
                  //       }
                  //     },
                  //     child: Text(
                  //       "Add to Cart",
                  //       style: font.tittle3,
                  //     )),
                  IconButton(
                      onPressed: () {
                        bool isAlreadyInCart = orderController.orderList
                            .any((item) => item.productId == data.productId);

                        if (isAlreadyInCart) {
                          // Show a message or perform an action if the product is already in the cart
                          Get.snackbar("Cart",
                              "${data.productName} is already in the cart.");
                        } else if (data.productStock != 0) {
                          // Add the product to the cart
                          orderController.addOrderToList(product: data);
                        }
                      },
                      icon: const Icon(
                        Icons.shopping_cart_checkout_sharp,
                        color: Colors.green,
                        size: 25,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
