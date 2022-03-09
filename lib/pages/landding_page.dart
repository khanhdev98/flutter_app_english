import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_1/values/app_style.dart';
import 'package:flutter_svg/svg.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';
import 'home_page.dart';

class landingPage extends StatelessWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: const Text('Welcome to', style: AppStyles.h3),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 34, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'English',
                        style: AppStyles.h2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackGrey),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        'Quotes"',
                        textAlign: TextAlign.right,
                        style: AppStyles.h3.copyWith(height: 0.5, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: RawMaterialButton(
                    shape: const CircleBorder(),
                    fillColor: AppColors.lightBlue,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => homePage()),
                          (route) => false);
                    },
                    child: SvgPicture.asset(AppAssets.arrowRight,
                        height: 40, color: AppColors.textColor),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
