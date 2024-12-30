import 'package:flutter/material.dart';
import '../../../Core/fonts/font_styles.dart';
import '../../../Core/widgets/alert_widget.dart';
import '../../../Product/controller/product_controller.dart';
import '../../contoller/order_controller.dart';

class CartItemsWidget extends StatelessWidget {
  const CartItemsWidget({
    super.key,
    required this.productController,
    required this.controller,
    required this.font,
    required this.index,
    // required this.product,
  });
  final ProductController productController;
  final OrderController controller;
  final FontStyles font;
  final int index;
  // final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {
                alertWidget(
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

// Column(
//         children: [
//           Align(
//             alignment: Alignment.topRight,
//             child: IconButton(
//                 onPressed: () {
//                   alertWidget(
//                       item: controller.editOrderHistory.value == false
//                           ? controller.orderList[index].productName
//                           : controller.editOrderdProductList[index].productName,
//                       okFunction: () {
//                         controller.editOrderHistory.value
//                             ? controller.deleteEditOrderHistory(index: index)
//                             : controller.deleteCartItem(index: index);
//                       });
//                 },
//                 icon: const Icon(
//                   Icons.close,
//                   size: 20,
//                   color: Colors.red,
//                 )),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 20),
//                       child: SizedBox(
//                         height: 100,
//                         width: 100,
//                         child: Image.network(
//                             fit: BoxFit.cover,
//                             "https://cdn.shopify.com/s/files/1/1403/8979/products/VintageCreamColorHighlighters-2_grande.png?v=1631344232"),
//                       ),
//                     ),
//                     controller.editOrderHistory.value
//                         ? Obx(() {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(controller
//                                     .editOrderdProductList[index].productName),
//                                 controller.editOrderdProductList[index]
//                                             .productStock ==
//                                         0
//                                     ? const Text(
//                                         "Out of Stock",
//                                         style: TextStyle(color: Colors.red),
//                                       )
//                                     : Text(
//                                         "Stock: ${controller.editOrderdProductList[index].productStock.toString()}"),
//                                 Text(
//                                     "Rs:  ${controller.editOrderdProductList[index].productPrice.toString()}"),
//                               ],
//                             );
//                           })
//                         : Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text(controller.orderList[index].productName),
//                               controller.orderList[index].productStock == 0
//                                   ? const Text(
//                                       "Out of Stock",
//                                       style: TextStyle(color: Colors.red),
//                                     )
//                                   : Text(
//                                       "Stock: ${controller.orderList[index].productStock.toString()}"),
//                               Text(
//                                   "Rs:  ${controller.orderList[index].productPrice.toString()}"),
//                             ],
//                           ),
//                   ],
//                 ),
//                 controller.editOrderHistory.value
//                     ? Card(
//                         child: Row(
//                           children: [
//                             IconButton(
//                                 onPressed: () {
//                                   if (controller.editOrderHistory.value) {
//                                     controller.editHistoryAddQty(
//                                         add: false, index: index);
//                                   } else if (controller
//                                           .editOrderdProductList[index]
//                                           .productStock !=
//                                       0) {
//                                     controller.addQuantity(
//                                         add: false,
//                                         index: index,
//                                         quantity: controller
//                                             .editOrderdProductList[index]
//                                             .productQty,
//                                         //  controller.editOrder.value!
//                                         //     .orderDetails[index].productQty,
//                                         productPrice: controller
//                                             .editOrderdProductList[index]
//                                             .productPrice,
//                                         stock: controller
//                                             .editOrderdProductList[index]
//                                             .productStock);
//                                   }
//                                 },
//                                 icon: const Icon(Icons.remove)),
//                             Text(
//                               controller.editOrderdProductList[index].productQty
//                                   .toString(),
//                               style: font.tittle3,
//                             ),
//                             IconButton(
//                                 onPressed: () {
//                                   if (controller.editOrderHistory.value) {
//                                     controller.editHistoryAddQty(
//                                       index: index,
//                                       add: true,
//                                     );
//                                   } else {
//                                     controller.addQuantity(
//                                         quantity: controller
//                                             .editOrderdProductList[index]
//                                             .productQty,
//                                         //  controller.editOrder.value!
//                                         //     .orderDetails[index].productQty,
//                                         add: true,
//                                         index: index,
//                                         productPrice: controller
//                                             .editOrderdProductList[index]
//                                             .productPrice,
//                                         stock: controller
//                                             .editOrderdProductList[index]
//                                             .productStock);
//                                   }
//                                 },
//                                 icon: const Icon(Icons.add)),
//                           ],
//                         ),
//                       )
//                     : Card(
//                         child: Row(
//                           children: [
//                             IconButton(
//                                 onPressed: () {
//                                   if (controller
//                                           .orderList[index].productStock !=
//                                       0) {
//                                     controller.addQuantity(
//                                         add: false,
//                                         index: index,
//                                         quantity: controller
//                                             .orderList[index].productQty,
//                                         productPrice: controller
//                                             .orderList[index].productPrice,
//                                         stock: controller
//                                             .orderList[index].productStock);
//                                   }
//                                 },
//                                 icon: const Icon(Icons.remove)),
//                             Text(
//                               controller.orderList[index].productQty.toString(),
//                               // " 1 ",
//                               style: font.tittle3,
//                             ),
//                             IconButton(
//                                 onPressed: () {
//                                   controller.addQuantity(
//                                       quantity: controller
//                                           .orderList[index].productQty,
//                                       add: true,
//                                       index: index,
//                                       productPrice: controller
//                                           .orderList[index].productPrice,
//                                       stock: controller
//                                           .orderList[index].productStock);
//                                 },
//                                 icon: const Icon(Icons.add)),
//                           ],
//                         ),
//                       ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     controller.editOrderHistory.value
//                         ? Text(
//                             controller.editOrderdProductList[index].productTotal
//                                 .toString(),
//                             style: font.tittle2,
//                           )
//                         : Text(
//                             controller.orderList[index].productTotal.toString(),
//                             style: font.tittle2,
//                           ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           const Divider(),
//         ],
//       );
