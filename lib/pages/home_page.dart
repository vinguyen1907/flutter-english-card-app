import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/packages/quote/quote_model.dart';
import 'package:hello_world/pages/all_words_page.dart';
import 'package:hello_world/values/app_assets.dart';
import 'package:hello_world/values/app_colors.dart';
import 'package:hello_world/values/app_styles.dart';
import 'package:hello_world/widgets/app-button.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/english_words.dart';
import '../packages/quote/quote.dart';
import '../values/share_keys.dart';
import 'control_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late int length = 5;
  late PageController _pageController = PageController();

  List<EnglishWords> words = [];

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }

    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int randomNumber = random.nextInt(max) + min;
      if (!newList.contains(randomNumber)) {
        newList.add(randomNumber);
        count++;
      }
    }
    return newList; // list index
  }

  getEnglishWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    length = prefs.getInt(ShareKeys.counter) ?? 5;
    print(length);

    List<String> newList = [];
    List<int> randomList = fixedListRandom(len: length, max: nouns.length);
    randomList.forEach((index) {
      // index ~ item
      newList.add(nouns[index]);
    });

    setState(() {
      words = newList.map((item) => getQuote(item)).toList();
    });
  }

  EnglishWords getQuote(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishWords(
      noun: noun,
      quote: quote?.content,
      id: quote?.id,
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getEnglishWords();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(AppAssets.menuIcon),
            )),
        title: Text('English today',
            style: AppStyles.h4.copyWith(
                color: AppColors.textColor, fontWeight: FontWeight.bold)),
      ),
      body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            Container(
              height: size.height / 10,
              padding: const EdgeInsets.all(16),
              child: Text(
                  "It is amazing how to complete is the declusion that beauty is goodness.",
                  style: AppStyles.h5
                      .copyWith(fontSize: 14, color: AppColors.textColor)),
            ),
            SizedBox(
                height: size.height * 2 / 3,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: words.length > 5 ? 6 : words.length,
                  itemBuilder: (context, index) {
                    String word =
                        words[index].noun != null ? words[index].noun! : '';

                    String firstLetter = word.substring(0, 1);

                    String leftLetter = word.substring(1, word.length);

                    String defaultQuote =
                        '"Think of all the beauty style left around you and be happy"';

                    String quote = words[index].quote != null
                        ? words[index].quote!
                        : defaultQuote;

                    return Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: index >= 5
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              AllWordsPage(words: words)));
                                },
                                child: Center(
                                  child: Text(
                                    'Show more...',
                                    style: AppStyles.h4
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              )
                            : Column(children: [
                                LikeButton(
                                  onTap: (bool isLiked) async {
                                    setState(() {
                                      words[index].isFavorite =
                                          !words[index].isFavorite;
                                    });
                                    return words[index].isFavorite;
                                  },
                                  isLiked: words[index].isFavorite,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  size: 40,
                                  circleColor: CircleColor(
                                      start: Colors.grey, end: Colors.red),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return ImageIcon(
                                      const AssetImage(AppAssets.heartIcon),
                                      color: isLiked ? Colors.red : Colors.grey,
                                      size: 40,
                                    );
                                  },
                                ),
                                // Container(
                                //   alignment: Alignment.centerRight,
                                //   child: SizedBox(
                                //       height: 50,
                                //       width: 50,
                                //       child: Image.asset(AppAssets.heartIcon)),
                                // ),
                                RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                      text: firstLetter.toUpperCase(),
                                      style: const TextStyle(
                                          fontFamily: FontFamily.sen,
                                          fontSize: 89,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(3, 6),
                                              blurRadius: 6,
                                            )
                                          ]),
                                      children: [
                                        TextSpan(
                                          text: leftLetter,
                                          style: const TextStyle(
                                            fontFamily: FontFamily.sen,
                                            fontSize: 56,
                                            fontWeight: FontWeight.bold,
                                            // shadows: [
                                            //   BoxShadow(
                                            //     color: Colors.black38,
                                            //     offset: Offset(3, 6),
                                            //     blurRadius: 6,
                                            //   )
                                            // ]
                                          ),
                                        )
                                      ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text('"$quote"',
                                      style: AppStyles.h4
                                          .copyWith(letterSpacing: 3)),
                                ),

                                //indicator
                              ]));
                  },
                )),
            Container(
              height: 3,
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: length,
                itemBuilder: (context, index) {
                  return buildIndicator(index == _currentIndex, size);
                },
              ),
            )
          ])),
      drawer: Drawer(
          child: Container(
              color: AppColors.lightBlue,
              child: Column(children: [
                Container(
                  color: Colors.white,
                  height: size.height / 15,
                  width: size.width,
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    'Your mind',
                    textAlign: TextAlign.center,
                    style: AppStyles.h3.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DrawerButton(
                      label: 'Favorites',
                      onTap: () {
                        print("Favorites");
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DrawerButton(
                      label: 'Your control',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ControlPage()));
                      }),
                ),
              ]))),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            setState(() {
              getEnglishWords();
            });
          },
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(AppAssets.exchangeIcon))),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: isActive ? (size.width / 5) : (size.width / length),
      decoration: BoxDecoration(
        color: isActive ? Colors.lightBlue : AppColors.lightGrey,
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),
    );
  }
}
