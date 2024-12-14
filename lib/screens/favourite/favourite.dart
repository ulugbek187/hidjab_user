import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidjab_user/bloc/favourite/favourite_bloc.dart';
import 'package:hidjab_user/data/form_status/form_status.dart';
import 'package:hidjab_user/utils/styles/app_text_style.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<FavouriteBloc>().add(
            ListenFavouritesEvent(
              FirebaseAuth.instance.currentUser!.uid,
            ),
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourite",
          style: AppTextStyle.width600.copyWith(
            color: Colors.red,
            fontSize: 18.w,
          ),
        ),
      ),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          if (state.formsStatus == FormsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.formsStatus == FormsStatus.error) {
            return Center(
              child: Text(
                state.errorText,
                style: AppTextStyle.width600.copyWith(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            );
          }
          if (state.formsStatus == FormsStatus.success) {
            return ListView(
              children: [
                ...List.generate(
                  state.allFavourites.length,
                  (index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.black,width: 2.w),
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 10.w,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(
                              4.w,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2.w
                              ),
                              borderRadius: BorderRadius.circular(12.w),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.w),
                              child: Image.network(
                                  state.allFavourites[index].imageUrl,
                                  height: 120.h,
                                  width: 120.w),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                state.allFavourites[index].productName,
                                style: AppTextStyle.width600,
                              ),
                              Text(
                                "${state.allFavourites[index].price.toString()} Cум",
                                style: AppTextStyle.width600,
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              context.read<FavouriteBloc>().add(
                                    DeleteFromFavouritesEvent(
                                      state.allFavourites[index].docId,
                                    ),
                                  );
                            },
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      ),
                    );
                    // Image.network(state.allFavourites[index].imageUrl);
                  },
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
