import 'package:flutter/material.dart';
import 'package:hello_world/models/english_words.dart';
import 'package:hello_world/values/app_assets.dart';
import 'package:hello_world/values/app_colors.dart';
import 'package:hello_world/values/app_styles.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishWords> words;
  const AllWordsPage({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondColor,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(AppAssets.leftArrowIcon,
                    color: AppColors.textColor),
              )),
          title: Text("All Words",
              style: AppStyles.h4.copyWith(color: AppColors.textColor)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? AppColors.primaryColor
                      : AppColors.secondColor,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: ListTile(
                  leading: SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(AppAssets.heartIcon,
                        color:
                            words[index].isFavorite ? Colors.red : Colors.grey),
                  ),
                  title: Text(
                      '${words[index].noun![0].toUpperCase()}${words[index].noun!.substring(1)}',
                      style: AppStyles.h4.copyWith(
                          color: index % 2 == 0
                              ? AppColors.secondColor
                              : AppColors.textColor)),
                  subtitle: Text(words[index].quote ?? "",
                      style: AppStyles.h5.copyWith(color: AppColors.textColor)),
                ),
              );
            },
          ),
        ));
  }
}
