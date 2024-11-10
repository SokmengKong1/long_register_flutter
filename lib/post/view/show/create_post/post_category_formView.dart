import 'package:add_card_shop/post/view/show/create_post/view_model/post_category_form_viewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../repository/post/widget/custom_button_widget.dart';
import '../../../../repository/post/widget/custom_input_widget.dart';
class PostCategoryFormView extends StatefulWidget {
  PostCategoryFormView({super.key});

  @override
  State<PostCategoryFormView> createState() => _PostCategoryFormViewState();
}

class _PostCategoryFormViewState extends State<PostCategoryFormView> {
  var viewModel = Get.put(PostCategoryFormViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text( "Create",
          // "${viewModel.categoryRequest.value.id == 0 ? "Create" : "Update"} Category"
          //     .tr,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(child: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputWidget(
              controller: viewModel.CategoryNameController.value,
              labelText: "Category Name",
              hintText: "Category Name",
            ),
            CustomButtonWidget(
              onLoading: viewModel.onCreateLoading.value,
              onTap: () => {viewModel.onCreateCategory()},
              title: "Create"
              // viewModel.categoryRequest.value.id == 0 ? "Create" : "Update",

            )
          ],
        );
      })),
    );
  }
}
