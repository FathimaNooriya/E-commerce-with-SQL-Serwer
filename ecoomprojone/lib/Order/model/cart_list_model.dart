class CartListModel {
  int? orderId;
  int productId;
  String productName;
  int productQty;
  double productPrice;
  double productTotal;
  int productStock;

  CartListModel(
      {this.orderId,
      required this.productId,
      required this.productName,
      required this.productQty,
      required this.productPrice,
      required this.productTotal,
      required this.productStock});
}
