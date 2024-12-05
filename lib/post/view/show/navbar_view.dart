import 'package:add_card_shop/post/view/show/prodcutSearch.dart';
import 'package:add_card_shop/post/view/show/show_data/view_model/show_Grid_view.dart';
import 'package:flutter/material.dart';
import 'package:add_card_shop/App_route/route_App.dart';
import 'package:get/get.dart';
import '../../../model/postRegister/product/post_response.dart';
import '../../../repository/post/repository_product/model_view/product_all.dart';
import '../../auth/authControllers.dart';

class NavbarView extends StatefulWidget implements PreferredSizeWidget {
  final AuthControllers authControllers = Get.put(AuthControllers());
  final ShowGridView showGridView = Get.find();
  var categoriesList = <PostResponse>[].obs;

  NavbarView({super.key});

  @override
  _NavbarViewState createState() => _NavbarViewState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
//
// class _NavbarViewState extends State<NavbarView> {
//   final TextEditingController searchController = TextEditingController();
//   final viewModel = Get.put(ProductAll());
//   final RxString userRole = ''.obs;
//
//   bool isSearchActive = false;
//
//   @override
//   Widget build(BuildContext context) {
//     // Get the current route
//     String currentRoute = Get.currentRoute;
//
//     return AppBar(
//       backgroundColor: Colors.teal,
//       title: isSearchActive
//           ? TextField(
//         controller: searchController,
//         autofocus: true,
//         style: const TextStyle(color: Colors.white),
//         decoration: const InputDecoration(
//           hintText: "Search...",
//           hintStyle: TextStyle(color: Colors.white60),
//           border: InputBorder.none,
//         ),
//         onChanged: (query) {
//           // Implement dynamic search filtering if needed
//         },
//       )
//           : Text(currentRoute == Route_App.showpost
//           ? "Product Grid"
//           : currentRoute == Route_App.productView
//           ? "Product List"
//           : "Other Page"),
//       centerTitle: true,
//       leading: isSearchActive
//           ? IconButton(
//         icon: const Icon(Icons.close, color: Colors.white),
//         onPressed: () {
//           setState(() {
//             isSearchActive = false;
//             searchController.clear();
//           });
//         },
//       )
//           : null,
//       actions: [
//         if (currentRoute == Route_App.showpost && !isSearchActive)
//           IconButton(
//             icon: const Icon(Icons.search, size: 30),
//             onPressed: () {
//               // Access the data to pass as `postResponse`
//               final categories = widget.showGridView.categoriesList.toList();
//
//               showSearch(
//                 context: context,
//                 delegate: ProductSearch(postResponse: categories),
//               );
//             },
//           ),
//         //if (currentRoute != Route_App.showpost && !isSearchActive)
//           if (currentRoute != Route_App.showpost && !isSearchActive && userRole.value == "ROLE_ADMIN")
//           IconButton(
//             icon: const Icon(Icons.add, size: 30),
//             onPressed: () {
//               Get.toNamed(Route_App.createView);
//             },
//           ),
//       ],
//     );
//   }
// }
class _NavbarViewState extends State<NavbarView> {
  final TextEditingController searchController = TextEditingController();
  final viewModel = Get.put(ProductAll());
  bool isSearchActive = false;

  @override
  Widget build(BuildContext context) {
    // Get the current route
    String currentRoute = Get.currentRoute;

    return AppBar(
      backgroundColor: Colors.teal,
      title: isSearchActive
          ? TextField(
        controller: searchController,
        autofocus: true,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.white60),
          border: InputBorder.none,
        ),
        onChanged: (query) {
          // Implement dynamic search filtering if needed
        },
      )
          : Text(
          currentRoute == Route_App.showpost
              ? "Product Grid"
              : currentRoute == Route_App.productView
              ? "Product List"
              : "Other Page"),
      centerTitle: true,
      leading: isSearchActive
          ? IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: () {
          setState(() {
            isSearchActive = false;
            searchController.clear();
          });
        },
      )
          : null,
      actions: [
        // Show Search IconButton for `showpost` route when search is not active
        if (currentRoute == Route_App.showpost && !isSearchActive)
          IconButton(
            icon: const Icon(Icons.search, size: 30),
            onPressed: () {
              final categories = widget.showGridView.categoriesList.toList();
              showSearch(
                context: context,
                delegate: ProductSearch(postResponse: categories),
              );
            },
          ),
        // Show "Add UI" (IconButton) only if the userRole is NOT "ROLE_USER" and search is not active
        if (viewModel.userRole.value != "ROLE_USER" && !isSearchActive)
          IconButton(
            icon: const Icon(Icons.add, size: 30),
            onPressed: () {
              Get.toNamed(Route_App.createView);
            },
          ),
      ],
    );
  }
}

