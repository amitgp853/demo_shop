import 'package:demo_shop/constants/color_constants.dart';
import 'package:demo_shop/modules/login/widgets/custom_text_field.dart';
import 'package:demo_shop/modules/product_list/logic/product_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../models/product_dm.dart';
import '../widget/product_widget.dart';

class ProductListUI extends StatefulWidget {
  const ProductListUI({Key? key}) : super(key: key);

  @override
  State<ProductListUI> createState() => _ProductListUIState();
}

class _ProductListUIState extends State<ProductListUI> {
  late final TextEditingController searchController;
  late final ProductListBloc productListBloc;
  List<ProductDm> productList = [];
  List<String> categoryList = [];
  String selectedCategory = '';
  int limit = 6;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    productListBloc = ProductListBloc();
    productListBloc.add(GetCategoryList());
    productListBloc
        .add(GetProductList(limit: limit, searchString: searchController.text));
  }

  @override
  void dispose() {
    productListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextField(
          controller: searchController,
          hintText: 'Search',
          onChanged: (val) {
            productListBloc.add(SearchProductFromList(searchString: val));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_checkout_outlined,
                color: Colors.white),
            onPressed: () {
              context.pushNamed('cart_list');
            },
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RefreshIndicator(
          onRefresh: () async {
            productListBloc.add(GetProductList(
                limit: limit,
                category: selectedCategory,
                searchString: searchController.text));
          },
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).backgroundColor,
          child: Stack(
            children: [
              //List view added so that refresh indicator can work
              ListView(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  categoryListRow(),
                  Expanded(
                    child: BlocBuilder(
                      bloc: productListBloc,
                      builder: (context, state) {
                        if (state is ProductListLoading) {
                          return showLoading();
                        } else if (state is CategoryListLoaded) {
                          categoryList = state.categoryList;
                        } else if (state is ProductListLoaded) {
                          productList = state.productList;
                        } else if (state is ProductListFailed ||
                            productList.isEmpty) {
                          return noProductFound();
                        }
                        return showProductList(productList: productList);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget noProductFound() {
    return const Center(
      child: Text(
        'No Product Found',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget showProductList({required List<ProductDm> productList}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisExtent: 300,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return ProductWidget(
              productDm: productList[index],
              onTap: () {
                context.pushNamed('product', extra: productList[index]);
              },
            );
          }),
    );
  }

  Widget categoryListRow() {
    return BlocBuilder(
      bloc: productListBloc,
      builder: (context, state) {
        if (state is CategoryListLoaded) {
          categoryList = state.categoryList;
        }
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 12.0,
              children: categoryList.map((name) {
                return filterChip(
                    name: name, isSelected: selectedCategory == name);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget filterChip({required String name, bool isSelected = false}) {
    return FilterChip(
      label: Text(
        name,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
      selectedColor: primaryColor,
      selected: isSelected,
      onSelected: (bool value) {
        if (!isSelected) {
          selectedCategory = name;
          productListBloc.add(GetProductList(
              limit: limit,
              category: name,
              searchString: searchController.text));
        } else {
          selectedCategory = '';
          productListBloc.add(GetProductList(
              limit: limit, searchString: searchController.text));
        }
      },
    );
  }
}
