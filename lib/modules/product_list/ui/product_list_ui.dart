import 'package:demo_shop/constants/color_constants.dart';
import 'package:demo_shop/modules/login/widgets/custom_text_field.dart';
import 'package:demo_shop/modules/product_list/logic/product_list_bloc.dart';
import 'package:demo_shop/services/routing/routing_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/string_constants.dart';
import '../../../models/product_dm.dart';
import '../../../utility/widgets/cart_icon_widget.dart';
import '../widget/product_widget.dart';

class ProductListUI extends StatefulWidget {
  const ProductListUI({Key? key}) : super(key: key);

  @override
  State<ProductListUI> createState() => _ProductListUIState();
}

class _ProductListUIState extends State<ProductListUI> {
  late final TextEditingController searchController;
  late final ProductListBloc productListBloc;
  late final ScrollController scrollController;

  //product list shown
  List<ProductDm> productList = [];

  //category list shown
  List<String> categoryList = [];

  //the current selected category
  String selectedCategory = '';

  //value of limit send during fetching list
  int limit = 6;

  //flag to show the bottom loader in product list
  bool isFetching = false;

  //flag to check if first loading done
  bool firstLoaded = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    productListBloc = ProductListBloc();
    scrollController = ScrollController()..addListener(_scrollListener);
    productListBloc.add(GetCategoryList());
    productListBloc
        .add(GetProductList(limit: limit, searchString: searchController.text));
  }

  @override
  void dispose() {
    productListBloc.close();
    searchController.dispose();
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextField(
          controller: searchController,
          hintText: searchProduct,
          onChanged: (val) {
            productListBloc.add(SearchProductFromList(searchString: val));
          },
        ),
        centerTitle: false,
        actions: [CartIconWidget()],
      ),
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RefreshIndicator(
          onRefresh: () async {
            //update the limit back to 6 to get refresh list
            limit = 6;
            isFetching = false;
            productListBloc.add(GetProductList(
              limit: limit,
              category: selectedCategory,
              searchString: searchController.text,
              refreshCalled: true,
            ));
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
                    child: BlocConsumer(
                      bloc: productListBloc,
                      listener: (context, state) {},
                      builder: (context, state) {
                        print('State is $state');
                        if (state is CategoryListLoaded) {
                          categoryList = state.categoryList;
                          if (!firstLoaded) {
                            return showLoading();
                          }
                        } else if (state is ProductListLoaded) {
                          productList = state.productList;
                          isFetching = false;
                          firstLoaded = true;
                          if (productList.isEmpty) {
                            return noProductFoundWidget();
                          }
                        } else if (state is ProductListFailed) {
                          isFetching = false;
                          firstLoaded = true;
                          return noProductFoundWidget();
                        } else if (state is ProductListLoading && !isFetching) {
                          return showLoading();
                        }
                        return showProductList(
                            productList: productList,
                            showBottomLoader: isFetching);
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

  Widget noProductFoundWidget() {
    return const Center(
      child: Text(
        noProductFound,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget showProductList(
      {required List<ProductDm> productList, bool showBottomLoader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Flexible(
            child: GridView.builder(
                shrinkWrap: true,
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 290,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ProductWidget(
                    productDm: productList[index],
                    onTap: () {
                      if (FocusScope.of(context).hasPrimaryFocus) {
                        FocusScope.of(context).unfocus();
                      }
                      context.pushNamed(productDetailScreenName,
                          extra: productList[index]);
                    },
                  );
                }),
          ),
          if (showBottomLoader)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              height: 50,
              child: const Center(
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: CircularProgressIndicator(
                    color: primaryColor,
                    strokeWidth: 4,
                  ),
                ),
              ),
            )
        ],
      ),
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
        limit = 6;
        if (!isSelected) {
          selectedCategory = name;
          productListBloc.add(GetProductList(
            limit: limit,
            category: name,
            searchString: searchController.text,
            refreshCalled: true,
          ));
        } else {
          selectedCategory = '';
          productListBloc.add(GetProductList(
              limit: limit,
              searchString: searchController.text,
              refreshCalled: true));
        }
      },
    );
  }

  //method will be called whenever scroll controller listen
  void _scrollListener() {
    //called when scroll controller reach max
    if (scrollController.position.pixels >=
            (scrollController.position.maxScrollExtent - 10) &&
        !isFetching &&
        productListBloc.notReachedMax) {
      isFetching = true;
      limit = limit + 6;
      productListBloc.add(GetProductList(
          limit: limit,
          category: selectedCategory,
          searchString: searchController.text,
          checkReachMax: true));
    }
  }
}
