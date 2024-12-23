import 'package:ecoomprojone/Order/model/order_header_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Product/model/product_model.dart';
import '../../Product/service/product_service.dart';
import '../../customer/controller/customer_controller.dart';
import '../model/cart_list_model.dart';
import '../model/order_api_model.dart';
import '../model/order_detail_model.dart';
import '../service/order_service.dart';

class OrderController extends GetxController {
  RxDouble netTotal = 0.0.obs;
  RxDouble productTotal = 0.0.obs;
  Rx<DateTime?> picked = DateTime.now().obs;
  RxList<CartListModel> orderList = <CartListModel>[].obs;
  final customerController = Get.put(CustomerController());
  List<OrderDetailModel> orderDetailList = [];
  RxList<ProductModel> orderdProductList = <ProductModel>[].obs;
  RxBool editOrderHistory = false.obs;
  late Rx<OrderApiModel> editOrder;
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
    findNetTotal();
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
        price: productPrice, quantity: orderList[index].productQty);
    orderList[index] = orderList[index];
    findNetTotal();
  }

//...................Converts a DateTime object to a formatted string.................
  String convertDate({required DateTime date}) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

//...................Calculates the total price for a product based on its quantity.................
  double findProductPrce({required double price, int quantity = 1}) {
    findNetTotal();
    return productTotal.value = price * quantity;
  }

//...................Calculates the cumulative total of all products in the cart.................
  void findNetTotal() {
    netTotal.value = 0.0;
    for (int i = 0; i < orderList.length; i++) {
      netTotal.value = netTotal.value + orderList[i].productTotal;
    }
  }

//...................Submits the current order and updates product quantities in the database.................
  orderNow({required List<CartListModel> orderedList}) async {
    for (var order in orderedList) {
      orderDetailList.add(OrderDetailModel(
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

//...................Removes an item from the cart.................
  void deleteCartItem({required int index}) {
    orderList.removeAt(index);
    Get.back();
  }
}
