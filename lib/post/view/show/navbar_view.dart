// import 'package:flutter/material.dart';
// import 'package:add_card_shop/App_route/route_App.dart';
// import 'package:get/get.dart';
// import '../../auth/authControllers.dart';
//
// class NavbarView extends StatefulWidget implements PreferredSizeWidget {
//   final AuthControllers authControllers = Get.put(AuthControllers());
//
//   NavbarView({super.key});
//
//   @override
//   _NavbarViewState createState() => _NavbarViewState();
//
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }
//
// class _NavbarViewState extends State<NavbarView> {
//   final TextEditingController searchController = TextEditingController();
//   bool isSearchActive = false; // Track if search mode is active
//
//   @override
//   Widget build(BuildContext context) {
//     // Check current route
//     bool isOnProductList = Get.currentRoute == Route_App.productView;
//
//     return AppBar(
//       backgroundColor: Colors.indigo,
//       title: isSearchActive
//           ? TextField(
//         controller: searchController,
//         autofocus: true,
//         style: TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           hintText: "Search...",
//           hintStyle: TextStyle(color: Colors.white60),
//           border: InputBorder.none,
//         ),
//         onChanged: (query) {
//           // Add your search logic here
//           print("Searching for: $query");
//         },
//       )
//           : Text(isOnProductList ? "Product List" : "Other Page"), // Title changes based on route
//       centerTitle: true,
//       leading: isSearchActive
//           ? IconButton(
//         icon: Icon(Icons.close, color: Colors.white),
//         onPressed: () {
//           // Exit search mode
//           setState(() {
//             isSearchActive = false;
//             searchController.clear();
//           });
//         },
//       )
//           : null,
//       actions: [
//         // Add icon (only for Product List)
//         if (isOnProductList && !isSearchActive)
//           IconButton(
//             icon: Icon(Icons.add, size: 30),
//             onPressed: () {
//               Get.toNamed(Route_App.createView);
//             },
//           ),
//         // Search icon (only for other pages, NOT Product List)
//         if (!isOnProductList && !isSearchActive)
//           IconButton(
//             icon: Icon(Icons.search, size: 30),
//             onPressed: () {
//               setState(() {
//                 isSearchActive = true; // Activate search mode
//               });
//             },
//           ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:add_card_shop/App_route/route_App.dart';
import 'package:get/get.dart';
import '../../auth/authControllers.dart';

class NavbarView extends StatefulWidget implements PreferredSizeWidget {
  final AuthControllers authControllers = Get.put(AuthControllers());

  NavbarView({super.key});

  @override
  _NavbarViewState createState() => _NavbarViewState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _NavbarViewState extends State<NavbarView> {
  final TextEditingController searchController = TextEditingController();
  bool isSearchActive = false; // Track if search mode is active

  // Original data for the screen
  final List<Map<String, dynamic>> screenData = [
    {"title": "Post 1", "description": "A beautiful post about travel."},
    {"title": "Post 2", "description": "Another interesting post."},
    {"title": "Real Estate", "description": "Real estate information."},
    {"title": "Digital Media", "description": "Media and design ideas."},
    {"title": "Cat Post", "description": "Posts about cute cats."},
    {"title": "BBU Event", "description": "Events in BBU University."},
  ];

  String searchQuery = ""; // Store the search query

  @override
  Widget build(BuildContext context) {
    // Check current route
    bool isOnProductList = Get.currentRoute == Route_App.productView;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: isSearchActive
            ? TextField(
          controller: searchController,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search...",
            hintStyle: TextStyle(color: Colors.white60),
            border: InputBorder.none,
          ),
          onChanged: (query) {
            // Update the search query dynamically
            setState(() {
              searchQuery = query;
            });
          },
        )
            : Text(isOnProductList ? "Product List" : "Other Page"),
        centerTitle: true,
        leading: isSearchActive
            ? IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            // Exit search mode
            setState(() {
              isSearchActive = false;
              searchQuery = ""; // Clear the query
              searchController.clear(); // Clear text field
            });
          },
        )
            : null,
        actions: [
          // Add icon (only for Product List)
          if (isOnProductList && !isSearchActive)
            IconButton(
              icon: Icon(Icons.add, size: 30),
              onPressed: () {
                // Get.toNamed(Route_App.createView);
                Get.toNamed(Route_App.postManageCreateCategoryPath);
              },
            ),
          // Search icon (only for other pages, NOT Product List)
          if (!isOnProductList && !isSearchActive)
            IconButton(
              icon: Icon(Icons.search, size: 30),
              onPressed: () {
                setState(() {
                  isSearchActive = true; // Activate search mode
                });
              },
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: screenData.length,
        itemBuilder: (context, index) {
          final item = screenData[index];

          // Filter items based on search query
          if (searchQuery.isNotEmpty &&
              !item['title']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) &&
              !item['description']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase())) {
            return Container(); // Hide items that do not match
          }

          // Visible items
          return Card(
            child: ListTile(
              title: Text(item['title']),
              subtitle: Text(item['description']),
            ),
          );
        },
      ),
    );
  }
}
