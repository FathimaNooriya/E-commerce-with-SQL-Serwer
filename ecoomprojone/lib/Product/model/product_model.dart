class ProductModel {
  int? productId;
  String productName;
  String? productDescription;
  double productPrice;
  int productStock;
  ProductModel(
      {this.productId,
      required this.productName,
      required this.productDescription,
      required this.productPrice,
      required this.productStock});
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      productId: json["pdt_id"],
      productName: json["pdt_name"],
      productDescription: json["pdt_discription"],
      productPrice: json["pdt_mrp"],
      productStock: json["pdt_stock"]);
  Map<String, dynamic> toJson() => {
    "pdt_id": productId,
        "pdt_name": productName,
        "pdt_discription": productDescription,
        "pdt_mrp": productPrice,
        "pdt_stock": productStock,
      };
}
