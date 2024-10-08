import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidjab_user/bloc/auth/auth_bloc.dart';
import 'package:hidjab_user/bloc/basket/basket_event.dart';
import 'package:hidjab_user/bloc/category/category_bloc.dart';
import 'package:hidjab_user/bloc/category/category_event.dart';
import 'package:hidjab_user/bloc/favourite/favourite_bloc.dart';
import 'package:hidjab_user/bloc/nabi/nabi_bloc.dart';
import 'package:hidjab_user/bloc/product/product_bloc.dart';
import 'package:hidjab_user/bloc/user/user_bloc.dart';
import 'package:hidjab_user/data/repo/auth_repository.dart';
import 'package:hidjab_user/data/repo/basket_repo.dart';
import 'package:hidjab_user/data/repo/category_repo.dart';
import 'package:hidjab_user/data/repo/favourite_repo.dart';
import 'package:hidjab_user/data/repo/product_repo.dart';
import 'package:hidjab_user/data/repo/user_repo.dart';
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
          create: (_) => FavouriteRepo(),
        ),
        RepositoryProvider(
          create: (_) => UserRepo(),
        ),
        RepositoryProvider(
          create: (_) => AuthRepository(),
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
            create: (context) => UserBloc(
              context.read<UserRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => FavouriteBloc(
              context.read<FavouriteRepo>(),
            )..add(
                ListenFavouritesEvent(
                  FirebaseAuth.instance.currentUser!.uid,
                ),
              ),
          ),
          BlocProvider(
            create: (context) => BasketBloc(
              context.read<BasketRepo>(),
            )..add(
                ListenBasketEvent(
                  ),
              ),
          ),
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
              userRepo: context.read<UserRepo>(),
            )..add(CheckAuthenticationEvent()),
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
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            initialRoute: RouteNames.splashScreen,
            navigatorKey: navigatorKey,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        ),
      ),
    );
  }
}
