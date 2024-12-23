
import 'package:flutter/material.dart';
import 'customer_management_icons.dart';
import 'middile_cust_detail_widget.dart';
import '../../model/customer_model.dart';

// class CustomeListItem extends StatelessWidget {
//   CustomeListItem({super.key, required this.customer});
//   final CustomerModel customer;
//   final controller = Get.put(CustomerController());

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       child: Card(
//         child: Container(
//           //  width: 500,
//           width: screenWidth * .8 < 250 ? screenWidth * .8 : 250,
//           height: screenHeight * .3 < 155 ? screenHeight * .3 : 155,
//           // height: MediaQuery.of(context).size.height * .2,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(
//                   children: [
//                     Text(customer.custId.toString()),
//                     const Icon(
//                       Icons.account_circle_rounded,
//                       size: 60,
//                     )
//                   ],
//                 ),
//               ),
//               const VerticalDivider(
//                 thickness: 3,
//               ),
//               MiddileCustDetailsWidget(customer: customer),
              
//               Padding(
//                 padding: const EdgeInsets.only(right: 10),
//                 child: CustomerManagementIcons(
//                     customer: customer, controller: controller),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomeListItem extends StatelessWidget {
  final CustomerModel customer;

  const CustomeListItem({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Card(
        child: Container(
          width: screenWidth * .8 < 250 ? screenWidth * .8 : 250,
          height: screenHeight * .3 < 155 ? screenHeight * .3 : 155,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAvatarSection(),
              const VerticalDivider(thickness: 3),
              MiddileCustDetailsWidget(customer: customer),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CustomerManagementIcons(customer: customer ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(customer.custId.toString()),
          const Icon(Icons.account_circle_rounded, size: 60),
        ],
      ),
    );
  }
}
