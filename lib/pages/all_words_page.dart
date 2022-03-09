import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/models/english_today.dart';
import 'package:flutter_svg/svg.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_style.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWordsPage({Key? key, required this.words}) : super(key: key);

  get isfavorite => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
          backgroundColor: AppColors.secondColor,
          elevation: 0,
          centerTitle: true,
          title: const Text('English today', style: AppStyles.h4),
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(AppAssets.arrowLeft,
                    color: AppColors.textColor)),
          )),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
              itemCount: words.length,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(words[index].noun!),
                    subtitle: Text(
                        '"Think of all the beauty still left around you and be happy"'),
                    leading: Icon(Icons.favorite,
                        color:
                            words[index].isFavorite ? Colors.red : Colors.grey),
                  ),
                );
              })),
    );
  }
}
