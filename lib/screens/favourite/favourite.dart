import 'package:flutter/material.dart';
import 'package:hidjab_user/utils/styles/app_text_style.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite",style: AppTextStyle.width600,),

      ),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}
