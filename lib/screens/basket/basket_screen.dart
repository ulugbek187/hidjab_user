import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidjab_user/bloc/basket/basket_bloc.dart';
import 'package:hidjab_user/bloc/basket/basket_event.dart';
import 'package:hidjab_user/bloc/basket/basket_state.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/data/models/basket_model.dart';
import 'package:hidjab_user/screens/basket/widgets/check.dart';
import 'package:hidjab_user/screens/basket/widgets/shop_items.dart';
import 'package:hidjab_user/utils/colors/app_colors.dart';
import 'package:hidjab_user/utils/functions/utility_functions.dart';
import 'package:hidjab_user/utils/icons/app_icons.dart';
import 'package:hidjab_user/utils/image/appimage.dart';
import 'package:hidjab_user/utils/styles/app_text_style.dart';
import 'package:hidjab_user/utils/styles/size.dart';
import 'package:lottie/lottie.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<BasketBloc>().add(
            ListenBasketEvent(
              userId: FirebaseAuth.instance.currentUser!.uid,
            ),
          ),
    );
    super.initState();
  }

  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(AppIcons.arrowBack),
        ),
        title: Text(
          "Shopping cart",
          style: AppTextStyle.width500.copyWith(
            color: Colors.black,
            fontSize: 18.w,
          ),
        ),
        elevation: 1,
      ),
      body: BlocBuilder<BasketBloc, BasketState>(
        builder: (context, state) {
          List<int> countOfProductsList = [];
          if (state.baskets.isNotEmpty) {
            for (var element in state.baskets) {
              countOfProductsList.add(element.countOfProducts);
            }
          } else {}
          if (state.baskets.isEmpty) {
            return Center(
              child: Lottie.asset(AppImages.basket),
            );
          }
          if (state.formStatus == FormsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.formStatus == FormsStatus.success) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 5,
                          width: width,
                          color: AppColors.cDEE2E7,
                        ),
                        ...List.generate(
                          state.baskets.length,
                          (index) => ShopContainer(
                            imageUrl: state.baskets[index].imageUrl,
                            productName: state.baskets[index].productName,
                            description: state.baskets[index].description,
                            price: state.baskets[index].allPrice,
                            count: countOfProductsList[index],
                            plusOnTap: () {
                              countOfProductsList[index]++;
                              BasketModel basketModel =
                                  state.baskets[index].copyWith(
                                countOfProducts: countOfProductsList[index],
                                allPrice: countOfProductsList[index] *
                                    state.baskets[index].price,
                              );
                              context.read<BasketBloc>().add(
                                    UpdateBasketEvent(
                                      basketModel: basketModel,
                                    ),
                                  );
                            },
                            minusOnTap: () {
                              countOfProductsList[index]--;
                              if (countOfProductsList[index] == 0) {
                                isDeleting = true;
                              }
                              if (isDeleting) {
                                context.read<BasketBloc>().add(
                                      DeleteBasketEvent(
                                        uuid: state.baskets[index].uuid,
                                      ),
                                    );
                                isDeleting = false;
                              }
                              BasketModel basketModel =
                                  state.baskets[index].copyWith(
                                countOfProducts: countOfProductsList[index],
                                allPrice: countOfProductsList[index] *
                                    state.baskets[index].price,
                              );
                              context.read<BasketBloc>().add(
                                    UpdateBasketEvent(
                                      basketModel: basketModel,
                                    ),
                                  );
                            },
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text(
                                    'Warning!!!',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20.w,
                                    ),
                                  ),
                                  content: SizedBox(
                                    height: 50.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ushbu Mahsulotni aniq ochirib tawlamoqchimisiz?",
                                          style: AppTextStyle.width600,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 14.w,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<BasketBloc>().add(
                                              DeleteBasketEvent(
                                                uuid: state.baskets[index].uuid,
                                              ),
                                            );
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                          fontSize: 14.w,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      color: AppColors.white,
                      child: Column(
                        children: [
                          ...List.generate(
                            state.baskets.length,
                            (index) => CheckoutItem(
                              countOfProducts:
                                  state.baskets[index].countOfProducts,
                              allSumma: state.baskets[index].allPrice,
                              productName: state.baskets[index].productName,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Text(
                                "Total:",
                                style: TextStyle(
                                  fontSize: 18.w,
                                  color: AppColors.c1C1C1C,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${calculateAllPrice(state.baskets)} Сум',
                                style: TextStyle(
                                  fontSize: 18.w,
                                  color: AppColors.c1C1C1C,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.w),
                                color: AppColors.c00B517,
                              ),
                              child: Center(
                                child: Text(
                                  "Buy ${state.baskets.length} product",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.w,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
