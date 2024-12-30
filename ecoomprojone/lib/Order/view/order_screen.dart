import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/fonts/font_styles.dart';
import '../../Product/controller/product_controller.dart';
import '../../Product/view/widget/shimmer_widget.dart';
import '../../customer/controller/customer_controller.dart';
import '../../home/controller/home_controller.dart';
import '../contoller/order_controller.dart';
import 'widget/calender_widget.dart';
import 'widget/cart_items_widget.dart';
import 'widget/customer_drop_down.dart';
import 'widget/edit_history_cart_items.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CalenderWidget(controller: controller),
              Obx(() {
                return controller.editOrderHistory.value
                    ? Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            customerController
                                    .currentCustomer.value?.custName ??
                                "Customer",
                          ),
                        ),
                      )
                    : CustomerDropDown(customerController: customerController);
              }),
            ],
          ),

          // Cart Items List

          controller.editOrderHistory.value
              ? controller.editOrderdProductList.isEmpty
                  ? const Center(child: Text("No items found"))
                  : Obx(() {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.editOrderdProductList.length,
                          itemBuilder: (context, index) {
                            return EditHistoryCartItems(
                              productController: productController,
                              controller: controller,
                              font: font,
                              index: index,
                            );
                          });
                    })
              : controller.orderList.isEmpty
                  ? const Center(child: Text("No items found"))
                  : Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.orderList.length,
                        itemBuilder: (context, index) {
                          return CartItemsWidget(
                            productController: productController,
                            controller: controller,
                            font: font,
                            index: index,
                          );
                        },
                      );
                    }),

          // Total & Order Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  homeController.pageIndex.value = 2;
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Product"),
              ),
              Obx(() => Text(
                    "Total: ${controller.netTotal.value}",
                    style: font.tittle2,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                homeController.pageIndex.value = 6;
              },
              child: Text("Order Now", style: font.tittle2),
            ),
          ),
        ],
      ),
    );
  }
}

// class CartItems extends StatelessWidget {
//   const CartItems({
//     super.key,
//     required this.productController,
//     required this.controller,
//     required this.font,
//     required this.index,
//   });

//   final ProductController productController;
//   final OrderController controller;
//   final FontStyles font;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Column(
//         children: [
//           Align(
//             alignment: Alignment.topRight,
//             child: IconButton(
//               onPressed: () {
//                 alertWidget(
//                   item: controller.editOrderHistory.value
//                       ? controller.editOrderdProductList[index].productName
//                       : controller.orderList[index].productName,
//                   okFunction: () {
//                     controller.editOrderHistory.value
//                         ? controller.deleteEditOrderHistory(index: index)
//                         : controller.deleteCartItem(index: index);
//                   },
//                 );
//               },
//               icon: const Icon(Icons.close, color: Colors.red),
//             ),
//           ),
//           Row(
//             children: [
//               SizedBox(
//                 height: 100,
//                 width: 100,
//                 child: Image.network(
//                   "https://via.placeholder.com/100",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(controller.editOrderHistory.value
//                       ? controller.editOrderdProductList[index].productName
//                       : controller.orderList[index].productName),
//                   Text(
//                     "Price: ${controller.editOrderHistory.value ? controller.editOrderdProductList[index].productPrice : controller.orderList[index].productPrice}",
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       );
//     });
//   }
// }



// class Orderscreen extends StatelessWidget {
//   const Orderscreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final font = FontStyles();
//     final controller = Get.put(OrderController());
//     final customerController = Get.put(CustomerController());
//     final productController = Get.put(ProductController());
//     final homeController = Get.put(HomeController());
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: customerController.loading.value
//           ? const ShimmerWidget()
//           : LayoutBuilder(builder: (context, constraints) {
//               return constraints.maxWidth < 600
//                   ? CartWidget(
//                       customerController: customerController,
//                       homeController: homeController,
//                       controller: controller,
//                       font: font,
//                       productController: productController)
//                   : Center(
//                       child: SizedBox(
//                         width: screenWidth * .7,
//                         child: Card(
//                           child: CartWidget(
//                               customerController: customerController,
//                               homeController: homeController,
//                               controller: controller,
//                               font: font,
//                               productController: productController),
//                         ),
//                       ),
//                     );
//             }),
//     );
//   }
// }

// class CartWidget extends StatelessWidget {
//   const CartWidget({
//     super.key,
//     required this.controller,
//     required this.font,
//     required this.productController,
//     required this.homeController,
//     required this.customerController,
//   });

