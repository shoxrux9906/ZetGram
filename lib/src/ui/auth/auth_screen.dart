import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/ui/auth/registration/sign_up_screen.dart';
import 'package:zet_gram/src/utils/styles.dart';


import 'login/login_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  PageController? _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Container(
              child: Center(
                child: Image.asset(
                  "assets/images/logo_primary.png",
                  width: 64,
                  height: 64,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 28, top: 40, right: 28),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (currentIndex != 0) {
                          setState(() {
                            currentIndex = 0;
                            _pageController!.animateToPage(
                              0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        }
                      },
                      child: Column(
                        children: [
                          Text(
                            "Log in",
                            style: currentIndex == 0
                                ? Styles.boldH3(AppTheme.dark)
                                : Styles.boldH3(AppTheme.grey),
                          ),
                          AnimatedContainer(
                            margin: EdgeInsets.only(top: 4),
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: currentIndex == 0
                                  ? AppTheme.primary
                                  : AppTheme.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 46,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (currentIndex != 1) {
                          setState(() {
                            currentIndex = 1;
                            _pageController!.animateToPage(
                              1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        }
                      },
                      child: Column(
                        children: [
                          Text(
                            "Sign Up",
                            style: currentIndex == 1
                                ? Styles.boldH3(AppTheme.dark)
                                : Styles.boldH3(AppTheme.grey),
                          ),
                          AnimatedContainer(
                            margin: EdgeInsets.only(top: 4),
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: currentIndex == 1
                                  ? AppTheme.primary
                                  : AppTheme.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Expanded(
              child: PageView(
                onPageChanged: (int page){
                  setState(() {
                    currentIndex = page;
                  });
                },
                controller: _pageController,
                children: [
                  LoginScreen(),
                  SignUpScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
