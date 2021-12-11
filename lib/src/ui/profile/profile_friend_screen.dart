import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/utils/styles.dart';

class ProfileFriendScreen extends StatefulWidget {
  const ProfileFriendScreen({Key? key}) : super(key: key);

  @override
  _ProfileFriendScreenState createState() => _ProfileFriendScreenState();
}

class _ProfileFriendScreenState extends State<ProfileFriendScreen> {
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
                        "Profile",
                        style: Styles.boldH1(AppTheme.dark),
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/more_vertical.svg",
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 35,
                    left: 25,
                    right: 25,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(86),
                        child: Image.asset(
                          "assets/images/profile_friend.png",
                          width: 86,
                          height: 86,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
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
