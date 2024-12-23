class OrderHeaderModel {
  int? orderId;
  String orderDate;
  int custId;
  double orderTotal;
  OrderHeaderModel(
      {this.orderId,
      required this.orderDate,
      required this.custId,
      required this.orderTotal});
  factory OrderHeaderModel.fromJson(Map<String, dynamic> json) =>
      OrderHeaderModel(
          orderDate: json["order_date"],
          custId: json["cust_id"],
          orderTotal: json["order_net_total"],
          orderId: json["order_id"]);
  Map<String, dynamic> tojson() => {
        "order_date": orderDate,
        "cust_id": custId,
        "order_net_total": orderTotal,
      };
}
