class CustomerModel {
  int? custId;
  String custName;
  String? custAdress;
  String custPhoneNo;
  CustomerModel(
      {this.custId,
      required this.custName,
      required this.custAdress,
      required this.custPhoneNo});
  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
      custId: json["cust_id"],
      custName: json["cust_name"],
      custAdress: json["cust_adress"],
      custPhoneNo: json["cust_phone_no"]);
  factory CustomerModel.fromJsonModel(Map<String, dynamic> json) =>
      CustomerModel(
          custId: json["cust_id"],
          custName: json["cust_name"],
          custAdress: json["cust_adress"],
          custPhoneNo: json["cust_phone_no"]);
  Map<String, dynamic> toJson() => {
        "cust_name": custName,
        "cust_adress": custAdress,
        "cust_phone_no": custPhoneNo,
        "cust_id": custId
      };
}
