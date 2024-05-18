import 'package:flutter/material.dart';
import 'package:hidjab_user/screens/routes.dart';
import 'package:hidjab_user/utils/styles/size.dart';
import 'package:lottie/lottie.dart';

import '../../utils/image/appimage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() {
    Future.delayed(
      const Duration(
        seconds: 1,
      ),
      () {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.homeScreen,
        );
      },
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Center(
        child: Lottie.asset(
          AppImages.eComerse,
        ),
      ),
    );
  }
}
