import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ProductService {
  Future<List<ProductModel>?> getAllProducts() async {
    const String apiUrl = "https://localhost:7039/api/Cust/GetAllProduct";
    try {
      final responce = await http.get(Uri.parse(apiUrl));

      if (responce.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(responce.body);

        return jsonData.map((data) => ProductModel.fromJson(data)).toList();
      } else {
        Get.snackbar("No products", responce.statusCode.toString());

        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    }
  }

  Future<ProductModel?> getProductById({required int productId}) async {
    final String apiUrl =
        "https://localhost:7039/api/Cust/GetSingleProduct?productId=$productId";
    try {
      final responce = await http.get(Uri.parse(apiUrl));
      if (responce.statusCode == 200) {
        final jsonData = jsonDecode(responce.body);
        return ProductModel.fromJson(jsonData);
      } else {
        Get.snackbar("Error", responce.statusCode.toString());
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    }
  }

  Future<void> addProduct({required ProductModel productModel}) async {
    const String apiUrl = "https://localhost:7039/api/Cust/AddProduct";

    try {
      final responce = await http.post(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(productModel.toJson()));

      if (responce.statusCode == 201 || responce.statusCode == 200) {
        Get.snackbar("Success", "Product added");
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

  Future<void> updateQuantity({required List<ProductModel> productList}) async {
    const String apiUrl =
        "https://localhost:7039/api/Cust/UpdateProductQuantity";
    try {
      final responce = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          productList.map((product) => product.toJson()).toList(),
        ),
      );
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Get.snackbar("Success", "Quantity updated");
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

  Future<void> updateProduct({required ProductModel product}) async {
    const String apiUrl = "https://localhost:7039/api/Cust/UpdateProduct";
    try {
      final responce = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (responce.statusCode == 200 || responce.statusCode == 201) {
        Get.snackbar("Success", "Product Updated");
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

  Future<void> deleteProduct({required int productId}) async {
    final String apiUrl =
        "https://localhost:7039/api/Cust/DeleteProduct?productId=$productId";
    try {
      final responce = await http.delete(Uri.parse(apiUrl));
      if (responce.statusCode == 200) {
        Get.snackbar("Success", "Product deleted");
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

  Future<List<ProductModel>?> searchProducts(
      {required String searchValue}) async {
    String apiUrl =
        "https://localhost:7039/api/Cust/SearchProduct?searchValue=$searchValue";
    try {
      final responce = await http.get(Uri.parse(apiUrl));

      if (responce.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(responce.body);
        return jsonData.map((data) => ProductModel.fromJson(data)).toList();
      } else {
        Get.snackbar("No data", "No product found");
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    }
  }
}
