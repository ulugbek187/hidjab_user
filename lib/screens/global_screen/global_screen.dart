import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidjab_user/bloc/category/category_bloc.dart';
import 'package:hidjab_user/bloc/category/category_state.dart';
import 'package:hidjab_user/bloc/product/product_event.dart';
import 'package:hidjab_user/bloc/product/product_state.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/screens/detail_screen/detail_screen.dart';
import 'package:hidjab_user/screens/global_screen/widgets/category_button.dart';
import 'package:hidjab_user/screens/global_screen/widgets/my_drawer.dart';
import 'package:hidjab_user/screens/global_screen/widgets/my_text_field.dart';
import 'package:hidjab_user/screens/routes.dart';
import 'package:hidjab_user/utils/colors/app_colors.dart';
import 'package:hidjab_user/utils/icons/app_icons.dart';
import 'package:hidjab_user/utils/image/appimage.dart';
import 'package:hidjab_user/utils/styles/app_text_style.dart';
import 'package:hidjab_user/utils/styles/size.dart';
import '../../bloc/product/product_bloc.dart';
import 'widgets/birinichi_turdagi_tovarlar_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<ProductBloc>().add(
            GetProductsEvent(),
          ),
    );
    super.initState();
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c_F7FAFC,
        title: Row(
          children: [
            Image.asset(AppImages.brandIcon, width: 34.w, height: 34.h),
            Image.asset(AppImages.brand, width: 55.w, height: 16.h),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.basketScreen);
            },
            icon: SvgPicture.asset(AppIcons.carts),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppIcons.profile),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      backgroundColor: AppColors.c_F7FAFC,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                child: MyTextField(
                  controller: textEditingController,
                  type: TextInputType.text,
                  iconPath: AppIcons.search,
                  hinText: "Search",
                  onChanged: (v) async {
                    _searchProduct();
                    await Future.delayed(const Duration(seconds: 5));
                    if (!context.mounted) return;
                    context.read<ProductBloc>().add(
                          GetProductsEvent(),
                        );
                  },
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        if (state.formStatus == FormStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state.formStatus == FormStatus.error) {
                          return Center(
                            child: Text(state.error),
                          );
                        }
                        if (state.formStatus == FormStatus.success) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CategoryButton(
                                    title: "All",
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.categoryScreen,
                                        arguments: ["All"],
                                      );
                                    }),
                                ...List.generate(
                                  state.categories.length,
                                  (index) => CategoryButton(
                                    title: state.categories[index].categoryName,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteNames.categoryScreen,
                                          arguments: [
                                            state.categories[index].docId,
                                            state.categories[index].categoryName
                                          ]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: 5.h),
                    Stack(
                      children: [
                        Image.asset(AppImages.reklama),
                        Positioned(
                          top: 23.h,
                          left: 20.w,
                          child: Text(
                            "Latest trending",
                            style: AppTextStyle.width500.copyWith(
                              fontSize: 18.w,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 60.h,
                          left: 20.w,
                          child: Text(
                            "Electronic items",
                            style: AppTextStyle.width500.copyWith(
                              fontSize: 18.w,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 120.h,
                          left: 20.w,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.categoryScreen);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "Learn more",
                                  style: AppTextStyle.width600.copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Deals and offers",
                                style: AppTextStyle.width600.copyWith(
                                  fontSize: 18.w,
                                ),
                              ),
                              Text(
                                "Deals and offers",
                                style: AppTextStyle.width400
                                    .copyWith(fontSize: 14.w),
                              ),
                            ],
                          ),
                          SizedBox(
                              width: 140.w,
                              height: 44.h,
                              child: Image.asset(AppImages.hour)),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            state.products.length,
                            (index) => FourMethodTovarITem(
                              image: state.products[index].imageUrl,
                              firstTitle: state.products[index].productName,
                              secondTitle:
                                  state.products[index].price.toString(),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                      productModel: state.products[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        return Column(
                          children: List.generate(
                            state.categories.length,
                            (index) => Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 18.h),
                                    child: Text(
                                      state.categories[index].categoryName,
                                      style: AppTextStyle.width600
                                          .copyWith(fontSize: 18.w),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 10.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Source now",
                                          style: AppTextStyle.width500.copyWith(
                                            color: Colors.blue,
                                            fontSize: 16.w,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                              context,
                                              RouteNames.categoryScreen,
                                              arguments: 'All',
                                            );
                                          },
                                          icon: SvgPicture.asset(
                                            AppIcons.arrowNext,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 1.h,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Stack(
                      children: [
                        Image.asset(AppImages.obmanka2),
                        Image.asset(AppImages.obmankaBack),
                        Positioned(
                          top: 24.h,
                          left: 20.w,
                          child: Text(
                            "An easy way to send \nrequests to all suppliers",
                            style: AppTextStyle.width600.copyWith(
                              color: Colors.white,
                              fontSize: 18.w,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 110.h,
                          left: 20.w,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.w),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Send inquiry",
                              style: AppTextStyle.width500.copyWith(
                                  color: Colors.white, fontSize: 13.w),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text(
                        "Recommended items",
                        style: AppTextStyle.width600.copyWith(fontSize: 18.w),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      color: Colors.white,
                      child: SizedBox(
                        height: height / 1.4,
                        child: GridView.count(
                          // primary: false,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 20.h,
                          ),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: 0.68,
                          children: [
                            ...List.generate(
                              state.products.length,
                              (index) => TwoMethodTovarITem(
                                image: state.products[index].imageUrl,
                                firstTitle: state.products[index].productName,
                                secondTitle:
                                    "${state.products[index].price} Ram/Rom",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsScreen(
                                        productModel: state.products[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
