import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/customer_model.dart';

class CustomerService {
  String baseUrl = "";
  String customerUrl = "";

  Future<List<CustomerModel>?> getAllCustomers() async {
    const String apiUrl = "https://localhost:7039/api/Cust/GetAllCust";

    try {
      final responce = await http.get(Uri.parse(apiUrl));

      if (responce.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(responce.body);

        return jsonData.map((data) => CustomerModel.fromJson(data)).toList();
      } else {
        Get.snackbar("Error", responce.statusCode.toString());

        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    }
  }

  Future<CustomerModel?> getCustomerById({required int custId}) async {
    String apiUrl =
        "https://localhost:7039/api/Cust/GetSingleCust?custId=$custId";

    try {
      final responce = await http.get(Uri.parse(apiUrl));

      if (responce.statusCode == 200) {
        final jsonData = jsonDecode(responce.body);

        return CustomerModel.fromJsonModel(jsonData as Map<String, dynamic>);
      } else {
        Get.snackbar("Error", responce.statusCode.toString());

        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    }
  }

  Future<void> addCustomer({required CustomerModel customerModel}) async {
    const String apiUrl = "https://localhost:7039/api/Cust/AddCustomer";
    try {
      final responce = await http.post(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(customerModel.toJson()));

      if (responce.statusCode == 201 || responce.statusCode == 200) {
        Get.snackbar("Success", "Customer Added");
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

  Future<void> updateCustomer({required CustomerModel customerModel}) async {
    const String apiUrl = "https://localhost:7039/api/Cust/UpdateCustomer";
    try {
      final responce = await http.put(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(customerModel.toJson()));
      if (responce.statusCode == 201 || responce.statusCode == 200) {
        Get.snackbar("Success", "customer updated");
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

  Future<void> deleteCustomer({required int customerId}) async {
    String apiUrl =
        "https://localhost:7039/api/Cust/DeleteCustomer?customerId=$customerId";
    try {
      final responce = await http.delete(Uri.parse(apiUrl));
      if (responce.statusCode == 201 || responce.statusCode == 200) {
        Get.snackbar("Success", "Customer deleted");
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
}
