import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../contoller/order_controller.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({
    super.key,
    required this.controller,
  });

  final OrderController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Obx(
              () => controller.editOrderHistory.value == false
                  ? Text(controller.convertDate(date: controller.picked.value!))
                  : Text(controller.convertDate(
                      orderHistoryDate:
                          controller.editOrder.value!.orderHeader.orderDate,
                      date: null)),
            )),
        controller.editOrderHistory.value == false
            ? IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () async {
                  controller.picked.value = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2035));
                },
              )
            : const SizedBox(),
      ],
    );
  }
}
