import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/utils/styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _privateAccount = true;
  bool _notification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Column(
        children: [
          Container(
            color: AppTheme.white,
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
            height: 96,
            child: Column(
              children: [
                Spacer(),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset("assets/icons/arrow_left.svg")),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        "Settings",
                        style: Styles.boldH1(AppTheme.dark),
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/more_vertical.svg",
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 25,
              ),
              children: [
                Text(
                  "Account",
                  style: Styles.boldH4(AppTheme.dark),
                ),
                SizedBox(
                  height: 25,
                ),
                container1("Personal Information"),
                SizedBox(
                  height: 20,
                ),
                container1("Language"),
                SizedBox(
                  height: 20,
                ),
                container1("Liked Post"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Preferences",
                  style: Styles.boldH4(AppTheme.dark),
                ),
                SizedBox(
                  height: 25,
                ),
                container2("Notification"),
                SizedBox(
                  height: 20,
                ),
                container1("Actions"),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Security",
                  style: Styles.boldH4(AppTheme.dark),
                ),
                SizedBox(
                  height: 25,
                ),
                container3("Private Account"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget container1(String title) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(
        left: 23,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: Styles.boldLabel(AppTheme.dark),
            ),
          ),
          SvgPicture.asset("assets/icons/arrow_right.svg")
        ],
      ),
    );
  }

  Widget container2(String title) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(
        left: 23,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: Styles.boldLabel(AppTheme.dark),
            ),
          ),
          FlutterSwitch(
              height: 24,
              width: 45,
              activeColor: AppTheme.primary,
              inactiveColor: AppTheme.grey40,
              toggleColor: AppTheme.white,
              toggleSize: 16,
              value: _privateAccount,
              onToggle: (val) {
                setState(() {
                  _privateAccount = val;
                });
              })
        ],
      ),
    );
  }

  Widget container3(String title) {
    return Container(
      height: 56,
      padding: EdgeInsets.only(
        left: 23,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: Styles.boldLabel(AppTheme.dark),
            ),
          ),
          FlutterSwitch(
              height: 24,
              width: 45,
              activeColor: AppTheme.primary,
              inactiveColor: AppTheme.grey40,
              toggleColor: AppTheme.white,
              toggleSize: 16,
              value: _notification,
              onToggle: (val) {
                setState(() {
                  _notification = val;
                });
              })
        ],
      ),
    );
  }
}
