import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/utils/styles.dart';
import 'package:zet_gram/src/utils/utils.dart';

import 'code_verify_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailController = new TextEditingController();
  bool loading = false;

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
            )),
        title: Text(
          "Forgot Password",
          style: Styles.boldH4(AppTheme.dark),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 51,
          ),
          Center(
            child: Image.asset(
              "assets/images/logo_primary.png",
              width: 64,
              height: 64,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 50,
              left: 25,
              right: 25,
            ),
            child: Text(
              "Enter your email for the verification proccess, and we will send 4 digits code to your email for the verification.",
              style: Styles.regularLabel(
                AppTheme.dark_label,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 25,
              top: 52,
            ),
            child: Text(
              "Email",
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
                  style: Styles.semiBoldDisplay(AppTheme.dark),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your email",
                    hintStyle: Styles.regularDisplay(
                      AppTheme.grey80,
                    ),
                  ),
                  controller: _emailController,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!loading && _emailController.text.length > 0) {
                setState(() {
                  loading = true;
                });
              }

              FocusScopeNode currentFocus = FocusScope.of(context);
              Timer(Duration(milliseconds: 1500), () {
                setState(() {
                  loading = false;
                });
              });

              Utils.isMail(_emailController.text).then(
                (value) => {
                  if (value)
                    {
                      if (currentFocus.hasPrimaryFocus)
                        {
                          currentFocus.unfocus(),
                        },
                      _emailController.text = "",
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CodeVerifyScreen(),
                        ),
                      ),
                    }
                },
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56,
              margin: EdgeInsets.only(
                top: 30,
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
                        "Continue",
                        style: Styles.boldButton(AppTheme.white),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
