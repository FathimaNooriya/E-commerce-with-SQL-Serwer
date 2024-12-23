// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../customer/view/widget/order_list_items.dart';
// import '../../controller/product_controller.dart';
// import '../../model/product_model.dart';
// import '../product_screen.dart';

// class SearchDeligateWidget extends SearchDelegate {
//   final ProductController controller = Get.put(ProductController());
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//
//     // throw UnimplementedError();
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return FutureBuilder<List<ProductModel>>(
//       future: controller.searchProduct(value: query), // Call the async function
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Show a loading indicator while the data is being fetched
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           // Handle errors during data fetching
//           return Center(
//             child: Text(
//               'Error: ${snapshot.error}',
//               style: const TextStyle(fontSize: 16, color: Colors.red),
//             ),
//           );
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           // If no data is returned
//           return Center(
//             child: Text(
//               'No results found for "$query"',
//               style: const TextStyle(fontSize: 16),
//             ),
//           );
//         } else {
//           // Show the list of search results
//           final productList = snapshot.data!;
//           return ListView.builder(
//             itemCount: productList.length,
//             itemBuilder: (context, index) {
//               final data = productList[index];
//               return OrderListItems(
//                 productName: data.productName,
//                 productPrice: data.productPrice,
//                 productQty: null,
//                 productTotal: null,
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return ProductsGrid();

//   }
// }

import 'package:flutter/material.dart';

import '../../controller/product_controller.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.controller,
  });

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 75),
      child: SizedBox(
        width: 200,
        child: TextFormField(
          controller: controller.searchController,
          onChanged: (value) {
            controller.searchProducts(value: value);
          },
          onFieldSubmitted: (value) {
            controller.searchProducts(value: value);
          },
          decoration: InputDecoration(
            suffixIcon: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.search),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
