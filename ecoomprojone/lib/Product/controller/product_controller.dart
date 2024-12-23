import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controller/home_controller.dart';
import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductController extends GetxController {
  final GlobalKey<FormState> productFormkey = GlobalKey<FormState>();
  TextEditingController pdtNameController = TextEditingController();
  TextEditingController pdtDecsController = TextEditingController();
  TextEditingController pdtPriceController = TextEditingController();
  TextEditingController pdtQntityController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> searchResultList = <ProductModel>[].obs;
  RxBool loading = false.obs;
  RxBool productStatus = false.obs;
  RxBool productUpdating = false.obs;
  late RxInt productId;

  @override
  void onInit() {
    super.onInit();
    getAllpdt();
  }

//...................Clears all text fields.................
  void clear() {
    pdtNameController.clear();
    pdtDecsController.clear();
    pdtPriceController.clear();
    pdtQntityController.clear();
    searchController.clear();
  }

//...................Fetches all products from the database.................
  Future<void> getAllpdt() async {
    loading.value = true;
    final result = await ProductService().getAllProducts();
    productList.value = result!;
    loading.value = false;
  }

//...................Fetches a product details by Id from database.................
  Future<ProductModel> getProductDetails({required int productId}) async {
    loading.value = true;
    try {
      final product =
          await ProductService().getProductById(productId: productId);
      loading.value = false;
      return product!;
    } catch (e) {
      loading.value = false;
      return ProductModel(
          productName: "productName",
          productDescription: "productDescription",
          productPrice: 0,
          productStock: 0); // Handle the error gracefully
    }
  }

//...................Prepares the controller for editing a product.................
  void editProduct({required ProductModel product}) {
    productUpdating.value = true;
    pdtNameController.text = product.productName;
    pdtDecsController.text = product.productDescription!;
    pdtPriceController.text = product.productPrice.toString();
    pdtQntityController.text = product.productStock.toString();
    productId = product.productId!.obs;
  }

//...................Adds or updates a product in the database..................
  Future<void> addProduct({required HomeController homeController}) async {
    if (!productFormkey.currentState!.validate()) {
      return;
    } else if (productUpdating.value) {
      await ProductService().updateProduct(
          product: ProductModel(
              productId: productId.value,
              productName: pdtNameController.text,
              productDescription: pdtDecsController.text,
              productPrice: double.parse(
                pdtPriceController.text,
              ),
              productStock: int.parse(
                pdtQntityController.text,
              )));

      productUpdating.value = false;
    } else {
      await ProductService().addProduct(
          productModel: ProductModel(
              productName: pdtNameController.text,
              productDescription: pdtDecsController.text,
              productPrice: double.parse(
                pdtPriceController.text,
              ),
              productStock: int.parse(
                pdtQntityController.text,
              )));
    }

    getAllpdt();
    clear();
    homeController.pageIndex.value = 2;
  }

// //...................Searches for products matching the input value..................
//   Future<List<ProductModel>> searchProduct({required String value}) async {
//     final result = await ProductService().searchProducts(searchValue: value);
//     return result!;
//   }

//...................Searches for products matching the input value.................
  Future<void> searchProducts({required String value}) async {
    if (value.isEmpty) {
      productStatus.value = false;
      getAllpdt();
    } else {
      final result = await ProductService().searchProducts(searchValue: value);
      if (result != null) {
        productStatus.value = false;
        productList.value = result;
      } else {
        productStatus.value = true;
      }
    }
  }
}
