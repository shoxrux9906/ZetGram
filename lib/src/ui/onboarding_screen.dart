import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zet_gram/src//theme/app_theme.dart';
import 'package:zet_gram/src//utils/styles.dart';

import 'auth/auth_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: [
                createPage(
                  image: "assets/images/img1.png",
                  title: "We Connect People",
                  content:
                      "Connecting people trough one platform to share the memories together.",
                  index: 0,
                ),
                createPage(
                  image: "assets/images/img2.png",
                  title: "Sharing Happiness",
                  content:
                      "Sharing happiness by sharing your memories in Zelio platform.",
                  index: 1,
                ),
                createPage(
                  image: "assets/images/img3.png",
                  title: "Last Long Memories",
                  content:
                      "You can store memories of your photos in Zelio app without limit.",
                  index: 2,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Row(
              children: [
                Row(
                  children: _buildIndicator(),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    if (currentIndex == 0) {
                      setState(() {
                        currentIndex = 1;
                        _pageController.animateToPage(
                          1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      });
                    } else if (currentIndex == 1) {
                      setState(() {
                        currentIndex = 2;
                        _pageController.animateToPage(2,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      });
                    } else if (currentIndex == 2) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AuthScreen()),
                      );
                    }
                  },
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    duration: Duration(milliseconds: 300),
                    width: currentIndex == 2 ? 150 : 124,
                    height: 56,
                    child: Center(
                      child: currentIndex == 2
                          ? Text(
                              "Get Started",
                              style: Styles.boldButton(AppTheme.white),
                            )
                          : Text(
                              "Next",
                              style: Styles.boldButton(AppTheme.white),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget createPage({image, title, content, index}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                index == 0 ? 50 : 0,
              ),
              bottomRight: Radius.circular(
                index == 2 ? 50 : 0,
              ),
            ),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50, left: 25, right: 25),
          child: Text(
            title,
            style: Styles.boldH2(
              AppTheme.dark,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 18, left: 25, right: 25),
          child: Text(
            content,
            style: Styles.regularLabel(
              AppTheme.dark80,
            ),
          ),
        )
      ],
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300),
      width: isActive ? 28 : 9,
      height: 9,
      margin: EdgeInsets.only(
        right: 15,
      ),
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primary : AppTheme.grey40,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
