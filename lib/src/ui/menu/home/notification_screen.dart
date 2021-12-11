import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/utils/styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Column(
        children: [
          Container(
            color: AppTheme.white,
            height: 96,
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 20,
            ),
            child: Column(
              children: [
                Expanded(child: Container()),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/arrow_left.svg"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      "Notifications",
                      style: Styles.boldH1(AppTheme.dark),
                    )),
                    SvgPicture.asset("assets/icons/more_vertical.svg")
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/failed.svg',
                  color: AppTheme.dark,
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Notification Empty",
                  style: Styles.boldH2(AppTheme.dark),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 27, right: 27),
                  child: Text(
                    "There are no notifications in this account, let’s discover and take a look this later.",
                    style: Styles.regularLabel(AppTheme.dark80),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
