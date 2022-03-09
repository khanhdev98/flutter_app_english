import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_style.dart';
import '../values/share_key.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(ShareKey.counter) ?? 5;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.secondColor,
          elevation: 0,
          centerTitle: true,
          title:
              Text('Your control', style: AppStyles.h3.copyWith(fontSize: 36)),
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setInt(ShareKey.counter, sliderValue.toInt());
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  AppAssets.arrowLeft,
                  color: AppColors.textColor,
                )),
          )),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            Text('How much a number word at once',
                style: AppStyles.h4
                    .copyWith(color: AppColors.lightGrey, fontSize: 18)),
            const Spacer(),
            Text('${sliderValue.toInt()}',
                style: AppStyles.h4.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 158,
                    fontWeight: FontWeight.bold)),
            Slider(
                value: sliderValue,
                min: 5,
                max: 100,
                divisions: 95,
                activeColor: AppColors.primaryColor,
                inactiveColor: AppColors.primaryColor,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                }),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Side to set',
                    style: AppStyles.h4.copyWith(
                        color: AppColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
