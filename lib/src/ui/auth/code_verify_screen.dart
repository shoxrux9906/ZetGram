import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zet_gram/src//theme/app_theme.dart';
import 'package:zet_gram/src//ui/auth/pinput/pinput.dart';
import 'package:zet_gram/src//ui/auth/reset_screen.dart';
import 'package:zet_gram/src//utils/styles.dart';

class CodeVerifyScreen extends StatefulWidget {
  @override
  _CodeverifyScreenState createState() => _CodeverifyScreenState();
}

class _CodeverifyScreenState extends State<CodeVerifyScreen> {
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: AppTheme.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Color.fromRGBO(169, 169, 169, 0.6),
      width: 1,
    ),
  );
  final _pinPutFocusNode = FocusNode();
  final _pinPutController = TextEditingController();
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
          ),
        ),
        title: Text(
          "Code verification",
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
              "Enter the 4 digits code that you received on your email so you can continue to reset your account password.",
              style: Styles.regularLabel(
                AppTheme.dark_label,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 52,
              left: 40,
              right: 40,
            ),
            child: PinPut(
              eachFieldWidth: 50.0,
              eachFieldHeight: 61.0,
              withCursor: true,
              fieldsCount: 4,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              eachFieldMargin: EdgeInsets.symmetric(horizontal: 10),
              onSubmit: (String pin) => _showSnackBar(pin),
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.scale,
              textStyle: Styles.boldH2(AppTheme.dark),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!loading && _pinPutController.text.length == 4) {
                setState(() {
                  loading = true;
                });
                Timer(
                  Duration(milliseconds: 1500),
                  () {
                    _pinPutController.text = "";
                    _pinPutFocusNode.unfocus();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ResetScreen();
                      }),
                    );
                  },
                );
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
                        "Continue",
                        style: Styles.boldButton(AppTheme.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String pin) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: AppTheme.dark,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
