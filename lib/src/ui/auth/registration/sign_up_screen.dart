import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zet_gram/src/dialog/bottom_dialog.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/ui/menu/main_screen.dart';
import 'package:zet_gram/src/utils/styles.dart';
import 'package:zet_gram/src/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool _obscureText = true;
  bool loading = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 50,
              left: 25,
              right: 25,
            ),
            child: Text(
              "Username",
              style: Styles.semiBoldLabel(AppTheme.dark),
            ),
          ),
          Theme(
            data: ThemeData(
              accentColor: Color(0xFF327FEB),
              canvasColor: Colors.transparent,
              platform: Platform.isAndroid
                  ? TargetPlatform.android
                  : TargetPlatform.iOS,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56,
              margin: EdgeInsets.only(
                top: 15,
                left: 25,
                right: 25,
              ),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 3),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    color: Color.fromRGBO(147, 147, 147, 0.1),
                    blurRadius: 75,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Create your username",
                    hintStyle: Styles.regularDisplay(AppTheme.grey80),
                    border: InputBorder.none,
                  ),
                  controller: _usernameController,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 35,
              left: 25,
              right: 25,
            ),
            child: Text(
              "Email",
              style: Styles.semiBoldLabel(AppTheme.dark),
            ),
          ),
          Theme(
            data: ThemeData(
              accentColor: Color(0xFF327FEB),
              canvasColor: Colors.transparent,
              platform: Platform.isAndroid
                  ? TargetPlatform.android
                  : TargetPlatform.iOS,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56,
              margin: EdgeInsets.only(
                top: 15,
                left: 25,
                right: 25,
              ),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 3),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    color: Color.fromRGBO(147, 147, 147, 0.1),
                    blurRadius: 75,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: Styles.regularDisplay(AppTheme.grey80),
                    border: InputBorder.none,
                  ),
                  controller: _emailController,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 35,
              left: 25,
              right: 25,
            ),
            child: Text(
              "Password",
              style: Styles.semiBoldLabel(AppTheme.dark),
            ),
          ),
          Theme(
            data: ThemeData(
              accentColor: Color(0xFF327FEB),
              canvasColor: Colors.transparent,
              platform: Platform.isAndroid
                  ? TargetPlatform.android
                  : TargetPlatform.iOS,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56,
              margin: EdgeInsets.only(
                top: 15,
                left: 25,
                right: 25,
              ),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 3),
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
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "Create your password",
                    hintStyle: Styles.regularDisplay(AppTheme.grey80),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: _toggle,
                      child: _obscureText
                          ? SvgPicture.asset(
                              "assets/icons/eye.svg",
                              width: 24,
                              height: 24,
                              fit: BoxFit.scaleDown,
                            )
                          : SvgPicture.asset(
                              "assets/icons/eye_off.svg",
                              width: 24,
                              height: 24,
                              fit: BoxFit.scaleDown,
                            ),
                    ),
                  ),
                  controller: _passwordController,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!loading &&
                  _usernameController.text.length > 0 &&
                  _emailController.text.length > 0 &&
                  _passwordController.text.length > 8) {
                setState(() {
                  loading = true;
                });

                Timer(
                  Duration(milliseconds: 1500),
                  () {
                    Utils.saveData(
                      _usernameController.text,
                      _passwordController.text,
                      _emailController.text,
                    );
                  },
                );

                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }

                setState(() {
                  loading = false;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return MainScreen();
                  }),
                );
              } else {
                BottomDialog.sendComplain(
                  context,
                  "Password to Weak",
                  "Password must be at least 8 character long and must contain at least 1 number.",
                  "Sign Up",
                );
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56,
              margin: EdgeInsets.only(
                top: 50,
                left: 25,
                right: 25,
                bottom: 90,
              ),
              decoration: BoxDecoration(
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
                        "Sign Up",
                        style: Styles.boldButton(AppTheme.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
