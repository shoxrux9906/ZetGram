import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zet_gram/src//theme/app_theme.dart';
import 'package:zet_gram/src//utils/styles.dart';
import 'package:zet_gram/src//utils/utils.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordConfirmController =
      new TextEditingController();
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool loading = false;

  void _toggle() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.screen,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/icons/arrow_left.svg",
              width: 28,
              height: 28,
              fit: BoxFit.scaleDown,
            ),
          ),
          title: Text(
            "Reset Password",
            style: Styles.boldH4(AppTheme.dark),
          ),
        ),
        backgroundColor: AppTheme.screen,
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 51),
              child: Center(
                child: Image.asset(
                  "assets/images/logo_primary.png",
                  width: 64,
                  height: 64,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 50,
                right: 25,
                left: 25,
              ),
              child: Text(
                "Set your new password for your account so you can login and access all the features in Zelio App.",
                style: Styles.regularLabel(
                  AppTheme.dark_label,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 25,
                top: 52,
              ),
              child: Text(
                "Password",
                style: Styles.semiBoldLabel(AppTheme.dark),
                textAlign: TextAlign.left,
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
                    obscureText: _obscureText1,
                    style: Styles.semiBoldDisplay(AppTheme.dark),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your password",
                      hintStyle: Styles.regularDisplay(
                        AppTheme.grey80,
                      ),
                    ),
                    controller: _passwordController,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 25,
                top: 52,
              ),
              child: Text(
                "Confirm Password",
                style: Styles.semiBoldLabel(AppTheme.dark),
                textAlign: TextAlign.left,
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
                    obscureText: _obscureText2,
                    style: Styles.semiBoldDisplay(AppTheme.dark),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your password",
                      hintStyle: Styles.regularDisplay(
                        AppTheme.grey80,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: _toggle,
                        child: _obscureText2
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
                    controller: _passwordConfirmController,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!loading &&
                    _passwordController.text.length > 0 &&
                    _passwordConfirmController.text.length > 0 &&
                    (_passwordController.text ==
                        _passwordConfirmController.text)) {
                  Timer(Duration(milliseconds: 1500), () {
                    setState(() {
                      loading = false;
                    });

                    Utils.savePassword(_passwordController.text);
                    Navigator.popUntil(context, (route) => route.isFirst);
                  });
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 56,
                margin: EdgeInsets.only(
                  top: 45,
                  right: 25,
                  left: 25,
                  bottom: 70,
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
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.white,
                          ),
                        )
                      : Text(
                          "Reset Password",
                          style: Styles.boldButton(AppTheme.white),
                        ),
                ),
              ),
            ),
          ],
        ));
  }
}
