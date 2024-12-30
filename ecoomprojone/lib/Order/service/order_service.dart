import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/edit_ordet_model.dart';
import '../model/order_api_model.dart';

class OrderService {
  Future<void> addNewOrder({required OrderApiModel orderApiModel}) async {
    const String apiUrl = "https://localhost:7039/api/Cust/newOrder";
    try {
      final responce = await http.post(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(orderApiModel.toJson()));

      if (responce.statusCode == 201 || responce.statusCode == 200) {
        Get.snackbar("Success", " Order added");
        return;
      } else {
        Get.snackbar("Error", responce.statusCode.toString());
        return;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return;
    }
  }

  Future<List<OrderApiModel>?> getCustomerHistory(
      {required int customerId}) async {
    String apiUrl =
        "https://localhost:7039/api/Cust/GetCustOrdersHistory?customerId=$customerId";
    //  "https://localhost:7039/api/Cust/GetOrdersHistory?customerId=$customerId";

    try {
      final responce = await http.get(Uri.parse(apiUrl));

      if (responce.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(responce.body);
        return jsonData.map((data) => OrderApiModel.fromJson(data)).toList();
      } else {
        Get.snackbar("No data", "No orders found");

        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    }
  }

  Future<void> editCustomerHistory(
      {required EditOrderRequest editOrderRequest}) async {

    String apiUrl = "https://localhost:7039/api/Cust/EditCustOrdersHistory";

    try {
      final responce = await http.put(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(editOrderRequest.toJson()));
   
      if (responce.statusCode == 201 || responce.statusCode == 200) {
        Get.snackbar("Success", " Order updated");
        return;
      } else {
        Get.snackbar("No data", "No orders found");

        return;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return;
    }
  }
}
