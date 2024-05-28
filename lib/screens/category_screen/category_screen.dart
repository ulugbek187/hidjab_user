import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidjab_user/bloc/product/product_bloc.dart';
import 'package:hidjab_user/bloc/product/product_state.dart';
import 'package:hidjab_user/screens/category_screen/widgets/grid_view_items.dart';
import 'package:hidjab_user/screens/category_screen/widgets/sort_items.dart';
import 'package:hidjab_user/screens/global_screen/widgets/category_button.dart';
import 'package:hidjab_user/screens/routes.dart';
import 'package:hidjab_user/utils/icons/app_icons.dart';
import '../../bloc/product/product_event.dart';
import '../../utils/styles/app_text_style.dart';
import '../../utils/styles/size.dart';
import '../detail_screen/detail_screen.dart';
import '../global_screen/widgets/my_text_field.dart';
import 'widgets/category_list_items.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.category});

  final List<String> category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isGridView = true;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.category[0] == "All"
        ? context.read<ProductBloc>().add(
              GetProductsEvent(),
            )
        : context.read<ProductBloc>().add(
              GetProductsByCategoryId(
                categoryDocId: widget.category[0],
              ),
            );

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category[0] == "All"
            ? "ALL CATEGORIES"
            : widget.category[1].toUpperCase()),
        actions: [
          SvgPicture.asset(AppIcons.carts),
          SizedBox(
            width: 20.w,
          ),
          SvgPicture.asset(AppIcons.profile),
          SizedBox(
            width: 20.w,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextField(
                    type: TextInputType.text,
                    iconPath: AppIcons.search,
                    hinText: "Search",
                    onChanged: (value) async {
                      _searchProduct();
                      await Future.delayed(const Duration(seconds: 5));
                      if (!context.mounted) return;
                      context.read<ProductBloc>().add(
                            GetProductsEvent(),
                          );
                    },
                    controller: textEditingController,
                  ),
                  SizedBox(height: 10.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryButton(
                          title: 'Tablets',
                          onTap: () {},
                        ),
                        SizedBox(width: 10.w),
                        CategoryButton(title: "Phones", onTap: () {}),
                        SizedBox(width: 10.w),
                        CategoryButton(title: "iPod", onTap: () {}),
                        SizedBox(width: 10.w),
                        CategoryButton(title: "iPads", onTap: () {}),
                        SizedBox(width: 10.w),
                        CategoryButton(title: "Laptops", onTap: () {}),
                        SizedBox(width: 10.w),
                        CategoryButton(title: "T-shirts", onTap: () {}),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SortItems(
                    onGridViewPressed: () {
                      setState(() {
                        isGridView = true;
                      });
                    },
                    onListViewPressed: () {
                      setState(() {
                        isGridView = false;
                      });
                    },
                  ),
                  SizedBox(height: 10.h),
                  isGridView
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio:
                                0.6, // Adjust aspect ratio as needed
                          ),
                          itemCount: widget.category[0] == 'All'
                              ? state.products.length
                              : state.categoryProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GridViewContainer(
                              image: widget.category[0] == 'All'
                                  ? state.products[index].imageUrl
                                  : state.categoryProducts[index].imageUrl,
                              price: widget.category[0] == 'All'
                                  ? state.products[index].price.toString()
                                  : state.categoryProducts[index].price
                                      .toString(),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                      productModel: widget.category[0] == 'All'
                                          ? state.products[index]
                                          : state.categoryProducts[index],
                                    ),
                                  ),
                                );
                              },
                              rate: widget.category[0] == 'All'
                                  ? state.products[index].rate.toString()
                                  : state.categoryProducts[index].rate
                                      .toString(),
                              // order: widget.category == 'All'
                              //     ? state.products[index].countOfOrders
                              //         .toString()
                              //     : ctPr[index].countOfOrders.toString(),
                              productName: widget.category[0] == 'All'
                                  ? state.products[index].productName
                                  : state.categoryProducts[index].productName,
                              order: '',
                            );
                          },
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.category[0] == 'All'
                              ? state.products.length
                              : state.categoryProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListViewContainer(
                              image: widget.category[0] == 'All'
                                  ? state.products[index].imageUrl
                                  : state.categoryProducts[index].imageUrl,
                              price: widget.category[0] == 'All'
                                  ? state.products[index].price.toString()
                                  : state.categoryProducts[index].price
                                      .toString(),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                      productModel: widget.category[0] == 'All'
                                          ? state.products[index]
                                          : state.categoryProducts[index],
                                    ),
                                  ),
                                );
                              },
                              productName: widget.category[0] == 'All'
                                  ? state.products[index].productName
                                  : state.categoryProducts[index].productName,
                              rate: widget.category[0] == 'All'
                                  ? state.products[index].rate.toString()
                                  : state.categoryProducts[index].rate
                                      .toString(),
                              order: '',
                              // order: widget.category == 'All'
                              //     ? state.products[index].countOfOrders
                              //         .toString()
                              //     : ctPr[index].countOfOrders.toString(),
                            );
                          },
                        ),
                  SizedBox(height: 10.h),
                  Text(
                    "You may also Like",
                    style: AppTextStyle.width500
                        .copyWith(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 10.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                          state.products.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridViewContainer(
                              image: state.products[index].imageUrl,
                              price: state.products[index].price.toString(),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.productDetailScreen,
                                  arguments: state.products[index],
                                );
                              },
                              rate: state.products[index].rate.toString(),
                              productName: state.products[index].productName,
                              order: '',
                              // order: state.products[index].countOfOrders
                              //     .toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _searchProduct() {
    context.read<ProductBloc>().add(
          SearchProductEvent(
            input: textEditingController.text,
          ),
        );
  }

  @override
  void deactivate() {
    textEditingController.dispose();
    super.deactivate();
  }
}
