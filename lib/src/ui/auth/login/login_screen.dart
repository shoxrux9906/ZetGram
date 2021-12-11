import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxbus/rxbus.dart';
import 'package:zet_gram/src/dialog/bottom_dialog.dart';
import 'package:zet_gram/src/model/bus/loding_model.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/ui/menu/main_screen.dart';
import 'package:zet_gram/src/utils/styles.dart';
import 'package:zet_gram/src/utils/utils.dart';

import '../forgot_password_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  bool _obscureText = true;
  bool isHide = true;

  late FocusScopeNode currentFocus;

  @override
  void initState() {
    _registerBus();
    super.initState();
  }

  @override
  void dispose() {
    RxBus.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 25, top: 30),
            child: Text(
              "Username or Email",
              style: Styles.semiBoldLabel(AppTheme.dark),
            ),
          ),
          Container(
            child: Theme(
              data: ThemeData(
                accentColor: Color(0xFF327FEB),
                canvasColor: Colors.transparent,
                textTheme: AppTheme.textTheme,
                platform: Platform.isAndroid
                    ? TargetPlatform.android
                    : TargetPlatform.iOS,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 15, left: 25, right: 25),
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 3),
                width: MediaQuery.of(context).size.width,
                height: 56,
                decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        color: Color.fromRGBO(147, 147, 147, 0.1),
                        blurRadius: 75,
                        spreadRadius: 0,
                      )
                    ]),
                child: Center(
                  child: TextFormField(
                    style: Styles.semiBoldDisplay(AppTheme.dark),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your username or email",
                      hintStyle: Styles.regularDisplay(
                        AppTheme.grey80,
                      ),
                    ),
                    controller: usernameController,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 35, left: 25),
            child: Text(
              "Password",
              style: Styles.semiBoldLabel(AppTheme.dark),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 56,
            margin: EdgeInsets.only(left: 25, right: 25, top: 15),
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 3),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(147, 147, 147, 0.1),
                  offset: Offset(0, 10),
                  blurRadius: 75,
                  spreadRadius: 0,
                )
              ],
            ),
            child: TextFormField(
              style: Styles.semiBoldDisplay(AppTheme.dark),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter your password",
                hintStyle: Styles.regularDisplay(AppTheme.grey80),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isHide = !isHide;
                      _obscureText = !_obscureText;
                    });
                  },
                  child: isHide
                      ? SvgPicture.asset(
                          "assets/icons/eye_off.svg",
                          width: 24,
                          height: 24,
                          fit: BoxFit.scaleDown,
                        )
                      : SvgPicture.asset(
                          "assets/icons/eye.svg",
                          width: 24,
                          height: 24,
                          fit: BoxFit.scaleDown,
                        ),
                ),
              ),
              controller: passwordController,
              obscureText: _obscureText,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ForgotPasswordScreen();
                }),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 25, right: 25),
              child: Text(
                "Forgot Password?",
                style: Styles.regularDisplay(AppTheme.dark80),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (loading ||
                  usernameController.text.length > 0 &&
                      passwordController.text.length > 0) {
                print("Loading>>>>>>>>>");
                setState(() {
                  loading = true;
                });
                FocusScopeNode currentFocus = FocusScope.of(context);
                Timer(Duration(milliseconds: 1500), () {
                  Utils.isLogin(
                          usernameController.text, passwordController.text)
                      .then((value) => {
                            if (value)
                              {
                                setState(() {
                                  loading = false;
                                }),
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ),
                                ),
                              }
                            else
                              {
                                setState(() {
                                  loading = false;
                                }),
                                if (currentFocus.hasPrimaryFocus)
                                  {
                                    currentFocus.unfocus(),
                                  },
                                BottomDialog.sendComplain(
                                  context,
                                  "Login Failed",
                                  "You cannot login at the moment, check your internet connection and try again.",
                                  "Try Again",
                                ),
                              }
                          });
                });
              } else
                print("else>>>>>>>>>>>>>>>>>");
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56,
              margin: EdgeInsets.only(
                top: 30,
                right: 25,
                left: 25,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 6),
                      blurRadius: 75,
                      spreadRadius: 0,
                      color: Color.fromRGBO(100, 87, 87, 0.05))
                ],
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: loading
                    ? CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppTheme.white),
                      )
                    : Text(
                        "Login",
                        style: Styles.boldButton(AppTheme.white),
                      ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 32, right: 32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                line(),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Or login with",
                  style: Styles.regularDisplay(AppTheme.dark80),
                ),
                SizedBox(
                  width: 20,
                ),
                line(),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
              right: 25,
              left: 25,
              bottom: 70,
            ),
            width: MediaQuery.of(context).size.width,
            height: 56,
            decoration: BoxDecoration(
                color: AppTheme.white, borderRadius: BorderRadius.circular(28)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/google_icon.svg"),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "Google",
                  style: Styles.boldButton(AppTheme.dark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _registerBus() async {
    RxBus.register<LoadingModel>(tag: "EVENT_LOADING_LOGIN").listen((event) {
      if (!event.loading) {
        if (loading &&
            usernameController.text.length > 0 &&
            passwordController.text.length > 0) {
          setState(() {
            loading = true;
          });
          Timer(Duration(milliseconds: 1500), () {
            Utils.isLogin(usernameController.text, passwordController.text)
                .then(
              (value) => {
                if (value)
                  {
                    setState(() {
                      loading = false;
                    }),
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                    ),
                  }
                else
                  {
                    setState(() {
                      loading = false;
                    }),
                    if (currentFocus.hasPrimaryFocus)
                      {
                        currentFocus.unfocus(),
                      },
                    BottomDialog.sendComplain(
                      context,
                      "Login Failed",
                      "You cannot login at the moment, check your internet connection and try again.",
                      "Try Again",
                    ),
                  }
              },
            );
          });
        }
      }
    });
  }

  Widget line() {
    return Expanded(
      child: Container(
        height: 1,
        color: AppTheme.grey60,
      ),
    );
  }
}
