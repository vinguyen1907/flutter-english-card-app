// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hello_world/values/app_assets.dart';
import 'package:hello_world/values/app_colors.dart';
import 'package:hello_world/values/app_styles.dart';
import 'package:hello_world/values/share_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    super.initState();
    _getSliderValue();
  }

  _getSliderValue() async {
    prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(ShareKeys.counter) ?? 5;
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
          title: Text("Your Control",
              style: AppStyles.h4.copyWith(
                color: AppColors.textColor,
              )),
          leading: InkWell(
              onTap: () async {
                await prefs.setInt(ShareKeys.counter, sliderValue.toInt());
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(AppAssets.leftArrowIcon),
              )),
        ),
        body: SizedBox(
            width: double.infinity,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Text(
                  'How many words do you want to learn once?',
                  style: AppStyles.h5.copyWith(
                    color: AppColors.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              Text('${sliderValue.toInt()}',
                  style: AppStyles.h5.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 150,
                      fontWeight: FontWeight.bold)),
              Slider(
                  value: sliderValue,
                  min: 5,
                  max: 100,
                  divisions: 95,
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.primaryColor,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      sliderValue = value;
                    });
                  }),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'slide to set',
                    style: AppStyles.h5.copyWith(
                      color: AppColors.lightGrey,
                      fontSize: 16,
                    ),
                  )),
            ])));
  }
}
