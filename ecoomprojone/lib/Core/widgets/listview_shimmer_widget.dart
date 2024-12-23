import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ListViewShimmerWidget extends StatelessWidget {
  const ListViewShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return const SizedBox(
              height: 70,
              width: 150,
            );
          }),
    );
  }
}
