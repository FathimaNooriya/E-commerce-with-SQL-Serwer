import 'package:ecoomprojone/Product/view/widget/add_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controller/home_controller.dart';
import '../controller/product_controller.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final controller = Get.put(ProductController());
    final homeController = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: controller.productFormkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: LayoutBuilder(builder: (context, constraints) {
              return constraints.maxWidth < 600
                  ? AddProductWidget(
                      controller: controller, homeController: homeController)
                  : Center(
                      child: SizedBox(
                        width: screenWidth * .5,
                        child: Card(
                            child: AddProductWidget(
                          controller: controller,
                          homeController: homeController,
                        )),
                      ),
                    );
            }),
          ),
        ),
      ),
    );
  }
}
