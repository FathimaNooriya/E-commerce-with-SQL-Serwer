import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> alertWidget(
    {required String item, required Function okFunction}) {
  return Get.defaultDialog(
      title: "Delete Alert",
      titleStyle: const TextStyle(color: Colors.red),
      middleText: "Are you sure you want to delete $item",
      textConfirm: "yes",
      textCancel: "No",
      onCancel: () {},
      onConfirm: () {
        okFunction();
      });
}
