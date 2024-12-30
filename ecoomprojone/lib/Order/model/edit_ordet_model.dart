class EditOrderRequest {
  EditOrderHeaderModel editOrderHeader;
  List<OrderDetailsModel> orderDetails;

  EditOrderRequest({
    required this.editOrderHeader,
    required this.orderDetails,
  });

  // Factory constructor for deserialization
  factory EditOrderRequest.fromJson(Map<String, dynamic> json) {
    return EditOrderRequest(
      editOrderHeader: EditOrderHeaderModel.fromJson(json['editOrderHeader']),
      orderDetails: (json['orderDetails'] as List)
          .map((detail) => OrderDetailsModel.fromJson(detail))
          .toList(),
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      'editOrderHeader': editOrderHeader.toJson(),
      'orderDetails': orderDetails.map((detail) => detail.toJson()).toList(),
    };
  }
}

class EditOrderHeaderModel {
  int orderId;
  String orderDate; // Store the date as a string
  int custId;
  double orderNetTotal;

  EditOrderHeaderModel({
    required this.orderId,
    required this.orderDate,
    required this.custId,
    required this.orderNetTotal,
  });

  // Factory constructor for deserialization
  factory EditOrderHeaderModel.fromJson(Map<String, dynamic> json) {
    return EditOrderHeaderModel(
      orderId: json['order_id'],
      orderDate: json['order_date'], // Ensure correct format
      custId: json['cust_id'],
      orderNetTotal: json['order_net_total'].toDouble(),
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'order_date': orderDate, // Ensure correct format here
      'cust_id': custId,
      'order_net_total': orderNetTotal,
    };
  }
}

class OrderDetailsModel {
  int orderId;
  int productId;
  int productQty;
  double productTotal;

  OrderDetailsModel({
    required this.orderId,
    required this.productId,
    required this.productQty,
    required this.productTotal,
  });

  // Factory constructor for deserialization
  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      orderId: json['order_id'],
      productId: json['pdt_id'],
      productQty: json['pdt_qty'],
      productTotal: json['pdt_total'].toDouble(),
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'pdt_id': productId,
      'pdt_qty': productQty,
      'pdt_total': productTotal,
    };
  }
}
