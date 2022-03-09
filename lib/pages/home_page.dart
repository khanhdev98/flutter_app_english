import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/models/english_today.dart';
import 'package:flutter_app_1/pages/all_words_page.dart';
import 'package:flutter_app_1/pages/control_page.dart';
import 'package:flutter_app_1/values/app_assets.dart';
import 'package:flutter_app_1/values/app_colors.dart';
import 'package:flutter_app_1/values/app_style.dart';
import 'package:flutter_app_1/values/share_key.dart';
import 'package:flutter_app_1/widgets/app_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  List<EnglishToday> words = [];

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnnglishToday() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    int? len = prefs.getInt(ShareKey.counter) ?? 5;
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: len, max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });
    setState(() {
      words = newList.map((e) => EnglishToday(noun: e)).toList();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnnglishToday();
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
          centerTitle: true,
          title: const Text('English today', style: AppStyles.h4),
          leading: InkWell(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: SvgPicture.asset(AppAssets.menu,
                  color: AppColors.textColor))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 1 / 10 * size.height,
            child: const Text(
                '"it is amazing how complete is the delusion that beauty is goodness."',
                style: AppStyles.h5),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 0.64 * size.height,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: words.length > 5 ? 6 : words.length,
              itemBuilder: (context, index) {
                String firstLetter =
                    words[index].noun != null ? words[index].noun! : '';
                firstLetter = firstLetter.substring(0, 1);
                String leftLetter =
                    words[index].noun != null ? words[index].noun! : '';
                leftLetter = leftLetter.substring(1, leftLetter.length);
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    color: AppColors.primaryColor,
                    elevation: 4,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: (() {}),
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: _currentIndex >= 5
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
                                  'Show more ...',
                                  style: AppStyles.h4.copyWith(
                                    color: Colors.white,
                                    fontSize: 38,
                                    shadows: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(3, 4),
                                          blurRadius: 10)
                                    ],
                                  ),
                                )),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                    size: 42,
                                    circleColor: CircleColor(
                                        start: Color(0xff00ddff),
                                        end: Color(0xff0099cc)),
                                    bubblesColor: BubblesColor(
                                      dotPrimaryColor: Color(0xff33b5e5),
                                      dotSecondaryColor: Color(0xff0099cc),
                                    ),
                                    likeBuilder: (bool isLiked) {
                                      return SvgPicture.asset(
                                        AppAssets.heart,
                                        color:
                                            isLiked ? Colors.red : Colors.white,
                                        // size: 42,
                                      );
                                    },
                                  ),
                                  RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        text: firstLetter,
                                        style: AppStyles.h1.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            const BoxShadow(
                                                color: Colors.black38,
                                                offset: Offset(3, 5),
                                                blurRadius: 6)
                                          ],
                                        ),
                                        children: [
                                          TextSpan(
                                            text: leftLetter,
                                            style: AppStyles.h2.copyWith(
                                              color: Colors.white,
                                              fontSize: 52,
                                              shadows: [
                                                const BoxShadow(
                                                  color: AppColors.primaryColor,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 24),
                                    child: Text(
                                      '"Think of all the beauty still left around you and be happy"',
                                      style: AppStyles.h4.copyWith(
                                          letterSpacing: 1.4,
                                          wordSpacing: 3,
                                          fontSize: 30),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(
                height: 14,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: ((context, index) {
                      return buildIndicator(index == _currentIndex, size);
                    }))),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            setState(() {
              getEnnglishToday();
            });
          },
          child: SvgPicture.asset(
            AppAssets.reset,
            width: 28,
            color: AppColors.textColor,
          )),
      drawer: Drawer(
        child: Container(
          color: AppColors.lightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16),
                child: Text('Your mind', style: AppStyles.h3),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 52),
                child: AppButton(label: 'Favorite', onTap: () {}),
              ),
              AppButton(
                  label: 'Your control',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ControlPage()));
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? size.width * 1 / 5 : 24,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: isActive ? AppColors.lightBlue : AppColors.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(3, 6), blurRadius: 6)
          ]),
    );
  }
}
