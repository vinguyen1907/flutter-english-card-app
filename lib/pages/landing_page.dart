// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hello_world/pages/home_page.dart';
import 'package:hello_world/values/app_assets.dart';
import 'package:hello_world/values/app_colors.dart';
import 'package:hello_world/values/app_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Welcome to", style: AppStyles.h3),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("English",
                          style: AppStyles.h2
                              .copyWith(fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text('Quotes"',
                            textAlign: TextAlign.right,
                            style: AppStyles.h4.copyWith(height: 0.5)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 80),
                child: RawMaterialButton(
                    shape: CircleBorder(),
                    fillColor: AppColors.lightBlue,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage()),
                          (route) => false);
                    },
                    child: Container(
                        height: 80,
                        width: 80,
                        padding: EdgeInsets.all(20),
                        child: Image.asset(AppAssets.rightArrowIcon))),
              ))
            ])));
  }
}
