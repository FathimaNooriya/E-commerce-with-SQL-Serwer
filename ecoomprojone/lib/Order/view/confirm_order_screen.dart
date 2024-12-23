import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/fonts/font_styles.dart';
import '../../home/controller/home_controller.dart';
import '../contoller/order_controller.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final font = FontStyles();
    final controller = Get.put(OrderController());
    final homeController = Get.put(HomeController());
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth < 600 ? screenWidth * .99 : 600,
            child: Card(
              child: Column(
                mainAxisAlignment: constraints.maxWidth < 600
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceAround,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        border: TableBorder.all(width: 1),
                        columns: createColumns(),
                        headingRowColor: WidgetStateProperty.resolveWith(
                            (states) =>
                                const Color.fromARGB(207, 174, 205, 226)),
                        rows: createRows()),
                  ),
                  Padding(
                    padding: constraints.maxWidth < 600
                        ? const EdgeInsets.all(5)
                        : const EdgeInsets.only(
                            left: 25,
                            right: 20,
                            bottom: 10,
                          ),
                    child: Padding(
                      padding: constraints.maxWidth < 600
                          ? const EdgeInsets.symmetric(horizontal: 20)
                          : const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                      child: controller.orderList.isEmpty
                          ? const SizedBox()
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total",
                                      style: constraints.maxWidth < 600
                                          ? font.tittle3
                                          : font.tittle2,
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.netTotal.value.toString(),
                                        style: constraints.maxWidth < 600
                                            ? font.tittle2
                                            : font.tittle1,
                                      ),
                                    )
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      await controller.orderNow(
                                          orderedList: controller.orderList);

                                      homeController.pageIndex.value = 2;
                                    },
                                    child: Text(
                                      "Confirm Order",
                                      style: font.tittle2,
                                    ))
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  List<DataColumn> createColumns() {
    return [
      const DataColumn(
          label: Text(
        "Product Name",
      )),
      const DataColumn(label: Text("Quatity")),
      const DataColumn(label: Text("Price")),
      const DataColumn(label: Text("Total Price")),
    ];
  }

  List<DataRow> createRows() {
    final controller = Get.put(OrderController());
    return controller.orderList
        .map((order) => DataRow(cells: [
              DataCell(Text(order.productName)),
              DataCell(Text(order.productQty.toString())),
              DataCell(Text(order.productPrice.toString())),
              DataCell(Text(order.productTotal.toString()))
            ]))
        .toList();
  }
}
