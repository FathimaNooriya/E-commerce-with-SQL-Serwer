import 'package:ecoomprojone/Order/model/order_header_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Product/controller/product_controller.dart';
import '../../Product/model/product_model.dart';
import '../../Product/service/product_service.dart';
import '../../customer/controller/customer_controller.dart';
import '../model/cart_list_model.dart';
import '../model/edit_ordet_model.dart';
import '../model/order_api_model.dart';
import '../model/order_detail_model.dart';
import '../service/order_service.dart';

class OrderController extends GetxController {
  RxDouble netTotal = 0.0.obs;
  RxDouble productTotal = 0.0.obs;
  Rx<DateTime?> picked = DateTime.now().obs;
  RxList<CartListModel> orderList = <CartListModel>[].obs;
  final customerController = Get.put(CustomerController());
  final productController = Get.put(ProductController());
  List<OrderDetailModel> orderDetailList = [];
  List<OrderDetailsModel> editOrderDetailList = [];
  RxList<ProductModel> orderdProductList = <ProductModel>[].obs;
  RxBool editOrderHistory = false.obs;
  // Rxn<ProductModel> editOrderProduct = Rxn<ProductModel>();
  Rx<OrderApiModel?> editOrder = Rx<OrderApiModel?>(null);
  RxList<CartListModel> editOrderdProductList = <CartListModel>[].obs;

  @override
  onInit() {
    super.onInit();
    customerController.getAllcust();
    orderDetailList.clear();
  }

//...................Adds a product to the cart..................
  void addOrderToList({required ProductModel product}) {
    orderList.add(CartListModel(
        productId: product.productId!,
        productName: product.productName,
        productQty: 1,
        productPrice: product.productPrice,
        productTotal: product.productPrice,
        productStock: product.productStock - 1));
    Get.snackbar(
        "Poduct added to cart", "${product.productName} added to cart");
    findNetTotal(list: orderList);
  }

  editHistoryAddQty({
    required bool add,
    required int index,
  }) {
    if (add == true && editOrderdProductList[index].productStock > 0) {
      editOrderdProductList[index].productStock =
          editOrderdProductList[index].productStock - 1;
      editOrderdProductList[index].productQty =
          editOrderdProductList[index].productQty + 1;
    } else if (add == false && editOrderdProductList[index].productQty > 1) {
      editOrderdProductList[index].productStock =
          editOrderdProductList[index].productStock + 1;
      editOrderdProductList[index].productQty =
          editOrderdProductList[index].productQty - 1;
    }
    editOrderdProductList[index].productTotal = findProductPrce(
        list: editOrderdProductList,
        price: editOrderdProductList[index].productPrice,
        quantity: editOrderdProductList[index].productQty);
    editOrderdProductList[index] = editOrderdProductList[index];
    findNetTotal(list: editOrderdProductList);
  }

//...................Increases or decreases the quantity of a product.................
  void addQuantity(
      {required bool add,
      required int index,
      required int quantity,
      required int stock,
      required double productPrice}) {
    if (stock > 0 && add == true) {
      orderList[index].productQty = quantity + 1;
      orderList[index].productStock = stock - 1;
    } else if (quantity > 1 && add == false) {
      orderList[index].productQty = quantity - 1;
      orderList[index].productStock = stock + 1;
    }
    orderList[index].productTotal = findProductPrce(
      list: orderList,
      price: productPrice,
      quantity: orderList[index].productQty,
    );
    // orderList[index] = orderList[index];
    orderList.refresh();
    findNetTotal(list: orderList);
  }

//...................Converts a DateTime object to a formatted string.................
  String convertDate({DateTime? date, String? orderHistoryDate}) {
    DateTime parsedDate;
    if (orderHistoryDate != null) {
      parsedDate = DateTime.parse(orderHistoryDate);
    } else {
      parsedDate = date!;
    }
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  String convertToApiDateFormat(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} "
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  }

//...................Calculates the total price for a product based on its quantity.................
  double findProductPrce(
      {required double price, int quantity = 1, required List<dynamic> list}) {
    findNetTotal(list: list);
    return productTotal.value = price * quantity;
  }

//...................Calculates the cumulative total of all products in the cart.................
  void findNetTotal({required List<dynamic> list}) {
    netTotal.value = 0.0;
    for (int i = 0; i < list.length; i++) {
      netTotal.value = netTotal.value + list[i].productTotal;
    }
  }

//...................Submits the current order and updates product quantities in the database.................
  orderNow({required List<CartListModel> orderedList}) async {
    for (var order in orderedList) {
      orderDetailList.add(OrderDetailModel(
        productId: order.productId,
        productQty: order.productQty,
        productTotal: order.productTotal,
      ));
      orderdProductList.add(ProductModel(
          productName: order.productName,
          productDescription: order.productName,
          productPrice: order.productPrice,
          productStock: order.productStock,
          productId: order.productId));
    }

    await OrderService().addNewOrder(
        orderApiModel: OrderApiModel(
            orderHeader: OrderHeaderModel(
                orderDate: picked.value!.toIso8601String(),
                custId: customerController.selectedCustomer.value,
                orderTotal: netTotal.value),
            orderDetails: orderDetailList));

    await ProductService().updateQuantity(productList: orderdProductList);
    orderList.clear();
    orderdProductList.clear();
    netTotal.value = 0;
  }

  conformEditOrderHistory() async {
    orderDetailList.clear();
    orderdProductList.clear();
    for (var order in editOrderdProductList) {
      editOrderDetailList.add(OrderDetailsModel(
          orderId: editOrder.value!.orderHeader.orderId!,
          productId: order.productId,
          productQty: order.productQty,
          productTotal: order.productTotal));
      orderdProductList.add(ProductModel(
          productName: order.productName,
          productDescription: order.productName,
          productPrice: order.productPrice,
          productStock: order.productStock,
          productId: order.productId));
    }

    await OrderService().editCustomerHistory(
        editOrderRequest: EditOrderRequest(
            editOrderHeader: EditOrderHeaderModel(
                orderId: editOrder.value!.orderHeader.orderId!,
                orderDate: editOrder.value!.orderHeader.orderDate,
                custId: editOrder.value!.orderHeader.custId,
                orderNetTotal: netTotal.value),
            orderDetails: editOrderDetailList));

    await ProductService().updateQuantity(productList: orderdProductList);
    editOrderdProductList.clear();
    orderdProductList.clear();
    editOrderHistory.value = false;
    netTotal.value = 0;
  }

//...................Removes an item from the cart.................
  void deleteCartItem({required int index}) {
    orderList.removeAt(index);
    findNetTotal(list: orderList);
    orderList.refresh();
    Get.back();
  }

  void deleteEditOrderHistory({required int index}) {
    editOrderdProductList.removeAt(index);
    findNetTotal(list: editOrderdProductList);
    editOrderdProductList.refresh();
    Get.back();
  }

  // //.................Edit Order history.................
  // Future<ProductModel?> feachProduct({required int productId}) async {
  //   print(".......fech............");
  //   editOrderProduct.value =
  //       await productController.getProductDetails(productId: productId);
  //   final product = editOrderProduct.value;

  //   print(editOrderProduct.value!.productId);
  //   return product;
  // }
}
