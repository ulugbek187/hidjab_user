import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidjab_user/bloc/category/category_bloc.dart';
import 'package:hidjab_user/bloc/category/category_event.dart';
import 'package:hidjab_user/bloc/nabi/nabi_bloc.dart';
import 'package:hidjab_user/bloc/nabi/nabi_event.dart';
import 'package:hidjab_user/data/repo/storage_repository.dart';
import 'package:hidjab_user/screens/routes.dart';
import 'package:hidjab_user/utils/styles/size.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../data/form_status/form_status.dart';
import '../../utils/image/appimage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init(bool auth) async {
    Future.microtask(() {
      context.read<CategoryBloc>().add(
            GetCategories(),
          );
      context.read<NabiBloc>().add(
            GetCategoryEvent(
              categories: context.read<CategoryBloc>().state.categories,
            ),
          );
      context.read<NabiBloc>().add(
            const GetCategoryProductsEvent(),
          );
    });
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    if (!auth) {
      bool isNewUser = StorageRepository.getBool(key: "is_new_user");
      if (isNewUser) {
        Navigator.pushReplacementNamed(context, RouteNames.login);
      } else {
        // Navigator.pushReplacementNamed(context, RouteNames.onBoarding);
      }
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
    }
  }

  // @override
  // void initState() {
  //   _init();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.status == FormsStatus.authenticated) {
                  _init(true);
                } else {
                  _init(false);
                }
              },
              child: const SizedBox.square(),
            ),
            Lottie.asset(
              AppImages.eComerse,
            ),
          ],
        ),
      ),
    );
  }
}
