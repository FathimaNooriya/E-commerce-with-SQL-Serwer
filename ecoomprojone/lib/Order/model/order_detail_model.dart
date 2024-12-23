class OrderDetailModel {
  int? orderId;
  int productId;
  int productQty;
  double productTotal;
  OrderDetailModel(
      {this.orderId,
      required this.productId,
      required this.productQty,
      required this.productTotal});
  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
          orderId: json["order_id"],
          productId: json["pdt_id"],
          productQty: json["pdt_qty"],
          productTotal: json["pdt_total"]);
  Map<String, dynamic> toJson() => {
        "pdt_id": productId,
        "pdt_qty": productQty,
        "pdt_total": productTotal,
      };
}
