import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidjab_user/bloc/category/category_bloc.dart';
import 'package:hidjab_user/bloc/category/category_state.dart';
import 'package:hidjab_user/bloc/nabi/nabi_bloc.dart';
import 'package:hidjab_user/bloc/nabi/nabi_event.dart';
import 'package:hidjab_user/bloc/nabi/nabi_state.dart';
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
  void _init() {
    Future.microtask(() {
      List<String> c = [];
      for (int i = 0;
          i < context.read<CategoryBloc>().state.categories.length;
          i++) {
        c.add(
          context.read<CategoryBloc>().state.categories[i].docId,
        );
      }

      context.read<NabiBloc>().add(
            GetCategoryProductsEvent(
              categories: c,
            ),
          );
    });
  }

  @override
  void initState() {
    _init();
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
                padding: EdgeInsets.only(left: 14.w, bottom: 5.h, top: 5.h),
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
                                  state.listenableCategories.length,
                                  (index) => CategoryButton(
                                    title: state.listenableCategories[index]
                                        .categoryName,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteNames.categoryScreen,
                                          arguments: [
                                            state.listenableCategories[index]
                                                .docId,
                                            state.listenableCategories[index]
                                                .categoryName
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
                    SizedBox(height: 10.h),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.w, bottom: 10.h, top: 10.h),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "All Products",
                                style: AppTextStyle.width600.copyWith(
                                  fontSize: 18.w,
                                ),
                              ),
                              Text(
                                "Your favorite products",
                                style: AppTextStyle.width400
                                    .copyWith(fontSize: 14.w),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Image.asset(
                            AppImages.recomended,
                            width: 200.w,
                            height: 70.h,
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(
                            state.products.length,
                            (index) => OneMethodTovarITem(
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
                            (i) => Container(
                              width: width,
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
                                      state.categories[i].categoryName,
                                      style: AppTextStyle.width600
                                          .copyWith(fontSize: 18.w),
                                    ),
                                  ),
                                  BlocBuilder<NabiBloc, NabiState>(
                                      builder: (context, state) {
                                    if (state.formStatus ==
                                        FormStatus.success) {
                                      return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.products.length,
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                              height: 50.h,
                                              child: Text(
                                                state.products[i][index]
                                                    .productName,
                                              ),
                                            );
                                          });
                                    }
                                    if (state.formStatus == FormStatus.error) {
                                      return Text(state.errorText);
                                    }
                                    if (state.formStatus ==
                                        FormStatus.loading) {
                                      return const CircularProgressIndicator();
                                    }
                                    return const SizedBox.shrink();
                                  }),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                      vertical: 10.h,
                                    ),
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
                            "Our products are stored in a warehouse,\n in a safe place, in Limonary\n Bunyodkor Street",
                            style: AppTextStyle.width600.copyWith(
                              color: Colors.white,
                              fontSize: 16.w,
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
                              "Learn more",
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
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          ...List.generate(
                            state.products.length,
                            (index) => TwoMethodTovarITem(
                              image: state.products[index].imageUrl,
                              firstTitle: state.products[index].productName,
                              secondTitle: "${state.products[index].price} Сум",
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
