import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidjab_user/bloc/category/category_bloc.dart';
import 'package:hidjab_user/bloc/category/category_event.dart';
import 'package:hidjab_user/bloc/nabi/nabi_bloc.dart';
import 'package:hidjab_user/bloc/product/product_bloc.dart';
import 'package:hidjab_user/data/repo/basket_repo.dart';
import 'package:hidjab_user/data/repo/category_repo.dart';
import 'package:hidjab_user/data/repo/product_repo.dart';
import 'package:hidjab_user/screens/routes.dart';
import 'package:hidjab_user/servises/local_notifty_servises.dart';
import 'package:hidjab_user/utils/colors/app_colors.dart';
import '../bloc/basket/basket_bloc.dart';

class App extends StatelessWidget {
  App({
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(
    BuildContext context,
  ) {
    LocalNotificationService.localNotificationService.init(
      navigatorKey,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => ProductRepo(),
        ),
        RepositoryProvider(
          create: (_) => CategoryRepo(),
        ),
        RepositoryProvider(
          create: (_) => BasketRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductBloc(
              context.read<ProductRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => NabiBloc(
              context.read<ProductRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => BasketBloc(
              context.read<BasketRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => CategoryBloc(
              context.read<CategoryRepo>(),
            )..add(
                ListenAllCategoriesEvent(),
              ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 812),
          builder: (context, child) {
            ScreenUtil.init(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(useMaterial3: false),
              home: child,
            );
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.white,
              ),
              scaffoldBackgroundColor: AppColors.white,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
              ),
            ),
            initialRoute: RouteNames.splashScreen,
            navigatorKey: navigatorKey,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        ),
      ),
    );
  }
}
