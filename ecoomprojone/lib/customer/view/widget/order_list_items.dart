import 'package:flutter/material.dart';
import '../../../Core/fonts/font_styles.dart';

class OrderListItems extends StatelessWidget {
  OrderListItems({
    super.key,
    required this.productName,
    required this.productQty,
    required this.productPrice,
    required this.productTotal,
  });
  final String productName;
  final int? productQty;
  final double productPrice;
  final double? productTotal;
  final font = FontStyles();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network(
                      fit: BoxFit.cover,
                      "https://cdn.shopify.com/s/files/1/1403/8979/products/VintageCreamColorHighlighters-2_grande.png?v=1631344232"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  productName,
                  style: font.tittle3,
                ),
              ),
              Text("Rs:${productPrice.toString()}"),
              productQty == null
                  ? const SizedBox()
                  : Row(
                      children: [
                        const Text("Qty : "),
                        Text(
                          productQty.toString(),
                          style: font.tittle3,
                        ),
                      ],
                    ),
              productTotal == null
                  ? const SizedBox()
                  : Text(
                      productTotal.toString(),
                      style: font.tittle3,
                    )
            ],
          ),
          //   const Divider(),
        ],
      ),
    );
  }
}
