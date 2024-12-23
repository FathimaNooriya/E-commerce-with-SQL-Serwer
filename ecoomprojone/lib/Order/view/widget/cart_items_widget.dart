import 'package:flutter/material.dart';

import '../../../Core/fonts/font_styles.dart';
import '../../../Core/widgets/alert_widget.dart';
import '../../contoller/order_controller.dart';

class CartItems extends StatelessWidget {
  const CartItems(
      {super.key,
      required this.controller,
      required this.font,
      required this.index});

  final OrderController controller;
  final FontStyles font;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {
                atertWidget(
                    item: controller.orderList[index].productName,
                    okFunction: () {
                      controller.deleteCartItem(index: index);
                    });
              },
              icon: const Icon(
                Icons.close,
                size: 20,
                color: Colors.red,
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                          fit: BoxFit.cover,
                          "https://cdn.shopify.com/s/files/1/1403/8979/products/VintageCreamColorHighlighters-2_grande.png?v=1631344232"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(controller.orderList[index].productName),
                      controller.orderList[index].productStock == 0
                          ? const Text(
                              "Out of Stock",
                              style: TextStyle(color: Colors.red),
                            )
                          : Text(
                              "Stock: ${controller.orderList[index].productStock.toString()}"),
                      Text(
                          "Rs:  ${controller.orderList[index].productPrice.toString()}"),
                    ],
                  ),
                ],
              ),
              Card(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          if (controller.orderList[index].productStock != 0) {
                            controller.addQuantity(
                                add: false,
                                index: index,
                                quantity:
                                    controller.orderList[index].productQty,
                                productPrice:
                                    controller.orderList[index].productPrice,
                                stock:
                                    controller.orderList[index].productStock);
                          }
                        },
                        icon: const Icon(Icons.remove)),
                    Text(
                      controller.orderList[index].productQty.toString(),
                      // " 1 ",
                      style: font.tittle3,
                    ),
                    IconButton(
                        onPressed: () {
                          controller.addQuantity(
                              quantity: controller.orderList[index].productQty,
                              add: true,
                              index: index,
                              productPrice:
                                  controller.orderList[index].productPrice,
                              stock: controller.orderList[index].productStock);
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.orderList[index].productTotal.toString(),
                    style: font.tittle2,
                  ),
                ],
              )
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
