import 'package:flutter/material.dart';
import '../../../customer/controller/customer_controller.dart';
import '../../../customer/model/customer_model.dart';

class CustomerDropDown extends StatelessWidget {
  const CustomerDropDown({
    super.key,
    required this.customerController,
  });

  final CustomerController customerController;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      borderRadius: BorderRadius.circular(10),
      hint: const Text("Select a customer"),
      value: customerController
          .selectedCustomer.value, // This will now store the customer ID
      icon:
          const Icon(Icons.account_circle, size: 35, color: Colors.blueAccent),
      items: customerController.cutomerList.map((CustomerModel model) {
        return DropdownMenuItem<int>(
          value: model.custId, // Use the customer ID as the value
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(model.custName),
          ), // Display the customer name
        );
      }).toList(),
      onChanged: (int? newValue) {
        if (newValue != null) {
          customerController.selectedCustomer.value =
              newValue; // Store only the customer ID
        }
      },
    );
  }
}