//   final OrderController controller;
//   final FontStyles font;
//   final ProductController productController;
//   final HomeController homeController;
//   final CustomerController customerController;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: ListView(
//         children: [
//           // Header with Calendar and Customer Dropdown
//           Padding(
//             padding: const EdgeInsets.only(right: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 CalenderWidget(controller: controller),
//                 const SizedBox(width: 10),
//                 Obx(() {
//                   if (customerController.loading.value) {
//                     return Shimmer(
//                       child: Container(
//                         color: Colors.red,
//                         width: 60,
//                         height: 20,
//                       ),
//                     );
//                   }
//                   return controller.editOrderHistory.value
//                       ? Card(
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(customerController
//                                         .currentCustomer.value?.custName ??
//                                     "Customer"),
//                               ),
//                               const Icon(Icons.account_circle,
//                                   size: 35, color: Colors.blueAccent),
//                             ],
//                           ),
//                         )
//                       : CustomerDropDown(
//                           customerController: customerController);
//                 }),
//               ],
//             ),
//           ),

//           // Cart Table Heading
//           CartTableHeading(font: font),
//           const Divider(),

//           // Cart Items List
//           Obx(
//             () {
//               if (!controller.editOrderHistory.value &&
//                   controller.orderList.isEmpty) {
//                 return const Center(child: Text("No items found"));
//               }
//               // return ListView.builder(
//               //   shrinkWrap: true,
//               //   physics: const NeverScrollableScrollPhysics(),
//               //   itemCount: controller.editOrderHistory.value == false
//               //       ? controller.orderList.length
//               //       : controller.editOrder.value!.orderDetails.length,
//               //   itemBuilder: (context, index) {
//               //     if (controller.editOrderHistory.value) {
//               //       final productId = controller
//               //           .editOrder.value!.orderDetails[index].productId;

//               //       // Use FutureBuilder to fetch and display product details
//               //       return FutureBuilder<ProductModel>(
//               //         future: productController.getProductDetails(
//               //             productId: productId),
//               //         builder: (context, snapshot) {
//               //           if (snapshot.connectionState ==
//               //               ConnectionState.waiting) {
//               //             return const Center(child: Text("Loading..."));
//               //           } else if (snapshot.hasError) {
//               //             return Center(
//               //                 child: Text("Error: ${snapshot.error}"));
//               //           } else if (snapshot.hasData) {
//               //             controller.editOrderProduct.value = snapshot.data!;
//               //             return CartItems(
//               //               productController: productController,
//               //               index: index,
//               //             //  product: controller.editOrderProduct.value!,
//               //               controller: controller,
//               //               font: font,
//               //             );
//               //           } else {
//               //             return const Center(child: Text("No product found"));
//               //           }
//               //         },
//               //       );
//               //     } else {
//               //       return const Text("Cart data");
//               //     }
//               //   },
//               // );

//               return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: controller.editOrderHistory.value == false
//                       ? controller.orderList.length
//                       : controller.editOrderdProductList.length,
//                   // controller.editOrder.value!.orderDetails.length,
//                   itemBuilder: (context, index) {
//                     controller.findNetTotal(
//                         list: controller.editOrderdProductList);
//                     // return Obx(() {
//                     //   if (productController.loading.value) {
//                     //     return const Text("Loading...");
//                     //   }
//                     // if (controller.editOrderHistory.value) {
//                     //   // Fetch product if in edit mode
//                     //   controller.feachProduct(
//                     //     productId: controller
//                     //         .editOrder.value!.orderDetails[index].productId,
//                     //   );

//                     // final product = controller.editOrderProduct.value!;
//                     // print(product.productName);
//                     // print(index); // return Obx(() {
//                     if (productController.loading.value) {
//                       return const Text("Loading...");
//                     }
//                     return CartItems(
//                       productController: productController,
//                       index: index,
//                       //   product: product,
//                       controller: controller,
//                       font: font,
//                     );
//                     // } else {
//                     //   return Text("cart data");
//                     // }
//                   });
//             },
//           ),
//           // }),

//           // Total and Order Button
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     homeController.pageIndex.value = 2;
//                   },
//                   icon: const Icon(Icons.add),
//                   label: const Text("Add Product"),
//                 ),
//                 Text("Total", style: font.tittle2),
//                 Obx(() => Text(
//                       controller.netTotal.value.toString(),
//                       style: font.tittle1,
//                     )),
//               ],
//             ),
//           ),

//           // Order Now Button
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: ElevatedButton(
//               onPressed: () {
//                 homeController.pageIndex.value = 6;
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Text("Order Now", style: font.tittle2),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// // class CartWidget extends StatelessWidget {
// //   const CartWidget({
// //     super.key,
// //     required this.controller,
// //     required this.font,
// //     required this.productController,
// //     required this.homeController,
// //     required this.customerController,
// //   });

// //   final OrderController controller;
// //   final FontStyles font;
// //   final ProductController productController;
// //   final HomeController homeController;
// //   final CustomerController customerController;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(10.0),
// //       child: ListView(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.only(right: 20),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.end,
// //               children: [
// //                 CalenderWidget(controller: controller),
// //                 Padding(
// //                   padding: const EdgeInsets.only(left: 10),
// //                   child: Obx(
// //                     () => customerController.loading.value == true
// //                         ? Shimmer(
// //                             child: Container(
// //                             color: Colors.red,
// //                             width: 60,
// //                           ))
// //                         : customerController.loading.value == false &&
// //                                 controller.editOrderHistory.value == true
// //                             ? Card(
// //                                 child: Row(
// //                                   children: [
// //                                     Padding(
// //                                       padding: const EdgeInsets.all(8.0),
// //                                       child: Text(customerController
// //                                           .currentCustomer.value!.custName),
// //                                     ),
// //                                     const Icon(Icons.account_circle,
// //                                         size: 35, color: Colors.blueAccent),
// //                                   ],
// //                                 ),
// //                               )
// //                             : CustomerDropDown(
// //                                 customerController: customerController),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           CartTableHeading(font: font),
// //           const Divider(),
// //           Obx(
// //             () => controller.editOrderHistory.value == false &&
// //                     controller.orderList.isEmpty
// //                 ? const Center(
// //                     child: Text(
// //                     "no  items found",
// //                   ))
// //                 // :Text("edit")
// //                 : Column(
// //                     crossAxisAlignment: CrossAxisAlignment.end,
// //                     children: [
// //                       ListView.builder(
// //                           shrinkWrap: true,
// //                           itemCount: controller.editOrderHistory.value == false
// //                               ? controller.orderList.length
// //                               : controller.editOrder.value!.orderDetails.length,
// //                           itemBuilder: (context, index) {


                            
// //                             print(index);
// //                              return Obx(() {
// //       if (productController.loading.value) {
// //         return const Text("Cart Items"); // Placeholder for loading state
// //       } else if (controller.editOrderHistory.value) {
// //         // Ensure data fetching is done before this block
// //         controller.feachProduct(
// //           productId: controller.editOrder.value!.orderDetails[index].productId,
// //         );

// //         return CartItems(
// //           productController: productController,
// //           index: index,
// //           controller: controller,
// //           font: font,
// //         );
// //       } else {
// //         return const Text("ghhhhhhhhhhhhh"); // Placeholder for non-editOrderHistory state
// //       }
// //                             // return Obx(() {
// //                             //   productController.loading.value
// //                             //       ? const Text("Cart Items")
// //                             //       // const ListViewShimmerWidget()
// //                             //       : controller.editOrderHistory.value
// //                             //           ? {
// //                             //               controller.feachProduct(
// //                             //                   productId: controller
// //                             //                       .editOrder
// //                             //                       .value!
// //                             //                       .orderDetails[index]
// //                             //                       .productId),
// //                             //               CartItems(
// //                             //                   productController:
// //                             //                       ProductController(),
// //                             //                   index: index,
// //                             //                   controller: controller,
// //                             //                   font: font)
// //                             //             }
// //                             //           : Text("ghhhhhhhhhhhhh");
// //                              });
// //                           }),
// //                       Padding(
// //                         padding: const EdgeInsets.only(
// //                           left: 15,
// //                           right: 10,
// //                           bottom: 10,
// //                         ),
// //                         child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             ElevatedButton.icon(
// //                               onPressed: () {},
// //                               label: const Text("Add Product"),
// //                               icon: const Icon(Icons.add),
// //                             ),
// //                             Text(
// //                               "Total",
// //                               style: font.tittle2,
// //                             ),
// //                             // Obx(
// //                             //   () =>
// //                             Text(
// //                               controller.netTotal.value.toString(),
// //                               style: font.tittle1,
// //                             ),
// //                             //)
// //                           ],
// //                         ),
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 10),
// //                         child: ElevatedButton(
// //                             onPressed: () {
// //                               homeController.pageIndex.value = 6;
// //                             },
// //                             child: Padding(
// //                               padding: const EdgeInsets.symmetric(vertical: 10),
// //                               child: Text(
// //                                 "Order Now",
// //                                 style: font.tittle2,
// //                               ),
// //                             )),
// //                       )
// //                     ],
// //                   ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
