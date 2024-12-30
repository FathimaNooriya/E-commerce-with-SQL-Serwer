import 'package:ecoomprojone/Core/widgets/listview_shimmer_widget.dart';
import 'package:ecoomprojone/customer/controller/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/customer_model.dart';
import 'widget/customer_list_item.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Obx(
            () => controller.loading.value
                ? const ListViewShimmerWidget()
                : constraints.maxWidth < 600
                    ? phoneView(controller)
                    : constraints.maxWidth < 1024
                        ? tabletView(controller)
                        : webView(controller),
          );
        },
      ),
    );
  }

  Widget phoneView(CustomerController controller) {
    return ListView.builder(
        itemCount: controller.cutomerList.length,
        itemBuilder: (context, index) {
          return CustomeListItem(
            customer: CustomerModel(
                custAdress: controller.cutomerList[index].custAdress,
                custName: controller.cutomerList[index].custName,
                custPhoneNo: controller.cutomerList[index].custPhoneNo,
                custId: controller.cutomerList[index].custId),
          );
        });
  }

  Widget tabletView(CustomerController controller) {
    return ListView.builder(
        itemCount: controller.cutomerList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomeListItem(
              customer: CustomerModel(
                  custAdress: controller.cutomerList[index].custAdress,
                  custName: controller.cutomerList[index].custName,
                  custPhoneNo: controller.cutomerList[index].custPhoneNo,
                  custId: controller.cutomerList[index].custId),
            ),
          );
        });
  }

  Widget webView(CustomerController controller) {
    return GridView.builder(
        itemCount: controller.cutomerList.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4 / 1.5,
        ),
        itemBuilder: (context, index) {
          return CustomeListItem(
            customer: CustomerModel(
                custAdress: controller.cutomerList[index].custAdress,
                custName: controller.cutomerList[index].custName,
                custPhoneNo: controller.cutomerList[index].custPhoneNo,
                custId: controller.cutomerList[index].custId),
          );
        });
  }
}

// class CustomerScreen extends StatelessWidget {
//   const CustomerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(CustomerController());
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Obx(() {
//             if (controller.loading.value) {
//               return const ListViewShimmerWidget();
//             }
//             final screenType = _getScreenType(constraints.maxWidth);
//             return _buildView(screenType, controller);
//           });
//         },
//       ),
//     );
//   }

//   ScreenType _getScreenType(double width) {
//     if (width < 600) return ScreenType.phone;
//     if (width < 1024) return ScreenType.tablet;
//     return ScreenType.web;
//   }

//   Widget _buildView(ScreenType type, CustomerController controller) {
//     switch (type) {
//       case ScreenType.phone:
//         return _buildListView(controller.cutomerList);
//       case ScreenType.tablet:
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 50),
//           child: _buildListView(controller.cutomerList),
//         );
//       case ScreenType.web:
//         return GridView.builder(
//           itemCount: controller.cutomerList.length,
//           shrinkWrap: true,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 4 / 1.5,
//           ),
//           itemBuilder: (context, index) => CustomeListItem(
//             customer: controller.cutomerList[index],
//           ),
//         );
//     }
//   }

//   Widget _buildListView(List<CustomerModel> customers) {
//     return ListView.builder(
//       itemCount: customers.length,
//       itemBuilder: (context, index) => CustomeListItem(
//         customer: customers[index],
//       ),
//     );
//   }
// }

// enum ScreenType { phone, tablet, web }
