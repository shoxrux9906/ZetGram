import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zet_gram/src/bloc/profile_block.dart';
import 'package:zet_gram/src/theme/app_theme.dart';
import 'package:zet_gram/src/ui/menu/profile/settings_screen.dart';
import 'package:zet_gram/src/utils/styles.dart';
import 'dart:io' as Io;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    profileBlock.fetchAllProfile();
    // profileBlock.fetchAllProfileFriend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppTheme.screen,
      body: Column(
        children: [
          Container(
            height: 96,
            color: AppTheme.white,
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 20,
            ),
            child: Column(
              children: [
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Profile",
                        style: Styles.boldH1(AppTheme.dark),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SettingsScreen();
                              },
                            ),
                          );
                        },
                        child: SvgPicture.asset("assets/icons/settings.svg")),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: Theme(
            data: ThemeData(
              accentColor: Color(0xFF327FAB),
              canvasColor: Colors.transparent,
              textTheme: AppTheme.textTheme,
              platform: TargetPlatform.iOS,
            ),
            child: StreamBuilder(
              stream: profileBlock.allProfile,
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 35,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 86,
                              height: 86,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(86),
                                    child: Image.asset(
                                      "assets/images/messi.png",
                                      width: 86,
                                      height: 86,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppTheme.white,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(36),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(
                                          5.0,
                                        ),
                                        decoration: BoxDecoration(
                                            color: AppTheme.primary,
                                            borderRadius:
                                                BorderRadius.circular(36.0)),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/icons/camera.svg",
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Shoxrux Quroqov",
                                    style: Styles.boldH3(AppTheme.dark),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "@shoxruxquroqov",
                                    style:
                                        Styles.semiBoldLabel(AppTheme.dark80),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Tashkent, Uzbekistan",
                                    style:
                                        Styles.regularContent(AppTheme.dark60),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 31,
                        ),
                        height: 92,
                        padding:
                            EdgeInsets.symmetric(vertical: 17, horizontal: 0),
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "1230",
                                    style: Styles.boldH3(AppTheme.dark),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Likes",
                                    style:
                                        Styles.regularContent(AppTheme.dark80),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "21224",
                                    style: Styles.boldH3(AppTheme.dark),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Followers",
                                    style:
                                        Styles.regularContent(AppTheme.dark80),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "34290",
                                    style: Styles.boldH3(AppTheme.dark),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Following",
                                    style:
                                        Styles.regularContent(AppTheme.dark80),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      StaggeredGridView.countBuilder(
                        itemCount: snapshot.data!.length,
                        crossAxisCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return showImage(snapshot.data![index]);
                        },
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(2),
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 25,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ],
                  );
                }
                return Shimmer.fromColors(
                  baseColor: AppTheme.shimmerBase,
                  highlightColor: AppTheme.shimmerHighlight,
                  child: ListView(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 35),
                        height: 86,
                        child: Row(
                          children: [
                            Container(
                              width: 86,
                              height: 86,
                              decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: BorderRadius.circular(86)),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: AppTheme.white,
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 12,
                                      right: 75,
                                    ),
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: AppTheme.white,
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 25,
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 25),
                              height: 56,
                              width: 92,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: AppTheme.screen,
                                border: Border.all(
                                  color: AppTheme.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      StaggeredGridView.countBuilder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                          top: 25,
                          bottom: 40,
                        ),
                        itemCount: 25,
                        crossAxisCount: 4,
                        itemBuilder: (context, index) {
                          Random random = new Random();
                          return Container(
                            height: (random.nextInt(70) + 150).toDouble(),
                            decoration: BoxDecoration(
                                color: AppTheme.white,
                                borderRadius: BorderRadius.circular(10)),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.fit(2),
                        mainAxisSpacing: 25,
                        crossAxisSpacing: 25,
                      ),
                    ],
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }

  Widget showImage(String image) {
    var file = Io.File(image);
    return ClipRRect(
      child: Image.file(
        file,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  @override
  bool get wantKeepAlive {
    return true;
  }
}
