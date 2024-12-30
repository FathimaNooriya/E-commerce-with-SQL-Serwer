
import 'order_detail_model.dart';
import 'order_header_model.dart';

class OrderApiModel {
  OrderHeaderModel orderHeader;
  List<OrderDetailModel> orderDetails;

  OrderApiModel({
    required this.orderHeader,
    required this.orderDetails,
  });

  // Factory constructor for deserialization
  factory OrderApiModel.fromJson(Map<String, dynamic> json) {
    return OrderApiModel(
      orderHeader: OrderHeaderModel.fromJson(json['orderHeader']),
      orderDetails: (json['orderDetails'] as List)
          .map((detail) => OrderDetailModel.fromJson(detail))
          .toList(),
    );
  }

  // Method for serialization
  Map<String, dynamic> toJson() {
    return {
      'orderHeader': orderHeader.tojson(),
      'orderDetails': orderDetails.map((detail) => detail.toJson()).toList(),
    };
  }
}

