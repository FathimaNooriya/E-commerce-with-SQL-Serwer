import 'package:flutter/material.dart';

import '../../../Core/fonts/font_styles.dart';

class CartTableHeading extends StatelessWidget {
  const CartTableHeading({
    super.key,
    required this.font,
  });

  final FontStyles font;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Products", style: font.tittle3),
          Text("Total", style: font.tittle3)
        ],
      ),
    );
  }
}