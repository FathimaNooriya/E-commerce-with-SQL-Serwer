import 'package:ecoomprojone/customer/service/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Order/contoller/order_controller.dart';
import '../../Order/model/cart_list_model.dart';
import '../../Order/model/order_api_model.dart';
import '../../Order/model/order_detail_model.dart';
import '../../Order/model/order_header_model.dart';
import '../../Order/service/order_service.dart';
import '../../Product/controller/product_controller.dart';
import '../../home/controller/home_controller.dart';
import '../model/customer_model.dart';

class CustomerController extends GetxController {
  final GlobalKey<FormState> customerFormkey = GlobalKey<FormState>();
  TextEditingController custNameController = TextEditingController();
  TextEditingController custAdressController = TextEditingController();
  TextEditingController custPhoneNoController = TextEditingController();
  RxList<CustomerModel> cutomerList = <CustomerModel>[].obs;
  RxList<OrderApiModel> orderHistoryList = <OrderApiModel>[].obs;
  final productController = Get.put(ProductController());
  // final orderController = Get.put(OrderController());
  RxBool loading = false.obs;
  late RxInt selectedCustomer;
  RxBool customerUpdating = false.obs;
  late RxInt customerId;
  List<OrderDetailModel> editOrderDetailList = [];

  Rxn<CustomerModel> currentCustomer = Rxn<CustomerModel>();
  // RxList<CartListModel> editOrderHistoryList = <CartListModel>[].obs;
  @override
  onInit() {
    super.onInit();
    getAllcust();
  }

//...................Clears the text fields for customer.................
  void clear() {
    custNameController.clear();
    custAdressController.clear();
    custPhoneNoController.clear();
  }

//...................Fetches all customers from the database.................
  Future<void> getAllcust() async {
    loading.value = true;
    try {
      final result = await CustomerService().getAllCustomers();
      if (result != null) {
        cutomerList.value = result;
        selectedCustomer = cutomerList.first.custId!.obs;
      }
    } finally {
      loading.value = false;
    }
  }

//...................Fetches details of a specific customer using their ID..................
  Future<CustomerModel> getCustomerById({required int custId}) async {
    final result = await CustomerService().getCustomerById(custId: custId);
    return result!;
  }

//...................Set the text fields for editing a customer.................
  void editCustomer({required CustomerModel customer}) {
    customerUpdating.value = true;
    customerId = customer.custId!.obs;
    custNameController.text = customer.custName;
    custAdressController.text = customer.custAdress ?? " ";
    custPhoneNoController.text = customer.custPhoneNo;
  }

//...................Deletes a customer based on their ID.................
  void deleteCustomer({required int customerId}) async {
    await CustomerService().deleteCustomer(customerId: customerId);
    cutomerList.refresh();
  }

//...................Adds a new customer or updates an existing customer.................
  void saveCustomer({required HomeController homeController}) async {
    if (!customerFormkey.currentState!.validate()) {
      Get.snackbar("Error", "Please fill out all required fields correctly.");
      return;
    }

    final customerModel = CustomerModel(
      custId: customerUpdating.value ? customerId.value : null,
      custName: custNameController.text,
      custAdress: custAdressController.text,
      custPhoneNo: custPhoneNoController.text,
    );

    if (customerUpdating.value) {
      await CustomerService().updateCustomer(customerModel: customerModel);
      customerUpdating.value = false;
    } else {
      await CustomerService().addCustomer(customerModel: customerModel);
    }

    clear();
    getAllcust();
    homeController.pageIndex.value = 0;
  }

//...................Retrieves the order history of a specific customer.................
  Future<void> orderHistory(int customerId) async {
    orderHistoryList.clear();
    loading.value = true;
    final result =
        await OrderService().getCustomerHistory(customerId: customerId);

    if (result != null) {
      orderHistoryList.value = result;
    }

    loading.value = false;
  }

//...................setting details for editing order details.................
  // Future<void> editOrderFuction(
  //     {required int index, required OrderController orderController}) async {
  //   loading.value = true;
  //   orderController.editOrderHistory.value = true;
  //   final editOrderDetails = orderHistoryList[index];
  //   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  //   print(editOrderDetails.orderHeader.custId);
  //   currentCustomer.value =
  //       await getCustomerById(custId: editOrderDetails.orderHeader.custId);
  //   print(currentCustomer.value);
  //   for (var order in editOrderDetails.orderDetails) {
  //     editOrderDetailList.add(OrderDetailModel(
  //         productId: order.productId,
  //         productQty: order.productQty,
  //         productTotal: order.productTotal));
  //   }
  //   orderController.editOrder = (OrderApiModel(
  //           orderHeader: OrderHeaderModel(
  //               orderDate: editOrderDetails.orderHeader.orderDate,
  //               custId: editOrderDetails.orderHeader.custId,
  //               orderTotal: editOrderDetails.orderHeader.orderTotal),
  //           orderDetails: editOrderDetailList))
  //       .obs;
  //   loading.value = false;
  // }

  Future<void> editOrderFuction({
    required int index,
    required OrderController orderController,
  }) async {
    try {
      loading.value = true;
      orderController.editOrderHistory.value = true;
      orderController.editOrderdProductList.clear();
      final editOrderDetails = orderHistoryList[index];

      // Fetch and assign current customer
      currentCustomer.value =
          await getCustomerById(custId: editOrderDetails.orderHeader.custId);

      // Populate order details
      for (var order in editOrderDetails.orderDetails) {
        editOrderDetailList.add(OrderDetailModel(
          productId: order.productId,
          productQty: order.productQty,
          productTotal: order.productTotal,
        ));
        final product = await productController.getProductDetails(
            productId: order.productId);
        orderController.editOrderdProductList.add(CartListModel(
            productName: product.productName,
            productPrice: product.productPrice,
            productStock: product.productStock,
            productId: order.productId,
            productQty: order.productQty,
            productTotal: order.productTotal));
      }
      // Assign editOrder
      if (orderController.editOrder.value != null) {
        orderController.editOrder.value!.orderDetails.clear();
      }

      orderController.editOrder.value = OrderApiModel(
        orderHeader: OrderHeaderModel(
          orderId: editOrderDetails.orderDetails.first.orderId,
          orderDate: editOrderDetails.orderHeader.orderDate,
          custId: editOrderDetails.orderHeader.custId,
          orderTotal: editOrderDetails.orderHeader.orderTotal,
        ),
        orderDetails: editOrderDetailList,
      );
      orderController.findNetTotal(
        list: orderController.editOrderdProductList,
      );
      // editOrderDetailList.add(CartListModel(productId:order.productId ,productName:order.p ,productPrice: ,productQty: ,productStock: ,productTotal: ,orderId: ));
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      loading.value = false;
    }
  }
}
