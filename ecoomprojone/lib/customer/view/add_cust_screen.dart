import 'package:ecoomprojone/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/widgets/custom_text_field.dart';
import '../controller/customer_controller.dart';

class AddCustScreen extends StatelessWidget {
  const AddCustScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final custController = Get.put(CustomerController());
    final homeController = Get.put(HomeController());
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            return constraints.maxWidth < 600
                ? AddCustomerWidget(
                    custController: custController,
                    homeController: homeController,
                  )
                : Center(
                    child: SizedBox(
                      width: screenWidth * .5,
                      child: Card(
                        child: AddCustomerWidget(
                          custController: custController,
                          homeController: homeController,
                        ),
                      ),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}

class AddCustomerWidget extends StatelessWidget {
  const AddCustomerWidget({
    super.key,
    required this.custController,
    required this.homeController,
  });

  final CustomerController custController;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: custController.customerFormkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.account_circle_sharp,
                size: 100,
                color: Color.fromARGB(207, 174, 205, 226),
              ),
            ),
            const Text("Customer Name"),
            CustomTextField(
              controller: custController.custNameController,
              keyboardType: TextInputType.name,
              maxLines: 1,
            ),
            const Text("Customer Adress"),
            CustomTextField(
              controller: custController.custAdressController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            ),
            const Text("Customer Phone No"),
            CustomTextField(
              controller: custController.custPhoneNoController,
              keyboardType: TextInputType.number,
              maxLines: 1,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      custController.saveCustomer(
                          homeController: homeController);
                    },
                    child: custController.customerUpdating.value
                        ? const Text("Udate")
                        : const Text("Add")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
