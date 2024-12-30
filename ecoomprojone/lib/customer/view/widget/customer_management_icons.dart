// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/customer_controller.dart';
// import '../../model/customer_model.dart';
// import '../../../home/controller/home_controller.dart';

// class CustomerManagementIcons extends StatelessWidget {
//   const CustomerManagementIcons({
//     super.key,
//     required this.customer,
//     required this.controller,
//   });

//   final CustomerModel customer;
//   final CustomerController controller;

//   @override
//   Widget build(BuildContext context) {
//     final homeController = Get.put(HomeController());
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         IconButton(
//             onPressed: () {
//               Get.defaultDialog(
//                 title: "Delete Alert",
//                 titleStyle: const TextStyle(color: Colors.red),
//                 middleText:
//                     "Are you sure you want to deleter ${customer.custName}",
//                 textConfirm: "yes",
//                 textCancel: "No",
//                 onCancel: () {
//                   // Get.back();
//                 },
//                 onConfirm: () {
//                   controller.deleteCustomer(customerId: customer.custId!);
//                   controller.getAllcust();
//                   Get.back();
//                 },
//               );
//             },
//             icon: const Icon(
//               Icons.delete,
//               color: Colors.red,
//               size: 25,
//             )),
//         IconButton(
//             onPressed: () {
//               controller.editCustomer(customer: customer);
//               homeController.pageIndex.value = 1;
//             },
//             icon: const Icon(
//               Icons.edit,
//               size: 24,
//             )),
//         IconButton(
//             onPressed: () {
//               controller.orderHistory(customer.custId!);
//               homeController.pageIndex.value = 5;
//             },
//             icon: const Icon(
//               Icons.shopping_cart_checkout_sharp,
//               color: Colors.green,
//               size: 25,
//             )),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Core/widgets/alert_widget.dart';
import '../../controller/customer_controller.dart';
import '../../model/customer_model.dart';
import '../../../home/controller/home_controller.dart';

class CustomerManagementIcons extends StatelessWidget {
  const CustomerManagementIcons({
    super.key,
    required this.customer,
  });

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    // Retrieve the HomeController once (outside build method to avoid reinitialization)
    final homeController = Get.find<HomeController>();
    final controller = Get.find<CustomerController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () => _deleteCustomer(context, controller, customer),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
            size: 25,
          ),
        ),
        IconButton(
          onPressed: () {
            controller.editCustomer(customer: customer);
            homeController.pageIndex.value = 1;
          },
          icon: const Icon(
            Icons.edit,
            size: 24,
          ),
        ),
        IconButton(
          onPressed: () async {
            await controller.orderHistory(customer.custId!);
            homeController.pageIndex.value = 5;
          },
          icon: const Icon(
            Icons.shopping_cart_checkout_sharp,
            color: Colors.green,
            size: 25,
          ),
        ),
      ],
    );
  }

  Future<void> _deleteCustomer(
    BuildContext context,
    CustomerController controller,
    CustomerModel customer,
  ) async {
    // Show confirmation alert
    alertWidget(
      item: customer.custName,
      okFunction: () async {
        try {
          // Perform deletion and refresh the list
          controller.deleteCustomer(customerId: customer.custId!);
          await controller.getAllcust();
          Get.back(); // Close alert dialog
        } catch (error) {
          // Show error feedback to the user
          Get.snackbar(
            'Error',
            'Failed to delete customer. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
    );
  }
}

// class CustomerManagementIcons extends StatelessWidget {
//   const CustomerManagementIcons({
//     super.key,
//     required this.customer,
//     required this.controller,
//   });

//   final CustomerModel customer;
//   final CustomerController controller;

//   @override
//   Widget build(BuildContext context) {
//     final homeController = Get.put(HomeController());
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         IconButton(
//             onPressed: () {
//              atertWidget(
//                 item: customer.custName,
//                 okFunction: () {
//                   controller.deleteCustomer(customerId: customer.custId!);
//                   controller.getAllcust();
//                   Get.back();
//                 },
//               );
//             },
//             icon: const Icon(
//               Icons.delete,
//               color: Colors.red,
//               size: 25,
//             )),
//         IconButton(
//             onPressed: () {
//               controller.editCustomer(customer: customer);
//               homeController.pageIndex.value = 1;
//             },
//             icon: const Icon(
//               Icons.edit,
//               size: 24,
//             )),
//         IconButton(
//             onPressed: () {
//               controller.orderHistory(customer.custId!);
//               homeController.pageIndex.value = 5;
//             },
//             icon: const Icon(
//               Icons.shopping_cart_checkout_sharp,
//               color: Colors.green,
//               size: 25,
//             )),
//       ],
//     );
//   }
// }
