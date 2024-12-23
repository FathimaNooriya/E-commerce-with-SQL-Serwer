import 'package:flutter/material.dart';

import '../../model/customer_model.dart';

class MiddileCustDetailsWidget extends StatelessWidget {
  const MiddileCustDetailsWidget({
    super.key,
    required this.customer,
  });

  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(customer.custName),
                Text(customer.custAdress ?? ""),
                Text(customer.custPhoneNo),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
